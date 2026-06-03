import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cota_zap/drift/database.dart';
import 'package:cota_zap/core/di/injection.dart';
import 'package:cota_zap/core/network/supabase_service.dart';
import 'package:cota_zap/core/services/quota_service.dart';
import 'package:cota_zap/core/utils/app_logger.dart';
import 'package:cota_zap/core/utils/whatsapp_helpers.dart';
import 'package:drift/drift.dart';
import 'package:cota_zap/features/quotation/domain/usecases/send_quotation_usecase.dart';

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

  Future<int?> sendQuotation() async {
    final ownerId = ref.read(userIdProvider);
    final plan = ref.read(planTypeProvider);

    if (ownerId == null) {
      state = state.copyWith(errorMessage: 'Usuário não autenticado.');
      return null;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      if (state.selectedProducts.isEmpty) {
        throw Exception('Selecione ao menos um produto.');
      }

      if (state.selectedSupplierIds.isEmpty) {
        throw Exception('Selecione ao menos um fornecedor.');
      }

      final sendQuotationUseCase = ref.read(sendQuotationUseCaseProvider);

      final quotationId = await sendQuotationUseCase(SendQuotationParams(
        ownerId: ownerId,
        plan: plan,
        selectedProducts: state.selectedProducts,
        selectedSupplierIds: state.selectedSupplierIds,
        deliveryType: state.deliveryType,
        leadTimeDefault: state.leadTimeDefault,
        paymentTermDays: state.paymentTermDays,
        paymentCondition: state.paymentCondition,
      ));

      state = state.copyWith(isLoading: false, selectedProducts: {}, selectedSupplierIds: []); 
      AppLogger.success('Cotação enviada com sucesso!');
      return quotationId;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      AppLogger.error('Erro ao enviar cotação', error: e);
      return null;
    }
  }

  String previewMessage({bool isRede = false}) {
    final buffer = StringBuffer();
    buffer.writeln('📋 *NOVA COTAÇÃO - COTAZAP*');
    buffer.writeln('---');
    for (var entry in state.selectedProducts.entries) {
      final qtyStr = WhatsAppHelpers.formatQuantity(entry.value);
      buffer.writeln('• $qtyStr ${entry.key.unitMeasure} x ${entry.key.description}');
    }
    buffer.writeln('---');
    buffer.writeln('📍 Frete: ${state.deliveryType}');
    buffer.writeln('📅 Entrega: ${state.leadTimeDefault} dias');
    buffer.writeln('💰 Pagamento: ${state.paymentCondition} (${state.paymentTermDays} dias)');
    buffer.writeln('---');
    
    if (isRede) {
      buffer.write('Responder via link CotaZap: [PROVEDOR_LINK_AQUI]');
    } else {
      buffer.writeln('👉 *COMO RESPONDER:*');
      buffer.writeln('Favor responder com o preço dos itens acima.');
      buffer.write('Nossa IA processará os dados automaticamente.');
    }
    return buffer.toString();
  }
}
