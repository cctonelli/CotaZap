import 'package:cota_zap/drift/database.dart';

abstract class QuotationRepository {
  Future<int> createQuotation(QuotationsCompanion quotation);
  Future<void> insertItem(QuotationItemsCompanion item);
  Future<List<Quotation>> getAllQuotations();
  Future<Quotation?> getQuotationById(int id);
  Stream<List<Quotation>> watchAllQuotations();
  Future<List<QuotationItem>> getQuotationItems(int quotationId);
  Future<void> syncQuotationToCloud(Quotation quotation, List<QuotationItem> items);
}
