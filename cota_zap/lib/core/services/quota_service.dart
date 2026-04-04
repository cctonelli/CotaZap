import 'package:drift/drift.dart';
import '../../drift/database.dart';
import '../../drift/daos/usage_quotas_dao.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum QuotaType {
  quotations,
  whatsappMessages,
  products,
}

extension QuotaTypeExtension on QuotaType {
  String get value {
    switch (this) {
      case QuotaType.quotations:
        return 'quotation_daily';
      case QuotaType.whatsappMessages:
        return 'whatsapp_daily';
      case QuotaType.products:
        return 'product_total';
    }
  }
}

// QuotaService logic
class QuotaService {
  final UsageQuotasDao _quotasDao;
  // ignore: unused_field
  final SupabaseClient _supabase;

  QuotaService(this._quotasDao, this._supabase);

  /// Verifica se o usuário tem saldo na quota especificada.
  Future<bool> canPerformAction(String userId, String plan, QuotaType type) async {
    var quota = await _quotasDao.getQuota(userId, type.value);

    // Se não existir, inicializa
    if (quota == null) {
      await _initializeDefaultQuotas(userId);
      quota = await _quotasDao.getQuota(userId, type.value);
    }

    if (quota == null) return false;

    // Reset Diário para cotações e mensagens
    if (type != QuotaType.products) {
      final now = DateTime.now();
      final lastReset = quota.lastResetAt;
      
      if (lastReset.day != now.day || lastReset.month != now.month || lastReset.year != now.year) {
        // Reseta conforme o plano do usuário (se for premium, limite é alto)
        final newLimit = plan == 'premium' ? 9999 : (type == QuotaType.quotations ? 2 : 10);
        await _quotasDao.resetQuota(userId, type.value, newLimit);
        return true;
      }
    }

    return quota.usedCount < quota.limitCount;
  }

  /// Incrementa o uso de uma quota após uma ação bem-sucedida.
  Future<void> recordAction(String userId, QuotaType type) async {
    await _quotasDao.incrementUsage(userId, type.value);
    
    // Sync remoto opcional em foreground/background
    try {
      final quota = await _quotasDao.getQuota(userId, type.value);
      if (quota != null) {
        await _supabase.from('usage_quotas').upsert({
          'owner_id': userId,
          'quota_type': type.value,
          'used_count': quota.usedCount,
          'limit_count': quota.limitCount,
          'last_reset_at': quota.lastResetAt.toIso8601String(),
        });
      }
    } catch (e) {
      // Ignora erro de rede no sync de quota para não travar o app
    }
  }

  /// Retorna o percentual de uso (0.0 a 1.0)
  Future<double> getUsageRatio(String userId, QuotaType type) async {
    final quota = await _quotasDao.getQuota(userId, type.value);
    if (quota == null || quota.limitCount == 0) return 0.0;
    return (quota.usedCount / quota.limitCount).clamp(0.0, 1.0);
  }

  Future<void> _initializeDefaultQuotas(String userId) async {
    final defaults = [
      UsageQuotasCompanion.insert(
        ownerId: userId,
        quotaType: QuotaType.quotations.value,
        limitCount: 2,
        usedCount: const Value(0),
        lastResetAt: Value(DateTime.now()),
      ),
      UsageQuotasCompanion.insert(
        ownerId: userId,
        quotaType: QuotaType.whatsappMessages.value,
        limitCount: 10,
        usedCount: const Value(0),
        lastResetAt: Value(DateTime.now()),
      ),
    ];

    for (final companion in defaults) {
      await _quotasDao.insertOrUpdateQuota(companion);
    }
  }

  Future<void> syncQuotas(String userId, String plan) async {
    // Atualiza limites locais no banco Drift baseado no plano
    int quotationLimit = (plan == 'premium' || plan == 'profissional') ? 9999 : 5;
    int whatsappLimit = (plan == 'premium' || plan == 'profissional') ? 99999 : 10;
    
    await _quotasDao.resetQuota(userId, QuotaType.quotations.value, quotationLimit);
    await _quotasDao.resetQuota(userId, QuotaType.whatsappMessages.value, whatsappLimit);
    
    // Busca uso remoto do Supabase para atualizar o local
    try {
      final remoteData = await _supabase.from('usage_quotas').select().eq('owner_id', userId);
      if (remoteData.isNotEmpty) {
        for (var q in remoteData) {
          await _quotasDao.insertOrUpdateQuota(UsageQuotasCompanion.insert(
            ownerId: userId,
            quotaType: q['quota_type'],
            usedCount: Value(q['used_count']),
            limitCount: q['limit_count'],
            lastResetAt: Value(DateTime.tryParse(q['last_reset_at'] ?? '') ?? DateTime.now()),
          ));
        }
      }
    } catch (e) {
      // Offline ou erro de rede
    }
  }
}
