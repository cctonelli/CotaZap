import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/utils/app_logger.dart';

final subscriptionControllerProvider = StateNotifierProvider<SubscriptionController, AsyncValue<void>>((ref) {
  return SubscriptionController(ref);
});

class SubscriptionController extends StateNotifier<AsyncValue<void>> {
  final Ref _ref;
  final _supabase = Supabase.instance.client;

  SubscriptionController(this._ref) : super(const AsyncData(null));

  Future<void> upgradePlan(String planType) async {
    state = const AsyncLoading();
    try {
      final userId = _ref.read(userIdProvider);
      if (userId == null) throw Exception('Usuário não autenticado');

      // 1. Atualizar no Supabase (Simulando sucesso do Stripe)
      await _supabase
          .from('profiles')
          .update({'plan_type': planType})
          .eq('id', userId);

      // 2. Atualizar Estado Local
      _ref.read(planTypeProvider.notifier).state = planType;

      // 3. Atualizar Quotas no Banco Local (Via QuotaService)
      final quotaService = _ref.read(quotaServiceProvider);
      await quotaService.syncQuotas(userId, planType);

      AppLogger.info('Upgrade de plano concluído: $planType', tag: 'Subscription');
      state = const AsyncData(null);
    } catch (e, stack) {
      AppLogger.error('Erro no upgrade de plano', error: e, stackTrace: stack, tag: 'Subscription');
      state = AsyncError(e, stack);
      rethrow;
    }
  }

  Future<void> downgradePlan(String planType) async {
    // Mesma lógica se necessário
    await upgradePlan(planType);
  }
}
