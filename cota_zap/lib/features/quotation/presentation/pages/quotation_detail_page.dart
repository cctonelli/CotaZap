import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/di/injection.dart';
import 'package:cota_zap/features/quotation/presentation/controllers/quotation_detail_controller.dart';
import '../../../../drift/database.dart';

class QuotationDetailPage extends ConsumerWidget {
  final int quotationId;
  const QuotationDetailPage({super.key, required this.quotationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(quotationDetailControllerProvider(quotationId));
    final controller = ref.read(quotationDetailControllerProvider(quotationId).notifier);
    final currencyFormat = NumberFormat.simpleCurrency(locale: 'pt_BR');

    if (state.isLoading && state.quotation == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final q = state.quotation;
    if (q == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Cotação não encontrada')),
        body: const Center(child: Text('A cotação solicitada não existe.')),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text('Cotação #${q.id}', style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.loadData,
          ),
          IconButton(
            icon: const Icon(Icons.grid_view),
            onPressed: () => context.push('/quotation-comparison/$quotationId'),
            tooltip: 'Comparativo Geral',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dashboard de BI
            _buildBIDashboard(context, q, currencyFormat, ref),
            
            const SizedBox(height: 30),
            
            const Text(
              'Itens e Melhores Ofertas',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2D3436)),
            ),
            
            const SizedBox(height: 15),
            
            // Lista de itens com análise
            if (state.items != null)
              ...state.items!.map((item) => _buildItemAnalysisCard(context, item, ref, currencyFormat)),
              
            if (state.items == null || state.items!.isEmpty)
              const Center(child: Text('Nenhum item cadastrado nesta cotação.')),
              
            const SizedBox(height: 100), // Espaçamento para o FAB
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: controller.runAnalysis,
        label: const Text('Analisar Preços'),
        icon: const Icon(Icons.analytics),
        backgroundColor: const Color(0xFF6C5CE7),
      ),
    );
  }

  Widget _buildBIDashboard(BuildContext context, Quotation q, NumberFormat format, WidgetRef ref) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6C5CE7).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Economia Gerada',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            format.format(q.totalEconomy),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          if (q.winnerSupplierId != null && q.winnerSupplierId != 0)
            FutureBuilder<AppContact?>(
              future: ref.read(contactsDaoProvider).getSupplierById(q.winnerSupplierId!),
              builder: (context, snapshot) {
                final winnerName = snapshot.data?.tradeName ?? 'Calculando...';
                return _buildMiniInfo(Icons.emoji_events, 'Vencedor Sugerido', winnerName);
              },
            )
          else
            _buildMiniInfo(Icons.analytics, 'Vencedor Sugerido', 'Analise para descobrir'),
        ],
      ),
    );
  }

  Widget _buildMiniInfo(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
            Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        )
      ],
    );
  }

  Widget _buildItemAnalysisCard(BuildContext context, QuotationItem item, WidgetRef ref, NumberFormat format) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: FutureBuilder<Product?>(
        future: ref.read(productsDaoProvider).getProductById(item.productId),
        builder: (context, prodSnapshot) {
          final prodName = prodSnapshot.data?.description ?? "Produto #${item.productId}";
          
          return ExpansionTile(
            title: Text(prodName, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Qtd: ${item.quantity.toStringAsFixed(0)}'),
            children: [
              FutureBuilder<List<SupplierResponse>>(
                future: ref.read(supplierResponsesDaoProvider).getResponsesByQuotationItem(item.id),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const LinearProgressIndicator();
                  }
                  final responses = snapshot.data!;
                  if (responses.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('Nenhuma resposta recebida para este item.'),
                    );
                  }
                  
                  return Column(
                    children: responses.map((r) => FutureBuilder<AppContact?>(
                      future: ref.read(contactsDaoProvider).getSupplierById(r.supplierId),
                      builder: (context, suppSnapshot) {
                         final supplierName = suppSnapshot.data?.tradeName ?? 'Ref #${r.supplierId}';
                         return ListTile(
                            leading: const CircleAvatar(child: Icon(Icons.store)),
                            title: Text('R\$ ${r.pricingExtracted ?? "0.0"}', style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text(
                              '$supplierName\n'
                              'Entrega: ${r.deliveryTimeDays ?? "?"} dias | '
                              'Pagamento: ${r.paymentTermDays ?? "0"} dias',
                              style: const TextStyle(fontSize: 12),
                            ),
                            isThreeLine: true,
                            trailing: Column(
                               mainAxisSize: MainAxisSize.min,
                               crossAxisAlignment: CrossAxisAlignment.end,
                               children: [
                                 if (r.id == item.bestResponseId)
                                   Container(
                                     margin: const EdgeInsets.only(bottom: 4),
                                     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                     decoration: BoxDecoration(
                                       color: Colors.green,
                                       borderRadius: BorderRadius.circular(12),
                                     ),
                                     child: const Text(
                                       'MELHOR',
                                       style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                                     ),
                                   ),
                                 _buildScoreIndicator(r.calculatedScore),
                               ],
                            ),
                         );
                      }
                    )).toList(),
                  );
                }
              ),
            ],
          );
        }
      ),
    );
  }

  Widget _buildScoreIndicator(int score) {
    Color color = Colors.grey;
    if (score >= 80) {
      color = Colors.green;
    } else if (score >= 50) {
      color = Colors.orange;
    } else if (score > 0) {
      color = Colors.red;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color),
      ),
      child: Text(
        '$score pts',
        style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }
}
