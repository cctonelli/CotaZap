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
}

