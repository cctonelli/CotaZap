import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cota_zap/core/di/injection.dart';
import 'package:cota_zap/core/utils/app_logger.dart';
import 'package:cota_zap/features/auth/domain/repositories/profile_repository.dart';

final subscriptionControllerProvider = StateNotifierProvider<SubscriptionController, AsyncValue<void>>((ref) {
  return SubscriptionController(ref);
});

class SubscriptionController extends StateNotifier<AsyncValue<void>> {
  final Ref _ref;

  SubscriptionController(this._ref) : super(const AsyncValue.data(null));

  Future<void> upgradePlan(String planType) async {
    state = const AsyncValue.loading();
    try {
      final userId = _ref.read(userIdProvider);
      if (userId == null) throw Exception('Usuário não autenticado');

      final profileRepository = _ref.read(profileRepositoryProvider);
      final quotaService = _ref.read(quotaServiceProvider);

      // 1. Atualizar Estado Local no Provider
      _ref.read(planTypeProvider.notifier).state = planType;

      // 2. Atualizar no DB Local e Cloud via Repository
      await profileRepository.updatePlanType(userId, planType);

      // 3. Atualizar Quotas no Banco Local (Via QuotaService)
      await quotaService.syncQuotas(userId, planType);

      AppLogger.info('Upgrade de plano concluído: $planType', tag: 'Subscription');
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      AppLogger.error('Erro no upgrade de plano', error: e, stackTrace: stack, tag: 'Subscription');
      state = AsyncValue.error(e, stack);
      rethrow;
    }
  }
}
