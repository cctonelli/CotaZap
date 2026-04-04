import 'package:drift/drift.dart';
import '../database.dart';
import '../schema.dart';

part 'units_of_measure_dao.g.dart';

@DriftAccessor(tables: [UnitsOfMeasure])
class UnitsOfMeasureDao extends DatabaseAccessor<AppDatabase> with _$UnitsOfMeasureDaoMixin {
  UnitsOfMeasureDao(AppDatabase db) : super(db);

  Future<List<UnitsOfMeasureData>> getAllActive() {
    return (select(unitsOfMeasure)..where((t) => t.isActive.equals(true))).get();
  }

  Future<int> upsertUnit(UnitsOfMeasureCompanion entry) {
    return into(unitsOfMeasure).insertOnConflictUpdate(entry);
  }
}
