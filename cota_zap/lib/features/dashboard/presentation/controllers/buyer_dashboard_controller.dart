import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/quota_service.dart';
import '../../../../drift/daos/quotations_dao.dart';
import '../../../../drift/database.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/network/supabase_service.dart';
import '../../../../core/utils/app_logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:drift/drift.dart';

class BuyerDashboardState {
  final double quotationUsage;
  final double whatsappUsage;
  final List<Quotation> recentQuotations;
  final String userPlan;
  final double totalSavings;
  final bool isLoading;

  BuyerDashboardState({
    this.quotationUsage = 0.0,
    this.whatsappUsage = 0.0,
    this.recentQuotations = const [],
    this.totalSavings = 0.0,
    this.userPlan = 'free',
    this.isLoading = true,
  });

  BuyerDashboardState copyWith({
    double? quotationUsage,
    double? whatsappUsage,
    List<Quotation>? recentQuotations,
    double? totalSavings,
    String? userPlan,
    bool? isLoading,
  }) {
    return BuyerDashboardState(
      quotationUsage: quotationUsage ?? this.quotationUsage,
      whatsappUsage: whatsappUsage ?? this.whatsappUsage,
      recentQuotations: recentQuotations ?? this.recentQuotations,
      totalSavings: totalSavings ?? this.totalSavings,
      userPlan: userPlan ?? this.userPlan,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class BuyerDashboardNotifier extends AutoDisposeNotifier<BuyerDashboardState> {
  @override
  BuyerDashboardState build() {
    // Inicializa carregando os dados
    Future.microtask(() => refreshDashboard());
    return BuyerDashboardState();
  }

  QuotaService get _quotaService => ref.read(quotaServiceProvider);
  QuotationsDao get _quotationsDao => ref.read(quotationsDaoProvider);
  SupabaseClient get _supabase => ref.read(supabaseClientProvider);

  Future<void> refreshDashboard() async {
    state = state.copyWith(isLoading: true);
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return;
      
      // 0. Sincroniza dados do Supabase para Drift
      await _syncFromSupabase(userId);

      // 1. Atualiza Quotas
      final qUsage = await _quotaService.getUsageRatio(userId, QuotaType.quotations);
      final wUsage = await _quotaService.getUsageRatio(userId, QuotaType.whatsappMessages);

      // 2. Busca Cotações Recentes
      final recent = await _quotationsDao.getRecentQuotations(userId, limit: 5);

      // 3. Calcula Economia Total
      final savings = await _quotationsDao.getTotalAccumulatedEconomy(userId);

      // 4. Busca Plano Atual
      final profile = await _supabase
          .from('profiles')
          .select('plan_type')
          .eq('id', userId)
          .single();
      
      final plan = profile['plan_type'] ?? 'free';
      ref.read(planTypeProvider.notifier).state = plan;

      state = state.copyWith(
        quotationUsage: qUsage,
        whatsappUsage: wUsage,
        recentQuotations: recent,
        totalSavings: savings,
        userPlan: plan,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> _syncFromSupabase(String userId) async {
    final db = ref.read(databaseProvider);
    try {
      final remoteQuots = await SupabaseService.fetchTable(
        table: 'quotations',
        filter: {'buyer_id': userId},
      );
      
      if (remoteQuots.isNotEmpty) {
        for (var q in remoteQuots) {
          await db.into(db.quotations).insertOnConflictUpdate(
            QuotationsCompanion(
              id: Value(q['id'] as int),
              buyerId: Value(q['buyer_id'] as String),
              date: Value(DateTime.parse(q['created_at'] ?? q['date'] ?? DateTime.now().toIso8601String())),
              status: Value(q['status'] as String),
              templateMessage: Value(q['template_message'] ?? ''),
              totalEconomy: Value((q['total_economy'] ?? 0.0) as double),
              winnerSupplierId: Value(q['winner_supplier_id'] as int?),
              defaultPaymentCondition: Value(q['default_payment_condition'] as String?),
              defaultPaymentTermDays: Value(q['default_payment_term_days'] as int?),
              defaultLeadTimeDays: Value(q['default_lead_time_days'] as int?),
              defaultDeliveryType: Value(q['default_delivery_type'] as String?),
            ),
          );
        }
        AppLogger.success('${remoteQuots.length} cotações sincronizadas do Supabase.', tag: 'Dashboard');
      }
    } catch (e) {
      AppLogger.error('Erro ao sincronizar cotações', error: e, tag: 'Dashboard');
    }
  }

  Future<bool> upgradeToPremium() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return false;

      await _quotaService.syncQuotas(userId, 'premium');
      await refreshDashboard();
      return true;
    } catch (e) {
      return false;
    }
  }
}

final buyerDashboardProvider = NotifierProvider.autoDispose<BuyerDashboardNotifier, BuyerDashboardState>(() {
  return BuyerDashboardNotifier();
});
