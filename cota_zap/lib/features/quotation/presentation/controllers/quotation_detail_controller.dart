import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/network/supabase_service.dart';
import '../../../../core/utils/app_logger.dart';
import '../../../../drift/database.dart';
import 'package:drift/drift.dart';

class QuotationDetailState {
  final Quotation? quotation;
  final List<QuotationItem>? items;
  final bool isLoading;

  QuotationDetailState({this.quotation, this.items, this.isLoading = false});

  QuotationDetailState copyWith({
    Quotation? quotation,
    List<QuotationItem>? items,
    bool? isLoading,
  }) {
    return QuotationDetailState(
      quotation: quotation ?? this.quotation,
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class QuotationDetailController extends StateNotifier<QuotationDetailState> {
  final int quotationId;
  final Ref ref;

  QuotationDetailController(this.quotationId, this.ref) : super(QuotationDetailState()) {
    loadData();
  }

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    final dao = ref.read(quotationsDaoProvider);
    
    final quots = await dao.getAllQuotations();
    final q = quots.firstWhere((element) => element.id == quotationId);
    final items = await dao.getQuotationItems(quotationId);

    state = state.copyWith(quotation: q, items: items, isLoading: false);
    
    // Inicia sync de respostas em background
    if (items.isNotEmpty) {
       _syncResponses(items);
    }
  }

  Future<void> _syncResponses(List<QuotationItem> items) async {
    final db = ref.read(databaseProvider);
    final itemIds = items.map((e) => e.id).toList();
    
    try {
      // Busca respostas que pertencem a estes itens da cotação no Supabase
      final response = await SupabaseService.client
          .from('supplier_responses')
          .select()
          .filter('item_quotation_id', 'in', itemIds);
      
      final List<dynamic> remoteResponses = response as List<dynamic>;
      
      if (remoteResponses.isNotEmpty) {
        for (var r in remoteResponses) {
          await db.into(db.supplierResponses).insertOnConflictUpdate(
            SupplierResponsesCompanion(
              id: Value(r['id']),
              quotationItemId: Value(r['item_quotation_id']),
              supplierId: Value(r['supplier_id']),
              receivedMessage: Value(r['message_received']),
              pricingExtracted: Value(r['price_extracted'] != null ? (r['price_extracted'] as num).toDouble() : null),
              deliveryTimeDays: Value(r['delivery_time_days']),
              responseDate: Value(DateTime.tryParse(r['response_date'] ?? '') ?? DateTime.now()),
              status: Value(r['status'] ?? 'replied'),
              paymentTermDays: Value(r['payment_term_days']),
              paymentCondition: Value(r['payment_condition']),
              calculatedScore: Value(r['calculated_score'] ?? 0),
            ),
          );
        }
        AppLogger.success('${remoteResponses.length} respostas sincronizadas.', tag: 'QuotationDetail');
        
        // RE-carrega dados locais para refletir no UI
        final updatedItems = await ref.read(quotationsDaoProvider).getQuotationItems(quotationId);
        state = state.copyWith(items: updatedItems);
      }
    } catch (e) {
      AppLogger.error('Erro ao sincronizar respostas da cotação', error: e, tag: 'QuotationDetail');
    }
  }

  Future<void> runAnalysis() async {
    state = state.copyWith(isLoading: true);
    await ref.read(procurementEngineProvider).analyzeQuotation(quotationId);
    await loadData(); // Reload results
  }
}

final quotationDetailControllerProvider = StateNotifierProvider.family<QuotationDetailController, QuotationDetailState, int>((ref, id) {
  return QuotationDetailController(id, ref);
});
