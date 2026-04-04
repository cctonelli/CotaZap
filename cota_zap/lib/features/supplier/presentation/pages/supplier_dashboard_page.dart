import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cota_zap/core/presentation/widgets/side_menu_drawer.dart';
import 'package:cota_zap/core/di/injection.dart';
import 'package:cota_zap/features/products/presentation/controllers/products_controller.dart';
import 'package:go_router/go_router.dart';

class SupplierDashboardPage extends ConsumerWidget {
  const SupplierDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final planType = ref.watch(planTypeProvider);
    final productsState = ref.watch(productsControllerProvider);
    final productsCount = productsState.products.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Painel do Fornecedor'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      drawer: const SideMenuDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPlanNotice(planType, productsCount),
            const SizedBox(height: 24),
            const Text(
              'Próximos Passos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildActionItems(context),
            const SizedBox(height: 24),
            const Text(
              'Cotações Recebidas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildEmptyState(),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanNotice(String plan, int count) {
    int limit = 15;
    if (plan == 'basic') limit = 50;
    if (plan == 'pro' || plan == 'premium') limit = 999999;

    final isFull = count >= limit;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: (isFull ? Colors.red : Colors.blue).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: (isFull ? Colors.red : Colors.blue).withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(isFull ? Icons.warning_amber : Icons.info_outline, color: isFull ? Colors.red : Colors.blue),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Seu Plano: ${plan.toUpperCase()}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('Você usou $count de ${limit > 10000 ? "∞" : limit} produtos cadastrados.'),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Upgrade'),
          ),
        ],
      ),
    );
  }

  Widget _buildActionItems(BuildContext context) {
    return Column(
      children: [
        _ActionItem(
          title: 'Cadastrar Meus Produtos',
          subtitle: 'Adicione itens para que compradores encontrem você.',
          icon: Icons.add_circle_outline,
          onTap: () => context.push('/products'),
        ),
        const SizedBox(height: 12),
        _ActionItem(
          title: 'Completar Perfil',
          subtitle: 'Aumente suas chances com um perfil verificado.',
          icon: Icons.verified_user,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Icon(Icons.assignment_late_outlined, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            const Text(
              'Nenhuma cotação pendente.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            const Text(
              'Compradores que buscam seus produtos entrarão em contato.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _ActionItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.orange, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
