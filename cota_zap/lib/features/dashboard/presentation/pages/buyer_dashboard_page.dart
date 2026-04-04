import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controllers/buyer_dashboard_controller.dart';
import 'package:intl/intl.dart';

class BuyerDashboardPage extends ConsumerWidget {
  const BuyerDashboardPage({super.key});

  static final _currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: r'R$');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(buyerDashboardProvider);
    final notifier = ref.read(buyerDashboardProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      drawer: _buildDrawer(context),
      body: RefreshIndicator(
        onRefresh: () => notifier.refreshDashboard(),
        child: CustomScrollView(
          slivers: [
            _buildAppBar(context, state),
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildPlanStatus(context, state, notifier),
                  const SizedBox(height: 24),
                  _buildSavingsSummary(context, state),
                  const SizedBox(height: 24),
                  _buildQuotaOverview(context, state),
                  const SizedBox(height: 24),
                  _buildRecentQuotationsHeader(context),
                  const SizedBox(height: 12),
                  if (state.isLoading)
                    const Center(child: CircularProgressIndicator())
                  else if (state.recentQuotations.isEmpty)
                    _buildEmptyState(context)
                  else
                    ...state.recentQuotations.map((q) => _buildQuotationCard(context, q)),
                  const SizedBox(height: 80), // Espaço para FAB
                ]),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/new-quotation'),
        backgroundColor: const Color(0xFF2563EB),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Nova Cotação', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF2563EB)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('CotaZap Buyer', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                Text('Sua central de compras', style: TextStyle(color: Colors.white70, fontSize: 14)),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Meus Fornecedores'),
            onTap: () {
              Navigator.pop(context);
              context.go('/suppliers');
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_bag),
            title: const Text('Meus Produtos'),
            onTap: () {
              Navigator.pop(context);
              context.go('/products');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Meu Perfil'),
            onTap: () {
              Navigator.pop(context);
              context.go('/buyer-profile');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, BuyerDashboardState state) {
    return SliverAppBar(
      expandedHeight: 120.0,
      pinned: true,
      backgroundColor: const Color(0xFF2563EB),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        title: const Text(
          'Meu Dashboard',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2563EB), Color(0xFF1E40AF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_outlined, color: Colors.white),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.person_outline, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildPlanStatus(BuildContext context, BuyerDashboardState state, BuyerDashboardNotifier notifier) {
    final isPremium = state.userPlan == 'premium';

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isPremium ? Colors.amber.withOpacity(0.1) : Colors.blue.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isPremium ? Icons.workspace_premium : Icons.person,
              color: isPremium ? Colors.amber[800] : Colors.blue[800],
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isPremium ? 'Plano PREMIUM' : 'Plano GRÁTIS',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isPremium ? Colors.amber[800] : Colors.blue[900],
                  ),
                ),
                Text(
                  isPremium ? 'Limites ilimitados liberados!' : '2 cotações / 10 mensagens por dia.',
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
              ],
            ),
          ),
          if (!isPremium)
            ElevatedButton(
              onPressed: () => _showUpgradeDialog(context, notifier),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber[700],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('UPGRADE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
        ],
      ),
    );
  }

  Widget _buildSavingsSummary(BuildContext context, BuyerDashboardState state) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E293B).withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ECONOMIA ACUMULADA',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _currencyFormat.format(state.totalSavings),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.auto_graph, color: Colors.greenAccent, size: 28),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Icon(Icons.info_outline, color: Colors.white38, size: 14),
              const SizedBox(width: 6),
              Text(
                'Economia total com base nas menores ofertas recebidas.',
                style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuotaOverview(BuildContext context, BuyerDashboardState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Uso da Quota (Hoje)',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildQuotaIndicator(
                'Cotações',
                state.quotationUsage,
                const Color(0xFF3B82F6),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildQuotaIndicator(
                'WhatsApp',
                state.whatsappUsage,
                const Color(0xFF10B981),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuotaIndicator(String label, double ratio, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
          const SizedBox(height: 12),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 60,
                width: 60,
                child: CircularProgressIndicator(
                  value: ratio,
                  strokeWidth: 8,
                  backgroundColor: color.withOpacity(0.1),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
              Text(
                '${(ratio * 100).toInt()}%',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentQuotationsHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Cotações Recentes',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
        ),
        TextButton(
          onPressed: () {},
          child: const Text('Ver todas'),
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          Icon(Icons.assignment_outlined, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'Nenhuma cotação recente.',
            style: TextStyle(color: Colors.grey[500], fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildQuotationCard(BuildContext context, dynamic q) {
    final dateFormat = DateFormat('dd/MM HH:mm');
    
    Color statusColor;
    String statusLabel;
    IconData statusIcon;

    switch (q.status) {
      case 'draft':
        statusColor = const Color(0xFF94A3B8); // Slate 400
        statusLabel = 'Rascunho';
        statusIcon = Icons.edit_document;
        break;
      case 'sent':
        statusColor = const Color(0xFF3B82F6); // Blue 500
        statusLabel = 'Enviada';
        statusIcon = Icons.alternate_email;
        break;
      case 'analyzing':
        statusColor = const Color(0xFFF59E0B); // Amber 500
        statusLabel = 'Analisando';
        statusIcon = Icons.query_stats;
        break;
      case 'finished':
        statusColor = const Color(0xFF10B981); // Emerald 500
        statusLabel = 'Concluída';
        statusIcon = Icons.verified_user_outlined;
        break;
      default:
        statusColor = Colors.blueGrey;
        statusLabel = q.status;
        statusIcon = Icons.help_outline;
    }
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: statusColor.withOpacity(0.1), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: statusColor.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => context.push('/quotation-detail/${q.id}'),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(statusIcon, color: statusColor, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Cotação #${q.id}',
                            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Color(0xFF1E293B)),
                          ),
                          const SizedBox(width: 8),
                          _buildStatusBadge(statusLabel, statusColor),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Atualizado em ${dateFormat.format(q.date)}',
                        style: TextStyle(color: Colors.grey[500], fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios, color: Colors.grey[300], size: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Future<void> _showUpgradeDialog(BuildContext context, BuyerDashboardNotifier notifier) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Mudar para Premium?'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             Icon(Icons.workspace_premium, color: Colors.amber, size: 64),
             SizedBox(height: 16),
             Text(
               'Liberte-se dos limites!',
               style: TextStyle(fontWeight: FontWeight.bold),
             ),
             SizedBox(height: 8),
             Text(
               '• Cotações ilimitadas\n'
               '• Mensagens de WhatsApp ilimitadas\n'
               '• Suporte prioritário\n'
               '• Acesso à Rede CotaZap completa',
               textAlign: TextAlign.left,
             ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Agora não')),
          ElevatedButton(
            onPressed: () async {
               Navigator.pop(context);
               final success = await notifier.upgradeToPremium();
               if (success) {
                 ScaffoldMessenger.of(context).showSnackBar(
                   const SnackBar(
                     content: Text('Parabéns! Você agora é Premium!'),
                     backgroundColor: Colors.green,
                   ),
                 );
               }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber[700]), 
            child: const Text('ATIVAR PREMIUM', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
