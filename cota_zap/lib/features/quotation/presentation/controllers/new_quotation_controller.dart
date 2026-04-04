import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cota_zap/drift/database.dart';
import 'package:cota_zap/core/di/injection.dart';
import 'package:cota_zap/core/network/supabase_service.dart';
import 'package:cota_zap/core/services/quota_service.dart';
import 'package:cota_zap/core/utils/app_logger.dart';
import 'package:drift/drift.dart';

/// Estado da Nova Cotação
class NewQuotationState {
  final Map<Product, double> selectedProducts;
  final String deliveryType; // CIF/FOB
  final int leadTimeDefault;
  final int paymentTermDays;
  final String paymentCondition;
  final bool isLoading;
  final List<int> selectedSupplierIds;
  final String? errorMessage;

  NewQuotationState({
    this.selectedProducts = const {},
    this.deliveryType = 'CIF',
    this.leadTimeDefault = 3,
    this.paymentTermDays = 0,
    this.paymentCondition = 'Boleto',
    this.isLoading = false,
    this.selectedSupplierIds = const [],
    this.errorMessage,
  });

  NewQuotationState copyWith({
    Map<Product, double>? selectedProducts,
    String? deliveryType,
    int? leadTimeDefault,
    int? paymentTermDays,
    String? paymentCondition,
    bool? isLoading,
    List<int>? selectedSupplierIds,
    String? errorMessage,
  }) {
    return NewQuotationState(
      selectedProducts: selectedProducts ?? this.selectedProducts,
      deliveryType: deliveryType ?? this.deliveryType,
      leadTimeDefault: leadTimeDefault ?? this.leadTimeDefault,
      paymentTermDays: paymentTermDays ?? this.paymentTermDays,
      paymentCondition: paymentCondition ?? this.paymentCondition,
      isLoading: isLoading ?? this.isLoading,
      selectedSupplierIds: selectedSupplierIds ?? this.selectedSupplierIds,
      errorMessage: errorMessage,
    );
  }
}

/// Provider para o Controlador da Nova Cotação
final newQuotationControllerProvider =
    NotifierProvider<NewQuotationController, NewQuotationState>(
        NewQuotationController.new);

class NewQuotationController extends Notifier<NewQuotationState> {
  @override
  NewQuotationState build() {
    return NewQuotationState();
  }

  // --- Lógica de Produtos ---

  void addProduct(Product product, {double quantity = 1.0}) {
    final newSelected = Map<Product, double>.from(state.selectedProducts);
    newSelected[product] = quantity;
    state = state.copyWith(selectedProducts: newSelected);
  }

  void removeProduct(Product product) {
    final newSelected = Map<Product, double>.from(state.selectedProducts);
    newSelected.remove(product);
    state = state.copyWith(selectedProducts: newSelected);
  }

  void updateQuantity(Product product, double quantity) {
    if (state.selectedProducts.containsKey(product)) {
      final newSelected = Map<Product, double>.from(state.selectedProducts);
      newSelected[product] = quantity;
      state = state.copyWith(selectedProducts: newSelected);
    }
  }

  // --- Lógica de Configurações Globais ---

  void updateDeliveryType(String type) {
    state = state.copyWith(deliveryType: type);
  }

  void updateLeadTime(int days) {
    state = state.copyWith(leadTimeDefault: days);
  }

  void updatePaymentTerm(int days) {
    state = state.copyWith(paymentTermDays: days);
  }

  void updatePaymentCondition(String condition) {
    state = state.copyWith(paymentCondition: condition);
  }

  void toggleSupplierSelection(int supplierId) {
    final current = List<int>.from(state.selectedSupplierIds);
    if (current.contains(supplierId)) {
      current.remove(supplierId);
    } else {
      current.add(supplierId);
    }
    state = state.copyWith(selectedSupplierIds: current);
  }

  // --- Lógica de Envio ---

  Future<void> sendQuotation() async {
    if (state.selectedProducts.isEmpty) return;

    state = state.copyWith(isLoading: true, errorMessage: null);

    final quotationsDao = ref.read(quotationsDaoProvider);
    final buyersDao = ref.read(buyersDaoProvider);
    final dio = ref.read(dioProvider);

    try {
      final ownerId = ref.read(userIdProvider);
      if (ownerId == null) {
        throw Exception('Usuário não autenticado. Faça login para continuar.');
      }

      final buyer = await buyersDao.getFirstBuyer(ownerId);
      if (buyer == null) {
        throw Exception('Perfil de comprador não encontrado. Cadastre seus dados em "Meu Perfil".');
      }

      final quotaService = ref.read(quotaServiceProvider);
      final plan = ref.read(planTypeProvider);
      
      final canSendQuotation = await quotaService.canPerformAction(buyer.ownerId ?? '', plan, QuotaType.quotations);
      if (!canSendQuotation) {
        throw Exception('Limite diário de cotações atingido no seu plano ($plan).');
      }

      final canSendWhatsApp = await quotaService.canPerformAction(buyer.ownerId ?? '', plan, QuotaType.whatsappMessages);
      if (!canSendWhatsApp) {
        throw Exception('Limite diário de mensagens WhatsApp atingido no seu plano ($plan).');
      }

      final buyerUUID = buyer.ownerId;
      if (buyerUUID == null || buyerUUID.isEmpty) {
        throw Exception('UUID do comprador não encontrado. Verifique sua conexão com o servidor.');
      }

      // 1. Criar Cabeçalho da Cotação no DB Local
      final quotationId = await quotationsDao.createQuotation(
        QuotationsCompanion(
          buyerId: Value(buyerUUID),
          date: Value(DateTime.now()),
          status: const Value('sent'),
          templateMessage: Value(_generateWhatsAppMessage()),
          defaultPaymentTermDays: Value(state.paymentTermDays),
          defaultPaymentCondition: Value(state.paymentCondition),
          defaultLeadTimeDays: Value(state.leadTimeDefault),
          defaultDeliveryType: Value(state.deliveryType),
        ),
      );

      // 2. Criar Itens da Cotação
      for (var entry in state.selectedProducts.entries) {
        await quotationsDao.insertItem(
          QuotationItemsCompanion(
            quotationId: Value(quotationId),
            productId: Value(entry.key.id),
            quantity: Value(entry.value),
            // Copia os defaults da cotação para o item caso queira sobrescrever depois
            paymentTermDays: Value(state.paymentTermDays),
            paymentCondition: Value(state.paymentCondition),
            desiredLeadTime: Value(state.leadTimeDefault),
            deliveryType: Value(state.deliveryType),
          ),
        );
      }

      // 3. Replicar para o Supabase (Nuvem)
      try {
        await SupabaseService.updateProfile(
          table: 'quotations',
          data: {
            'id': quotationId,
            'buyer_id': buyerUUID,
            'status': 'sent',
            'template_message': _generateWhatsAppMessage(),
            'default_payment_term_days': state.paymentTermDays,
            'default_payment_condition': state.paymentCondition,
            'default_lead_time_days': state.leadTimeDefault,
            'default_delivery_type': state.deliveryType,
            'created_at': DateTime.now().toIso8601String(),
          },
        );

        // Upload de itens para o Supabase
        final itemsData = <Map<String, dynamic>>[];
        for (var entry in state.selectedProducts.entries) {
          itemsData.add({
            'quotation_id': quotationId,
            'product_id': entry.key.id,
            'quantity': entry.value,
          });
        }
        await SupabaseService.updateProfile(table: 'quotation_items', data: itemsData);

      } catch (supabaseError) {
        AppLogger.error('Erro ao replicar cotação para o Supabase', error: supabaseError, tag: 'Supabase');
      }

      // 4. Disparar para Evolution API (Webhook)
      try {
        await dio.post('/webhooks/evolution', data: {
          'quotationId': quotationId,
          'buyerWhatsApp': buyer.whatsapp,
          'message': _generateWhatsAppMessage(),
          'itemsCount': state.selectedProducts.length,
          'targetSupplierIds': state.selectedSupplierIds, // Enviando IDs dos fornecedores alvo
        });
      } catch (apiError) {
        AppLogger.error('Evolution API Error', error: apiError, tag: 'API');
      }

      // Registrar uso de quotas após sucesso
      await quotaService.recordAction(buyer.ownerId ?? '', QuotaType.quotations);
      await quotaService.recordAction(buyer.ownerId ?? '', QuotaType.whatsappMessages);

      state = state.copyWith(isLoading: false, selectedProducts: {}); 
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  String _generateWhatsAppMessage() {
    final buffer = StringBuffer();
    buffer.writeln('📋 *NOVA COTAÇÃO - COTAZAP*');
    buffer.writeln('---');
    for (var entry in state.selectedProducts.entries) {
      buffer.writeln('• ${entry.value} x ${entry.key.description}');
    }
    buffer.writeln('---');
    buffer.writeln('📍 Frete: ${state.deliveryType}');
    buffer.writeln('📅 Entrega: ${state.leadTimeDefault} dias');
    buffer.writeln('💰 Pagamento: ${state.paymentCondition} (${state.paymentTermDays} dias)');
    buffer.writeln('---');
    buffer.write('Responder via link CotaZap: [PROVEDOR_LINK_AQUI]');
    return buffer.toString();
  }
}
