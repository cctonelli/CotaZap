import 'package:cota_zap/core/services/quota_service.dart';
import 'package:cota_zap/core/utils/app_logger.dart';
import 'package:cota_zap/core/utils/whatsapp_helpers.dart';
import 'package:cota_zap/drift/daos/contacts_dao.dart';
import 'package:cota_zap/drift/database.dart';
import 'package:cota_zap/features/quotation/domain/repositories/quotation_repository.dart';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart';

class SendQuotationParams {
  final String ownerId;
  final String plan;
  final Map<Product, double> selectedProducts;
  final List<int> selectedSupplierIds;
  final String deliveryType;
  final int leadTimeDefault;
  final int paymentTermDays;
  final String paymentCondition;

  SendQuotationParams({
    required this.ownerId,
    required this.plan,
    required this.selectedProducts,
    required this.selectedSupplierIds,
    required this.deliveryType,
    required this.leadTimeDefault,
    required this.paymentTermDays,
    required this.paymentCondition,
  });
}

class SendQuotationUseCase {
  final QuotationRepository quotationRepository;
  final ContactsDao contactsDao;
  final QuotaService quotaService;
  final Dio dio;

  SendQuotationUseCase({
    required this.quotationRepository,
    required this.contactsDao,
    required this.quotaService,
    required this.dio,
  });

  Future<int> call(SendQuotationParams params) async {
    // 1. Validar quotas antes de qualquer ação
    final buyer = await contactsDao.getFirstBuyer(params.ownerId);
    if (buyer == null) {
      throw Exception('Perfil de comprador não encontrado. Cadastre seus dados em "Meu Perfil".');
    }

    final canSendQuotation = await quotaService.canPerformAction(params.ownerId, params.plan, QuotaType.quotations);
    if (!canSendQuotation) {
      throw Exception('Limite diário de cotações atingido no seu plano (${params.plan}).');
    }

    final canSendWhatsApp = await quotaService.canPerformAction(params.ownerId, params.plan, QuotaType.whatsappMessages);
    if (!canSendWhatsApp) {
      throw Exception('Limite diário de mensagens WhatsApp atingido no seu plano (${params.plan}).');
    }

    // 2. Preparar mensagem
    final productListBuffer = StringBuffer();
    for (var entry in params.selectedProducts.entries) {
      final qtyStr = WhatsAppHelpers.formatQuantity(entry.value);
      productListBuffer.writeln('• $qtyStr ${entry.key.unitMeasure} x ${entry.key.description}');
    }
    final productList = productListBuffer.toString().trim();

    // 3. Criar Cotação Localmente
    final quotationId = await quotationRepository.createQuotation(
      QuotationsCompanion(
        buyerId: Value(params.ownerId),
        date: Value(DateTime.now()),
        status: const Value('sent'),
        templateMessage: Value(_generateBaseTemplate()), // Ou um template customizável futuramente
        defaultPaymentTermDays: Value(params.paymentTermDays),
        defaultPaymentCondition: Value(params.paymentCondition),
        defaultLeadTimeDays: Value(params.leadTimeDefault),
        defaultDeliveryType: Value(params.deliveryType),
      ),
    );

    // 4. Criar Itens
    final List<QuotationItem> createdItems = [];
    for (var entry in params.selectedProducts.entries) {
      await quotationRepository.insertItem(
        QuotationItemsCompanion(
          quotationId: Value(quotationId),
          productId: Value(entry.key.id),
          quantity: Value(entry.value),
          paymentTermDays: Value(params.paymentTermDays),
          paymentCondition: Value(params.paymentCondition),
          desiredLeadTime: Value(params.leadTimeDefault),
          deliveryType: Value(params.deliveryType),
        ),
      );
      // Nota: Idealmente o repository retornaria o objeto criado ou buscaríamos depois
    }

    final quotation = await quotationRepository.getQuotationById(quotationId);
    final items = await quotationRepository.getQuotationItems(quotationId);

    if (quotation != null) {
      // 5. Sincronizar com Nuvem (em background/async)
      quotationRepository.syncQuotationToCloud(quotation, items);
    }

    // 6. Disparar WhatsApp via Evolution API
    final List<Map<String, dynamic>> suppliersPayload = [];
    if (params.selectedSupplierIds.isNotEmpty) {
      for (final id in params.selectedSupplierIds) {
        final supplier = await contactsDao.getContactById(id);
        if (supplier != null && supplier.whatsapp.isNotEmpty) {
          final personalizedMessage = WhatsAppHelpers.formatQuotationMessage(
            template: _getTemplate(isRede: supplier.isRedeCotazap),
            buyerName: buyer.contactName ?? buyer.tradeName,
            company: buyer.tradeName,
            supplierName: supplier.tradeName,
            productList: productList,
            deliveryType: params.deliveryType,
            leadTime: params.leadTimeDefault,
            paymentTermDays: params.paymentTermDays,
            paymentCondition: params.paymentCondition,
          );

          suppliersPayload.add({
            'trade_name': supplier.tradeName,
            'whatsapp': supplier.whatsapp,
            'is_rede': supplier.isRedeCotazap,
            'message': personalizedMessage,
          });
        }
      }
    }

    if (suppliersPayload.isNotEmpty) {
      try {
        await dio.post('/webhooks/send-quotation', data: {
          'quotation_id': quotationId,
          'buyer_id': params.ownerId, // UUID do Supabase
          'suppliers': suppliersPayload,
          'buyer_whatsapp': buyer.whatsapp,
        });
        AppLogger.success('WhatsApp disparado com sucesso para ${suppliersPayload.length} fornecedores.');
      } catch (e) {
        AppLogger.error('Erro ao disparar WhatsApp via Evolution API', error: e);
        // Não trava o fluxo, cotação já foi criada
      }
    }

    // 7. Registrar Uso de Quota
    await quotaService.recordAction(params.ownerId, QuotaType.quotations);
    await quotaService.recordAction(params.ownerId, QuotaType.whatsappMessages);

    return quotationId;
  }

  String _generateBaseTemplate() {
    return '''📋 *NOVA COTAÇÃO - {empresa}*
---
{lista_produtos}
---
📍 Frete: {frete}
📅 Entrega: {prazo_entrega} dias
💰 Pagamento: {condicao_pagamento} ({prazo_pagamento} dias)
---
👉 *COMO RESPONDER:*
Favor responder com o preço dos itens acima.
Nossa IA processará os dados automaticamente.''';
  }

  String _getTemplate({bool isRede = false}) {
    if (isRede) {
      return '''📋 *NOVA COTAÇÃO - {empresa}*
---
{lista_produtos}
---
📍 Frete: {frete}
📅 Entrega: {prazo_entrega} dias
💰 Pagamento: {condicao_pagamento} ({prazo_pagamento} dias)
---
Responder via link CotaZap: [PROVEDOR_LINK_AQUI]''';
    }
    return _generateBaseTemplate();
  }
}
