import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cota_zap/features/quotation/presentation/pages/new_quotation_page.dart';
import 'package:cota_zap/features/onboarding/presentation/pages/onboarding_role_page.dart';
import 'package:cota_zap/features/supplier_profile/presentation/pages/supplier_profile_page.dart';
import 'package:cota_zap/features/buyer_profile/presentation/pages/buyer_profile_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/onboarding',
    routes: [
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
        builder: (context, state) => const PlaceholderScaffold(title: 'Fornecedores'),
      ),
      GoRoute(
        path: '/products',
        builder: (context, state) => const PlaceholderScaffold(title: 'Produtos'),
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
