import 'package:drift/drift.dart';
import '../database.dart';
import '../schema.dart';

part 'usage_quotas_dao.g.dart';

@DriftAccessor(tables: [UsageQuotas])
class UsageQuotasDao extends DatabaseAccessor<AppDatabase> with _$UsageQuotasDaoMixin {
  UsageQuotasDao(AppDatabase db) : super(db);

  Future<UsageQuota?> getQuota(String ownerId, String quotaType) {
    return (select(usageQuotas)
          ..where((t) => t.ownerId.equals(ownerId) & t.quotaType.equals(quotaType)))
        .getSingleOrNull();
  }

  Future<int> insertOrUpdateQuota(UsageQuotasCompanion quota) {
    return into(usageQuotas).insertOnConflictUpdate(quota);
  }

  Future<int> incrementUsage(String ownerId, String quotaType) async {
    final quota = await getQuota(ownerId, quotaType);
    if (quota == null) return 0;

    return (update(usageQuotas)
          ..where((t) => t.ownerId.equals(ownerId) & t.quotaType.equals(quotaType)))
        .write(UsageQuotasCompanion(usedCount: Value(quota.usedCount + 1)));
  }

  Future<int> resetQuota(String ownerId, String quotaType, int newLimit) {
    return (update(usageQuotas)
          ..where((t) => t.ownerId.equals(ownerId) & t.quotaType.equals(quotaType)))
        .write(UsageQuotasCompanion(
          usedCount: const Value(0),
          limitCount: Value(newLimit),
          lastResetAt: Value(DateTime.now()),
        ));
  }
}
