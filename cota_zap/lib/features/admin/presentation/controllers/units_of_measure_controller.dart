import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import 'package:cota_zap/drift/database.dart';
import 'package:cota_zap/core/di/injection.dart';
import 'package:cota_zap/core/network/supabase_service.dart';
import 'package:cota_zap/core/utils/app_logger.dart';

class UnitsState {
  final List<UnitsOfMeasureData> units;
  final bool isLoading;

  UnitsState({
    this.units = const [],
    this.isLoading = false,
  });

  UnitsState copyWith({
    List<UnitsOfMeasureData>? units,
    bool? isLoading,
  }) {
    return UnitsState(
      units: units ?? this.units,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

final unitsControllerProvider = NotifierProvider<UnitsController, UnitsState>(UnitsController.new);

class UnitsController extends Notifier<UnitsState> {
  @override
  UnitsState build() {
    Future.microtask(() => _init());
    return UnitsState(isLoading: true);
  }

  Future<void> _init() async {
    final dao = ref.read(unitsOfMeasureDaoProvider);
    
    // 1. Local
    try {
      final list = await dao.getAllActive();
      if (list.isNotEmpty) {
        state = state.copyWith(units: list, isLoading: false);
      }
    } catch (e) {
      AppLogger.error('Erro local UoM', error: e);
    }

    // 2. Remote Sync
    try {
      final remoteData = await SupabaseService.fetchTable(table: 'units_of_measure');
      final List<UnitsOfMeasureData> tempList = [];

      if (remoteData.isNotEmpty) {
        for (var item in remoteData) {
          final mapped = UnitsOfMeasureData(
            id: item['id'],
            code: item['code'],
            name: item['name'],
            description: item['description'],
            category: item['category'],
            isActive: item['is_active'] ?? true,
            isSynced: true,
            lastUpdated: DateTime.now(),
          );
          tempList.add(mapped);

          try {
            await dao.upsertUnit(UnitsOfMeasureCompanion(
              id: Value(item['id']),
              code: Value(item['code']),
              name: Value(item['name']),
              description: Value(item['description']),
              category: Value(item['category']),
              isActive: Value(item['is_active'] ?? true),
              isSynced: const Value(true),
            ));
          } catch (_) {}
        }
        
        try {
          final updated = await dao.getAllActive();
          state = state.copyWith(units: updated.isNotEmpty ? updated : tempList, isLoading: false);
        } catch (_) {
          state = state.copyWith(units: tempList, isLoading: false);
        }
      }
    } catch (e) {
      AppLogger.error('Erro sync UoM', error: e);
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> forceRefresh() => _init();
}
