import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cota_zap/features/quotation/presentation/pages/new_quotation_page.dart';
import 'package:cota_zap/features/onboarding/presentation/pages/onboarding_role_page.dart';
import 'package:cota_zap/features/supplier_profile/presentation/pages/supplier_profile_page.dart';
import 'package:cota_zap/features/buyer_profile/presentation/pages/buyer_profile_page.dart';
import 'package:cota_zap/features/auth/presentation/pages/login_page.dart';
import 'package:cota_zap/features/auth/presentation/pages/register_page.dart';
import 'package:cota_zap/features/admin/presentation/pages/category_management_page.dart';
import 'package:cota_zap/features/admin/presentation/pages/unit_of_measure_management_page.dart';

import 'package:cota_zap/features/suppliers/presentation/pages/suppliers_list_page.dart';
import 'package:cota_zap/features/products/presentation/pages/products_list_page.dart';
import 'package:cota_zap/features/products/presentation/pages/supplier_product_links_page.dart';
import 'package:cota_zap/features/admin/presentation/pages/admin_dashboard_page.dart';
import 'package:cota_zap/features/supplier/presentation/pages/supplier_dashboard_page.dart';
import 'package:cota_zap/features/dashboard/presentation/pages/buyer_dashboard_page.dart';
import 'package:cota_zap/features/quotation/presentation/pages/quotation_detail_page.dart';
import 'package:cota_zap/features/quotation/presentation/pages/quotation_comparison_page.dart';
import 'package:cota_zap/core/presentation/pages/diagnostics_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingRolePage(),
      ),
      GoRoute(
        path: '/quotations',
        builder: (context, state) => const NewQuotationPage(),
      ),
      GoRoute(
        path: '/supplier-profile',
        builder: (context, state) => const SupplierProfilePage(),
      ),
      GoRoute(
        path: '/buyer-profile',
        builder: (context, state) => const BuyerProfilePage(),
      ),
      GoRoute(
        path: '/new-quotation',
        builder: (context, state) => const NewQuotationPage(),
      ),
      GoRoute(
        path: '/suppliers',
        builder: (context, state) => const SuppliersListPage(),
      ),
      GoRoute(
        path: '/products',
        builder: (context, state) => const ProductsListPage(),
      ),
      GoRoute(
        path: '/supplier-product-links',
        builder: (context, state) => const SupplierProductLinksPage(),
      ),
      GoRoute(
        path: '/diagnostics',
        builder: (context, state) => const DiagnosticsPage(),
      ),
      GoRoute(
        path: '/admin-dashboard',
        builder: (context, state) => const AdminDashboardPage(),
      ),
      GoRoute(
        path: '/admin/categories',
        builder: (context, state) => const CategoryManagementPage(),
      ),
      GoRoute(
        path: '/admin/units',
        builder: (context, state) => const UnitOfMeasureManagementPage(),
      ),
      GoRoute(
        path: '/supplier-dashboard',
        builder: (context, state) => const SupplierDashboardPage(),
      ),
      GoRoute(
        path: '/buyer-dashboard',
        builder: (context, state) => const BuyerDashboardPage(),
      ),
      GoRoute(
        path: '/quotation-detail/:id',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return QuotationDetailPage(quotationId: id);
        },
      ),
      GoRoute(
        path: '/quotation-comparison/:id',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return QuotationComparisonPage(quotationId: id);
        },
      ),
    ],
  );
}

class PlaceholderScaffold extends StatelessWidget {
  final String title;
  const PlaceholderScaffold({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('Bem-vindo ao CotaZap: $title')),
    );
  }
}
