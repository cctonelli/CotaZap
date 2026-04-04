import 'package:drift/drift.dart';
import '../database.dart';
import '../schema.dart';

part 'quotations_dao.g.dart';

@DriftAccessor(tables: [Quotations, QuotationItems])
class QuotationsDao extends DatabaseAccessor<AppDatabase> with _$QuotationsDaoMixin {
  QuotationsDao(AppDatabase db) : super(db);

  Future<int> createQuotation(QuotationsCompanion quotation) => into(quotations).insert(quotation);
  
  Future insertItem(QuotationItemsCompanion item) => into(quotationItems).insert(item);

  Future<List<Quotation>> getAllQuotations() => select(quotations).get();
  
  Future<Quotation> getQuotationById(int id) {
    return (select(quotations)..where((t) => t.id.equals(id))).getSingle();
  }

  Stream<List<Quotation>> watchAllQuotations() => select(quotations).watch();

  Future<List<QuotationItem>> getQuotationItems(int quotationId) {
    return (select(quotationItems)..where((t) => t.quotationId.equals(quotationId))).get();
  }

  Future<void> updateQuotationResult(int quotationId, double totalEconomy, int winnerSupplierId) {
    return (update(quotations)..where((t) => t.id.equals(quotationId)))
        .write(QuotationsCompanion(
      totalEconomy: Value(totalEconomy),
      winnerSupplierId: Value(winnerSupplierId),
    ));
  }

  Future<void> updateBestResponse(int quotationItemId, int responseId) {
    return (update(quotationItems)..where((t) => t.id.equals(quotationItemId)))
        .write(QuotationItemsCompanion(bestResponseId: Value(responseId)));
  }

  Future<List<Quotation>> getRecentQuotations(String buyerId, {int limit = 5}) {
    return (select(quotations)
          ..where((t) => t.buyerId.equals(buyerId))
          ..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)])
          ..limit(limit))
        .get();
  }

  Future<double> getTotalAccumulatedEconomy(String buyerId) async {
    final query = selectOnly(quotations)..addColumns([quotations.totalEconomy.sum()])..where(quotations.buyerId.equals(buyerId));
    final result = await query.map((row) => row.read(quotations.totalEconomy.sum())).getSingle();
    return result ?? 0.0;
  }
}

