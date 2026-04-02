import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/injection.dart';
import '../../../../drift/database.dart';

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
