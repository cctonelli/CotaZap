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
    AppLogger.info('Iniciando sincronização de Unidades de Medida...', tag: 'UoM');
    
    // 1. Local
    try {
      final list = await dao.getAllActive();
      AppLogger.info('UoM locais encontradas: ${list.length}', tag: 'UoM');
      if (list.isNotEmpty) {
        state = state.copyWith(units: list, isLoading: false);
      }
    } catch (e) {
      AppLogger.error('Erro ao ler UoM locais', error: e, tag: 'UoM');
    }

    // 2. Remote Sync
    try {
      AppLogger.info('Buscando UoM remotas do Supabase...', tag: 'UoM');
      final remoteData = await SupabaseService.fetchTable(table: 'units_of_measure');
      AppLogger.info('UoM remotas recebidas: ${remoteData.length}', tag: 'UoM');
      
      final List<UnitsOfMeasureData> tempList = [];

      if (remoteData.isNotEmpty) {
        for (var item in remoteData) {
          // Garantir ID inteiro (convertendo de string se necessário no Supabase)
          final int rawId = item['id'] is String ? int.parse(item['id']) : (item['id'] as int);

          final mapped = UnitsOfMeasureData(
            id: rawId,
            code: item['code']?.toString() ?? '',
            name: item['name']?.toString() ?? '',
            description: item['description']?.toString(),
            category: item['category']?.toString(),
            isActive: item['is_active'] ?? true, // Default true se a coluna não existir
            isSynced: true,
            lastUpdated: DateTime.now(),
          );
          tempList.add(mapped);

          try {
            await dao.upsertUnit(UnitsOfMeasureCompanion(
              id: Value(rawId),
              code: Value(item['code']?.toString() ?? ''),
              name: Value(item['name']?.toString() ?? ''),
              description: Value(item['description']?.toString()),
              category: Value(item['category']?.toString()),
              isActive: Value(item['is_active'] ?? true),
              isSynced: const Value(true),
            ));
          } catch (e) {
            // Ignora erros individuais de persistência para não travar a lista
          }
        }
        
        try {
          final updated = await dao.getAllActive();
          AppLogger.success('UoM sincronizadas com sucesso. Total: ${updated.length}', tag: 'UoM');
          state = state.copyWith(units: updated.isNotEmpty ? updated : tempList, isLoading: false);
        } catch (e) {
          AppLogger.error('Erro ao atualizar estado UoM', error: e, tag: 'UoM');
          state = state.copyWith(units: tempList, isLoading: false);
        }
      } else {
        AppLogger.warning('Nenhuma UoM encontrada no Supabase.', tag: 'UoM');
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      AppLogger.error('Falha crítica na sincronização de UoM', error: e, tag: 'UoM');
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> forceRefresh() => _init();
}
