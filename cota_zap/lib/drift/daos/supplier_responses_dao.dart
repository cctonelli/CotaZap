import 'package:drift/drift.dart';
import '../database.dart';
import '../schema.dart';

part 'supplier_responses_dao.g.dart';

@DriftAccessor(tables: [SupplierResponses])
class SupplierResponsesDao extends DatabaseAccessor<AppDatabase> with _$SupplierResponsesDaoMixin {
  SupplierResponsesDao(AppDatabase db) : super(db);

  Future<int> insertResponse(SupplierResponsesCompanion response) =>
      into(supplierResponses).insert(response);

  Future<List<SupplierResponse>> getAllResponses() => select(supplierResponses).get();

  Future<List<SupplierResponse>> getResponsesByQuotationItem(int quotationItemId) {
    return (select(supplierResponses)..where((t) => t.quotationItemId.equals(quotationItemId))).get();
  }

  Future<bool> updateResponse(SupplierResponsesCompanion response) =>
      update(supplierResponses).replace(response);

  Future<int> deleteResponse(int id) =>
      (delete(supplierResponses)..where((t) => t.id.equals(id))).go();
      
  Future<void> updateCalculatedScore(int responseId, int score) {
    return (update(supplierResponses)..where((t) => t.id.equals(responseId)))
        .write(SupplierResponsesCompanion(calculatedScore: Value(score)));
  }
}
