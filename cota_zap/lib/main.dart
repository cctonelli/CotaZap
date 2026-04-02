import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cota_zap/core/routes/app_router.dart';
import 'package:cota_zap/core/theme/app_theme.dart';

import 'package:cota_zap/core/network/supabase_service.dart';

Future<void> main() async {
  // Garantir a inicialização do Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar o Banco Online (Supabase)
  try {
    await SupabaseService.initialize();
  } catch (e) {
    debugPrint('Erro na inicialização do Supabase: $e');
  }

  runApp(
    const ProviderScope(
      child: CotaZapApp(),
    ),
  );
}

class CotaZapApp extends StatelessWidget {
  const CotaZapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'CotaZap',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
    );
  }
}
