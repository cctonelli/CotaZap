import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cota_zap/core/di/injection.dart';
import 'package:go_router/go_router.dart';

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
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.swap_horiz, color: Colors.blue),
                  title: const Text('Alternar Perfil'),
                  onTap: () {
                    context.go('/onboarding');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.redAccent),
                  title: const Text('Sair'),
                  onTap: () {
                    // Implement Logout logic
                  },
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'CotaZap v1.4',
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
        title: 'Minhas Cotações',
        route: '/quotations',
      ),
      _buildMenuItem(
        context,
        icon: Icons.person,
        title: 'Meus Dados (Comprador)',
        route: '/buyer-profile',
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
        icon: Icons.assignment_returned,
        title: 'Cotações Recebidas',
        route: '/quotations', // Reuse or create a supplier-specific dashboard
      ),
      _buildMenuItem(
        context,
        icon: Icons.account_circle,
        title: 'Meus Dados (Fornecedor)',
        route: '/supplier-profile',
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
