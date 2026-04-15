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
      expandedHeight: 140.0,
      pinned: true,
      stretch: true,
      backgroundColor: AppTheme.primaryColor,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [StretchMode.zoomBackground, StretchMode.blurBackground],
        titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        title: Text(
          'Meu Dashboard',
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 22,
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2563EB), Color(0xFF4F46E5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Positioned(
              right: -20,
              top: -20,
              child: CircleAvatar(
                radius: 80,
                backgroundColor: Colors.white.withOpacity(0.05),
              ),
            ),
          ],
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded, color: Colors.white, size: 22),
          ),
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
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(32),
        image: DecorationImage(
          image: const NetworkImage('https://www.transparenttextures.com/patterns/carbon-fibre.png'),
          opacity: 0.05,
          colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.1), BlendMode.srcATop),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
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
                  Text(
                    'ECONOMIA REAL',
                    style: GoogleFonts.plusJakartaSans(
                      color: const Color(0xFF94A3B8),
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2.0,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _currencyFormat.format(state.totalSavings),
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontSize: 38,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1.5,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.emerald.shade400, Colors.emerald.shade700],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.emerald.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.trending_up_rounded, color: Colors.white, size: 32),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Container(
                width: 4,
                height: 4,
                decoration: const BoxDecoration(color: Colors.emeraldAccent, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Text(
                'Performance baseada em ${state.recentQuotations.length} cotações ativas',
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withOpacity(0.05), width: 1),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.w700,
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 16),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 70,
                width: 70,
                child: CircularProgressIndicator(
                  value: ratio,
                  strokeWidth: 10,
                  strokeCap: StrokeCap.round,
                  backgroundColor: color.withOpacity(0.1),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
              Text(
                '${(ratio * 100).toInt()}%',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                  color: const Color(0xFF1E293B),
                ),
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
        statusColor = const Color(0xFF64748B);
        statusLabel = 'Rascunho';
        statusIcon = Icons.edit_note_rounded;
        break;
      case 'sent':
        statusColor = const Color(0xFF3B82F6);
        statusLabel = 'Enviada';
        statusIcon = Icons.send_rounded;
        break;
      case 'analyzing':
        statusColor = const Color(0xFFF59E0B);
        statusLabel = 'Analisando';
        statusIcon = Icons.auto_graph_rounded;
        break;
      case 'finished':
        statusColor = const Color(0xFF10B981);
        statusLabel = 'Concluída';
        statusIcon = Icons.check_circle_rounded;
        break;
      default:
        statusColor = Colors.blueGrey;
        statusLabel = q.status;
        statusIcon = Icons.help_center_rounded;
    }
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () => context.push('/quotation-detail/${q.id}'),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [statusColor.withOpacity(0.15), statusColor.withOpacity(0.05)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(statusIcon, color: statusColor, size: 26),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Cotação #${q.id}',
                            style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w800,
                              fontSize: 17,
                              color: const Color(0xFF1E293B),
                            ),
                          ),
                          _buildStatusBadge(statusLabel, statusColor),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.access_time_rounded, size: 14, color: Colors.grey[400]),
                          const SizedBox(width: 4),
                          Text(
                            'Atualizado em ${dateFormat.format(q.date)}',
                            style: GoogleFonts.plusJakartaSans(
                              color: const Color(0xFF94A3B8),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Icon(Icons.chevron_right_rounded, color: Colors.grey[300], size: 28),
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
