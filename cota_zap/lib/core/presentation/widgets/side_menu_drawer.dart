import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cota_zap/core/di/injection.dart';
import 'package:go_router/go_router.dart';
import 'package:cota_zap/features/auth/presentation/controllers/auth_controller.dart';
import 'package:cota_zap/core/network/supabase_service.dart';

class SideMenuDrawer extends ConsumerWidget {
  const SideMenuDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userRole = ref.watch(userRoleProvider);

    return Drawer(
      child: Column(
        children: [
          _buildDrawerHeader(context),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                if (userRole == UserRole.buyer) ..._buildBuyerMenu(context),
                if (userRole == UserRole.supplier) ..._buildSupplierMenu(context),
                if (userRole == UserRole.admin) ..._buildAdminMenu(context),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.swap_horiz, color: Colors.blue),
                  title: const Text('Alternar Perfil'),
                  onTap: () {
                    context.go('/onboarding');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.bug_report, color: Colors.orange),
                  title: const Text('Diagnósticos'),
                  onTap: () {
                    context.push('/diagnostics');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.redAccent),
                  title: const Text('Sair'),
                  onTap: () async {
                    Navigator.pop(context); // Fecha o drawer
                    await ref.read(authControllerProvider.notifier).signOut();
                    if (context.mounted) {
                      context.go('/login');
                    }
                  },
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'CotaZap v1.5',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context) {
    return DrawerHeader(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF075E54), Color(0xFF128C7E)],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 60,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.bolt,
                size: 60,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'CotaZap',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              SupabaseService.client.auth.currentUser?.email ?? 'Usuário não logado',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildBuyerMenu(BuildContext context) {
    return [
      _buildMenuItem(
        context,
        icon: Icons.dashboard,
        title: 'Painel Dashboard',
        route: '/buyer-dashboard',
      ),
      _buildMenuItem(
        context,
        icon: Icons.add_circle_outline,
        title: 'Nova Cotação',
        route: '/new-quotation',
      ),
      _buildMenuItem(
        context,
        icon: Icons.storefront,
        title: 'Fornecedores',
        route: '/suppliers',
      ),
      _buildMenuItem(
        context,
        icon: Icons.inventory_2,
        title: 'Produtos',
        route: '/products',
      ),
      _buildMenuItem(
        context,
        icon: Icons.person,
        title: 'Meus Dados (Comprador)',
        route: '/buyer-profile',
      ),
      _buildMenuItem(
        context,
        icon: Icons.link,
        title: 'Vincular Produtos',
        route: '/supplier-product-links',
      ),
    ];
  }

  List<Widget> _buildSupplierMenu(BuildContext context) {
    return [
      _buildMenuItem(
        context,
        icon: Icons.dashboard,
        title: 'Painel Fornecedor',
        route: '/supplier-dashboard',
      ),
      _buildMenuItem(
        context,
        icon: Icons.assignment_returned,
        title: 'Cotações Recebidas',
        route: '/quotations',
      ),
      _buildMenuItem(
        context,
        icon: Icons.account_circle,
        title: 'Meus Dados (Fornecedor)',
        route: '/supplier-profile',
      ),
    ];
  }

  List<Widget> _buildAdminMenu(BuildContext context) {
    return [
      _buildMenuItem(
        context,
        icon: Icons.admin_panel_settings,
        title: 'Painel Admin',
        route: '/admin-dashboard',
      ),
      _buildMenuItem(
        context,
        icon: Icons.verified_user,
        title: 'Verificar Fornecedores',
        route: '/admin-verifications',
      ),
      _buildMenuItem(
        context,
        icon: Icons.analytics,
        title: 'Métricas da Rede',
        route: '/admin-metrics',
      ),
    ];
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String route,
  }) {
    final currentPath = GoRouterState.of(context).uri.toString();
    final isSelected = currentPath == route;

    return ListTile(
      leading: Icon(icon, color: isSelected ? const Color(0xFF128C7E) : null),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? const Color(0xFF128C7E) : null,
        ),
      ),
      selected: isSelected,
      onTap: () {
        Navigator.pop(context); // Close drawer
        context.go(route);
      },
    );
  }
}
