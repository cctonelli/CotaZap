import 'package:cota_zap/core/network/supabase_service.dart';
import 'package:cota_zap/core/utils/app_logger.dart';
import 'package:cota_zap/drift/daos/quotations_dao.dart';
import 'package:cota_zap/drift/database.dart';
import 'package:cota_zap/features/quotation/domain/repositories/quotation_repository.dart';

class QuotationRepositoryImpl implements QuotationRepository {
  final QuotationsDao _quotationsDao;

  QuotationRepositoryImpl(this._quotationsDao);

  @override
  Future<int> createQuotation(QuotationsCompanion quotation) {
    return _quotationsDao.createQuotation(quotation);
  }

  @override
  Future<void> insertItem(QuotationItemsCompanion item) {
    return _quotationsDao.insertItem(item);
  }

  @override
  Future<List<Quotation>> getAllQuotations() {
    return _quotationsDao.getAllQuotations();
  }

  @override
  Future<Quotation?> getQuotationById(int id) {
    return _quotationsDao.getQuotationById(id);
  }

  @override
  Stream<List<Quotation>> watchAllQuotations() {
    return _quotationsDao.watchAllQuotations();
  }

  @override
  Future<List<QuotationItem>> getQuotationItems(int quotationId) {
    return _quotationsDao.getQuotationItems(quotationId);
  }

  @override
  Future<void> syncQuotationToCloud(Quotation quotation, List<QuotationItem> items) async {
    try {
      await SupabaseService.updateProfile(
        table: 'quotations',
        data: {
          'id': quotation.id,
          'buyer_id': quotation.buyerId,
          'status': quotation.status,
          'template_message': quotation.templateMessage,
          'default_payment_term_days': quotation.defaultPaymentTermDays,
          'default_payment_condition': quotation.defaultPaymentCondition,
          'default_lead_time_days': quotation.defaultLeadTimeDays,
          'default_delivery_type': quotation.defaultDeliveryType,
          'created_at': quotation.date.toIso8601String(),
        },
      );

      final itemsData = items.map((item) => {
        'quotation_id': item.quotationId,
        'product_id': item.productId,
        'quantity': item.quantity,
      }).toList();

      await SupabaseService.updateProfile(table: 'quotation_items', data: itemsData);
      AppLogger.success('Cotação ${quotation.id} sincronizada com o Supabase');
    } catch (e) {
      AppLogger.error('Erro ao sincronizar cotação com o Supabase', error: e, tag: 'Supabase');
      // Não relança para não interromper o fluxo offline
    }
  }
}
