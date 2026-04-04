import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../drift/database.dart';
import '../../../../core/di/injection.dart';

class QuotationComparisonPage extends ConsumerStatefulWidget {
  final int quotationId;
  const QuotationComparisonPage({super.key, required this.quotationId});

  @override
  ConsumerState<QuotationComparisonPage> createState() => _QuotationComparisonPageState();
}

class _QuotationComparisonPageState extends ConsumerState<QuotationComparisonPage> {
  final NumberFormat _currencyFormat = NumberFormat.simpleCurrency(locale: 'pt_BR');
  final ScrollController _horizontalController = ScrollController();
  final ScrollController _headerHorizontalController = ScrollController();

  _QuotationComparisonPageState() {
    _horizontalController.addListener(() {
      if (_headerHorizontalController.hasClients) {
        _headerHorizontalController.jumpTo(_horizontalController.offset);
      }
    });
  }

  Future<Map<String, dynamic>> _loadData() async {
    final quotationsDao = ref.read(quotationsDaoProvider);
    final contactsDao = ref.read(contactsDaoProvider);
    final responsesDao = ref.read(supplierResponsesDaoProvider);
    final productsDao = ref.read(productsDaoProvider);

    final quotation = await quotationsDao.getQuotationById(widget.quotationId);
    final items = await quotationsDao.getQuotationItems(widget.quotationId);
    
    final supplierIds = <int>{};
    final productIds = <int>{};
    final allResponses = <SupplierResponse>[];

    for (var item in items) {
      productIds.add(item.productId);
      final itemResponses = await responsesDao.getResponsesByQuotationItem(item.id);
      allResponses.addAll(itemResponses);
      for (var r in itemResponses) {
        supplierIds.add(r.supplierId);
      }
    }

    final suppliers = <AppContact>[];
    for (var sid in supplierIds) {
      final s = await contactsDao.getSupplierById(sid);
      if (s != null) suppliers.add(s);
    }

    final productsMap = <int, Product>{};
    for (var pid in productIds) {
      final p = await productsDao.getProductById(pid);
      if (p != null) productsMap[pid] = p;
    }

    return {
      'quotation': quotation,
      'items': items,
      'suppliers': suppliers,
      'responses': allResponses,
      'products': productsMap,
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _loadData(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        final quotation = snapshot.data!['quotation'] as Quotation;
        final items = snapshot.data!['items'] as List<QuotationItem>;
        final suppliers = snapshot.data!['suppliers'] as List<AppContact>;
        final responses = snapshot.data!['responses'] as List<SupplierResponse>;
        final products = snapshot.data!['products'] as Map<int, Product>;

        return Scaffold(
          backgroundColor: const Color(0xFFF1F5F9),
          appBar: _buildAppBar(quotation, ref),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildQuotationHeaderInfo(quotation, items, suppliers, responses),
              Expanded(
                child: _buildComparisonTable(items, suppliers, responses, products),
              ),
            ],
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(Quotation q, WidgetRef ref) {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Painel Comparativo', 
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF1E293B))),
          Text('REFERÊNCIA #${q.id.toString().padLeft(4, "0")}',
            style: TextStyle(fontSize: 10, color: Colors.grey[500], fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        ],
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        TextButton.icon(
          onPressed: () async {
             await ref.read(procurementEngineProvider).analyzeQuotation(q.id);
             if (mounted) setState(() {});
          }, 
          icon: const Icon(Icons.analytics_outlined, size: 18, color: Color(0xFF6366F1)),
          label: const Text('RECALCULAR', style: TextStyle(color: Color(0xFF6366F1), fontWeight: FontWeight.bold, fontSize: 12)),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildQuotationHeaderInfo(Quotation q, List<QuotationItem> items, List<AppContact> suppliers, List<SupplierResponse> responses) {
    // Calculando o vencedor de fato se existir
    AppContact? winner;
    if (q.winnerSupplierId != null && q.winnerSupplierId != 0) {
       winner = suppliers.where((s) => s.id == q.winnerSupplierId).firstOrNull;
    }

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatusBadge(q.status),
              Text(
                'Atualizado em ${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now())}',
                style: TextStyle(fontSize: 10, color: const Color(0xFF94A3B8), fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildStatCard('Produtos', items.length.toString(), Icons.inventory_2_outlined, const Color(0xFF3B82F6)),
              const SizedBox(width: 12),
              _buildStatCard('Respostas', suppliers.length.toString(), Icons.forum_outlined, const Color(0xFF10B981)),
              const SizedBox(width: 12),
              _buildStatCard('Economia', _currencyFormat.format(q.totalEconomy), Icons.savings_outlined, const Color(0xFFF59E0B)),
            ],
          ),
          if (winner != null) ...[
             const SizedBox(height: 16),
             _buildWinnerCard(winner),
          ],
        ],
      ),
    );
  }

  Widget _buildWinnerCard(AppContact winner) {
     return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
           gradient: const LinearGradient(
              colors: [Color(0xFF1E293B), Color(0xFF334155)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
           ),
           borderRadius: BorderRadius.circular(16),
           boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4)),
           ]
        ),
        child: Row(
           children: [
              Container(
                 padding: const EdgeInsets.all(8),
                 decoration: BoxDecoration(
                    color: const Color(0xFFF59E0B).withOpacity(0.2),
                    shape: BoxShape.circle,
                 ),
                 child: const Icon(Icons.emoji_events, color: Color(0xFFF59E0B), size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                 child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       const Text('FORNECEDOR CAMPEÃO', style: TextStyle(color: Color(0xFFF59E0B), fontWeight: FontWeight.w900, fontSize: 10, letterSpacing: 1)),
                       Text(winner.tradeName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                 ),
              ),
              ElevatedButton(
                 onPressed: () {}, 
                 style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF59E0B),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                 ),
                 child: const Text('FINALIZAR COMPRA', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              ),
           ],
        ),
     );
  }

  Widget _buildStatusBadge(String status) {
    Color statusColor;
    String statusLabel;
    IconData statusIcon;

    switch (status) {
      case 'draft':
        statusColor = const Color(0xFF94A3B8);
        statusLabel = 'Rascunho';
        statusIcon = Icons.edit_document;
        break;
      case 'sent':
        statusColor = const Color(0xFF3B82F6);
        statusLabel = 'Enviada';
        statusIcon = Icons.alternate_email;
        break;
      case 'analyzing':
        statusColor = const Color(0xFFF59E0B);
        statusLabel = 'Analisando';
        statusIcon = Icons.query_stats;
        break;
      case 'finished':
        statusColor = const Color(0xFF10B981);
        statusLabel = 'Concluída';
        statusIcon = Icons.verified_user_outlined;
        break;
      default:
        statusColor = Colors.blueGrey;
        statusLabel = status;
        statusIcon = Icons.help_outline;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(statusIcon, color: statusColor, size: 12),
          const SizedBox(width: 6),
          Text(
            statusLabel.toUpperCase(),
            style: TextStyle(
              color: statusColor,
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(height: 8),
            Text(title, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
            Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis)),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonTable(
    List<QuotationItem> items,
    List<AppContact> suppliers,
    List<SupplierResponse> responses,
    Map<int, Product> products,
  ) {
    const double productColWidth = 180;
    const double supplierColWidth = 200;
    final totalWidth = productColWidth + (supplierColWidth * suppliers.length);

    return Column(
      children: [
        // Table Header
        Container(
          color: Colors.white,
          height: 120,
          child: SingleChildScrollView(
            controller: _headerHorizontalController,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            child: SizedBox(
              width: totalWidth,
              child: Row(
                children: [
                  Container(
                    width: productColWidth,
                    padding: const EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('LISTA DE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Colors.grey)),
                        Text('PRODUTOS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87)),
                      ],
                    ),
                  ),
                  ...suppliers.map((s) => _buildSupplierHeaderCell(s, supplierColWidth)),
                ],
              ),
            ),
          ),
        ),
        // Table Body
        Expanded(
          child: SingleChildScrollView(
            controller: _horizontalController,
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: totalWidth,
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  final product = products[item.productId];
                  return _buildProductRow(item, product, suppliers, responses, productColWidth, supplierColWidth, index % 2 == 1);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSupplierHeaderCell(AppContact s, double width) {
    return Container(
      width: width,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
            child: Text(s.tradeName[0], style: const TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold, fontSize: 12)),
          ),
          const SizedBox(height: 6),
          Text(
            s.tradeName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF1E293B)),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star, size: 10, color: Color(0xFFF59E0B)),
              Text(' 4.8', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF475569))),
              const SizedBox(width: 8),
              Icon(Icons.verified, size: 12, color: s.isRedeCotazap ? const Color(0xFF3B82F6) : const Color(0xFFE2E8F0)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductRow(
    QuotationItem item,
    Product? product,
    List<AppContact> suppliers,
    List<SupplierResponse> responses,
    double productWidth,
    double supplierWidth,
    bool alternate,
  ) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: alternate ? Colors.transparent : Colors.white.withOpacity(0.5),
        border: Border(bottom: BorderSide(color: Colors.grey[100]!)),
      ),
      child: Row(
        children: [
          // Basic item info
          Container(
            width: productWidth,
            padding: const EdgeInsets.fromLTRB(20, 12, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  product?.description ?? "Produto #${item.productId}",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Qtd: ${item.quantity.toInt()} ${product?.unitMeasure ?? "un"}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 10, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          // Responses
          ...suppliers.map((s) {
            final response = responses.where((r) => r.supplierId == s.id && r.quotationItemId == item.id).firstOrNull;
            final isBest = response != null && response.id == item.bestResponseId;

            return _buildResponseCell(response, isBest, supplierWidth);
          }),
        ],
      ),
    );
  }

  Widget _buildResponseCell(SupplierResponse? r, bool isBest, double width) {
    if (r == null || r.pricingExtracted == null) {
      return SizedBox(
        width: width,
        child: Center(child: Text('-', style: TextStyle(color: Colors.grey[300], fontSize: 20))),
      );
    }

    final score = r.calculatedScore;
    Color scoreColor;
    if (score >= 80) scoreColor = const Color(0xFF10B981); // Emerald
    else if (score >= 50) scoreColor = const Color(0xFFF59E0B); // Amber
    else scoreColor = const Color(0xFFEF4444); // Red

    return Container(
      width: width,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isBest ? const Color(0xFF2563EB).withOpacity(0.03) : null,
        border: Border(left: BorderSide(color: Colors.grey[100]!)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _currencyFormat.format(r.pricingExtracted),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: isBest ? const Color(0xFF2563EB) : const Color(0xFF1E293B),
                ),
              ),
              if (isBest)
                const Icon(Icons.stars, color: Color(0xFF2563EB), size: 18),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              _buildMiniMeta(Icons.local_shipping_outlined, '${r.deliveryTimeDays ?? "?"} dias', const Color(0xFF64748B)),
              const SizedBox(width: 8),
              _buildMiniMeta(Icons.credit_card_outlined, r.paymentTermDays != null ? '${r.paymentTermDays}d' : 'À vista', const Color(0xFF64748B)),
            ],
          ),
          const SizedBox(height: 10),
          // Kanban-style Match Score Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: scoreColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: scoreColor.withOpacity(0.2), width: 0.5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(color: scoreColor, shape: BoxShape.circle),
                ),
                const SizedBox(width: 4),
                Text(
                  'MATCH $score%',
                  style: TextStyle(
                    fontSize: 8, 
                    fontWeight: FontWeight.w900, 
                    color: scoreColor,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniMeta(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, size: 10, color: color.withOpacity(0.5)),
        const SizedBox(width: 2),
        Text(text, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w500)),
      ],
    );
  }
}

