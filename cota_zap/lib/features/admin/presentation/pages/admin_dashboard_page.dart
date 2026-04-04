import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cota_zap/core/presentation/widgets/side_menu_drawer.dart';
import 'package:cota_zap/features/admin/presentation/controllers/admin_controller.dart';

class AdminDashboardPage extends ConsumerWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(adminControllerProvider);
    final controller = ref.read(adminControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Painel Administrativo'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const SideMenuDrawer(),
      body: state.isLoading 
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStatCards(state.pendingCategoryRequests.length),
                const SizedBox(height: 24),
                const Text(
                  'Ações Rápidas',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                _buildQuickActions(context),
                const SizedBox(height: 24),
                Text(
                  'Solicitações de Categorias (${state.pendingCategoryRequests.length})',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                _buildCategoryRequests(state, controller),
              ],
            ),
          ),
    );
  }

  Widget _buildStatCards(int pendingRequests) {
    return Row(
      children: [
        const _StatCard(title: 'Compradores', value: '1,240', icon: Icons.people, color: Colors.blue),
        const SizedBox(width: 12),
        _StatCard(title: 'Solicitações', value: pendingRequests.toString(), icon: Icons.pending_actions, color: Colors.orange),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.5,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      children: [
        _ActionCard(
          title: 'Categorias',
          icon: Icons.category,
          onTap: () => context.push('/admin/categories'),
          color: Colors.purple,
        ),
        _ActionCard(
          title: 'Unidades',
          icon: Icons.straighten,
          onTap: () => context.push('/admin/units'),
          color: Colors.orange,
        ),
        _ActionCard(
          title: 'Planos/Preços',
          icon: Icons.payments,
          onTap: () {},
          color: Colors.green,
        ),
        _ActionCard(
          title: 'Notificações',
          icon: Icons.notifications,
          onTap: () {},
          color: Colors.red,
        ),
        _ActionCard(
          title: 'Configurações',
          icon: Icons.settings,
          onTap: () {},
          color: Colors.grey,
        ),
      ],
    );
  }

  Widget _buildCategoryRequests(AdminState state, AdminController controller) {
    if (state.pendingCategoryRequests.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Nenhuma solicitação pendente no momento.'),
        ),
      );
    }

    return Card(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: state.pendingCategoryRequests.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final req = state.pendingCategoryRequests[index];
          return ListTile(
            leading: const CircleAvatar(child: Icon(Icons.category_outlined)),
            title: Text(req.name),
            subtitle: Text(req.description ?? 'Sem descrição'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.check, color: Colors.green),
                  onPressed: () => controller.approveCategory(req.id, 'inventory'),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.red),
                  onPressed: () => controller.rejectCategory(req.id),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(title, style: TextStyle(color: Colors.grey[700])),
          ],
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color color;

  const _ActionCard({
    required this.title,
    required this.icon,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
