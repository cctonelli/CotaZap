import 'dart:math';
import '../../../../drift/database.dart';
import '../../../../drift/daos/quotations_dao.dart';
import '../../../../drift/daos/supplier_responses_dao.dart';


class ProcurementEngine {
  final QuotationsDao quotationsDao;
  final SupplierResponsesDao supplierResponsesDao;

  ProcurementEngine({
    required this.quotationsDao, 
    required this.supplierResponsesDao
  });

  /// Realiza a análise de toda a cotação, calculando scores e economia.
  Future<void> analyzeQuotation(int quotationId) async {
    final items = await quotationsDao.getQuotationItems(quotationId);
    
    double totalEconomy = 0.0;
    final Map<int, double> supplierTotalSavings = {}; // supplierId -> total savings
    
    for (final item in items) {
      final responses = await supplierResponsesDao.getResponsesByQuotationItem(item.id);
      if (responses.isEmpty) {
        continue;
      }

      SupplierResponse? bestForThisItem;
      double maxScore = -1.0;

      // Cálculo de scores e identificação da melhor resposta para este item
      for (final resp in responses) {
        if (resp.pricingExtracted == null) {
          continue;
        }

        // PREÇO (Inversamente proporcional ao preço) - 60% PESO
        final double priceReference = item.requestedPrice ?? 1000.0; 
        final double priceScore = (priceReference / resp.pricingExtracted!) * 60;
        
        // PRAZO PAGAMENTO (Quanto maior, melhor) - 25% PESO
        double payRef = (item.paymentTermDays ?? 1).toDouble();
        if (payRef < 1) {
          payRef = 1;
        }
        final double payScore = (resp.paymentTermDays != null) 
            ? min((resp.paymentTermDays! / payRef) * 25, 35.0) 
            : 0;

        // PRAZO ENTREGA (Quanto menor, melhor) - 15% PESO
        double leadRef = (item.desiredLeadTime ?? 3).toDouble();
        if (leadRef < 1) {
          leadRef = 1;
        }
        final double leadScore = (resp.deliveryTimeDays != null) 
             ? (leadRef / (resp.deliveryTimeDays! + 1)) * 15 
             : 5.0; 

        final int calculatedScore = min((priceScore + payScore + leadScore).toInt(), 100);
        
        // Atualiza score no DB
        await supplierResponsesDao.updateCalculatedScore(resp.id, calculatedScore);

        if (calculatedScore > maxScore) {
          maxScore = calculatedScore.toDouble();
          bestForThisItem = resp;
        }
      }

      if (bestForThisItem != null) {
        // Vincula a melhor resposta ao item no DB
        await quotationsDao.updateBestResponse(item.id, bestForThisItem.id);
        
        // Contabiliza economia
        if (item.requestedPrice != null && bestForThisItem.pricingExtracted != null) {
           final double saving = (item.requestedPrice! - bestForThisItem.pricingExtracted!) * item.quantity;
           if (saving > 0) {
             totalEconomy += saving;
           }
           
           supplierTotalSavings[bestForThisItem.supplierId] = 
              (supplierTotalSavings[bestForThisItem.supplierId] ?? 0) + (saving > 0 ? saving : 0);
        }
      }
    }

    int winnerId = -1;
    double topSavings = -1.0;
    supplierTotalSavings.forEach((id, savings) {
      if (savings > topSavings) {
        topSavings = savings;
        winnerId = id;
      }
    });

    await quotationsDao.updateQuotationResult(
      quotationId, 
      totalEconomy, 
      winnerId != -1 ? winnerId : 0
    );
  }
}
