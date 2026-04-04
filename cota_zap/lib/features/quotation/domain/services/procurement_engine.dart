import 'dart:math';
import '../../../../drift/database.dart';
import '../../../../drift/daos/quotations_dao.dart';
import '../../../../drift/daos/supplier_responses_dao.dart';
import '../../../../drift/daos/contacts_dao.dart';


class ProcurementEngine {
  final QuotationsDao quotationsDao;
  final SupplierResponsesDao supplierResponsesDao;
  final ContactsDao contactsDao;

  ProcurementEngine({
    required this.quotationsDao, 
    required this.supplierResponsesDao,
    required this.contactsDao,
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
        if (resp.pricingExtracted == null) continue;

        // 1. PREÇO (Inversamente proporcional ao preço) - 60% PESO
        final priceReference = item.requestedPrice ?? 1000.0;
        final priceScore = (priceReference / resp.pricingExtracted!) * 60;

        // 2. PRAZO PAGAMENTO (Quanto maior, melhor) - 20% PESO
        var payRef = (item.paymentTermDays ?? 30).toDouble();
        if (payRef < 1) payRef = 30;

        final payScore = (resp.paymentTermDays != null)
            ? min((resp.paymentTermDays! / payRef) * 20, 30.0)
            : 0.0;

        // 3. PRAZO ENTREGA (Quanto menor, melhor) - 20% PESO
        var leadRef = (item.desiredLeadTime ?? 3).toDouble();
        if (leadRef < 1) leadRef = 1;

        final leadScore = (resp.deliveryTimeDays != null)
            ? (leadRef / (resp.deliveryTimeDays! + 1)) * 20
            : 5.0;

        // 4. CONFIANÇA/REDE COTAZAP (Bônus de até 10%)
        final supplier = await contactsDao.getSupplierById(resp.supplierId);
        double bonusScore = 0.0;
        if (supplier != null) {
           if (supplier.isRedeCotazap) bonusScore += 5.0; // Bônus fixo por ser verificado
           bonusScore += (supplier.priorityScore / 100) * 5.0; // Bônus variável (0 a 5)
        }

        final double rawScore = priceScore + payScore + leadScore + bonusScore;
        final int finalScore = min(rawScore.toInt(), 100);

        // Atualiza score no DB (inteiro para exibição)
        await supplierResponsesDao.updateCalculatedScore(resp.id, finalScore);

        // Lógica de desempate refinada:
        // 1. Maior score bruto (double)
        // 2. Se igual, menor preço
        // 3. Se igual, menor prazo de entrega
        // 4. Se igual, maior prazo de pagamento
        bool isBetter = false;
        if (rawScore > maxScore) {
          isBetter = true;
        } else if ((rawScore - maxScore).abs() < 0.001) {
          // Empate no score bruto, verificar critérios secundários
          if (bestForThisItem != null && resp.pricingExtracted != null && bestForThisItem.pricingExtracted != null) {
            if (resp.pricingExtracted! < bestForThisItem.pricingExtracted!) {
              isBetter = true;
            } else if (resp.pricingExtracted! == bestForThisItem.pricingExtracted!) {
              if ((resp.deliveryTimeDays ?? 99) < (bestForThisItem.deliveryTimeDays ?? 99)) {
                isBetter = true;
              } else if (resp.deliveryTimeDays == bestForThisItem.deliveryTimeDays) {
                if ((resp.paymentTermDays ?? 0) > (bestForThisItem.paymentTermDays ?? 0)) {
                  isBetter = true;
                }
              }
            }
          }
        }

        if (isBetter) {
          maxScore = rawScore;
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
