import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import 'package:cota_zap/drift/database.dart';
import 'package:cota_zap/core/di/injection.dart';
import 'package:cota_zap/core/network/supabase_service.dart';
import 'package:cota_zap/core/utils/app_logger.dart';

class CategoriesState {
  final List<ProductCategory> categories;
  final int? selectedCategoryId;
  final bool isLoading;

  CategoriesState({
    this.categories = const [],
    this.selectedCategoryId,
    this.isLoading = false,
  });

  CategoriesState copyWith({
    List<ProductCategory>? categories,
    int? selectedCategoryId,
    bool? isLoading,
  }) {
    return CategoriesState(
      categories: categories ?? this.categories,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

final categoriesControllerProvider = NotifierProvider<CategoriesController, CategoriesState>(CategoriesController.new);

class CategoriesController extends Notifier<CategoriesState> {
  @override
  CategoriesState build() {
    // Carrega dados locais imediatamente e inicia sync remoto
    Future.microtask(() => _init());
    return CategoriesState(isLoading: true);
  }

  Future<void> _init() async {
    final db = ref.read(databaseProvider);
    
    // 1. Carregar cache local imediatamente para a UI não ficar travada/vazia
    try {
      final list = await (db.select(db.productCategories)).get();
      if (list.isNotEmpty) {
        state = state.copyWith(categories: list, isLoading: false);
        AppLogger.info('Categorias carregadas do cache local: ${list.length}', tag: 'Categories');
      }
    } catch (e) {
      AppLogger.error('Erro ao ler cache de categorias', error: e, tag: 'Categories');
    }

    // 2. Tenta buscar do Supabase para atualizar o cache
    try {
      AppLogger.info('Sincronizando categorias com Supabase...', tag: 'Categories');
      final remoteCats = await SupabaseService.fetchTable(table: 'product_categories');
      
      AppLogger.info('Dados brutos do Supabase: $remoteCats', tag: 'Categories');

      if (remoteCats.isNotEmpty) {
        final List<ProductCategory> tempList = [];
        for (var cat in remoteCats) {
          final int rawId = cat['id'] is String ? int.parse(cat['id']) : (cat['id'] as int);
          final String catName = cat['name']?.toString() ?? 'Sem Nome';
          
          try {
            // Verifica se existe uma categoria local com o mesmo NOME mas ID diferente
            final existingByName = await (db.select(db.productCategories)
              ..where((t) => t.name.equals(catName))).getSingleOrNull();

            if (existingByName != null && existingByName.id != rawId) {
              AppLogger.warning('Corrigindo ID da categoria "$catName": Local ${existingByName.id} -> Remoto $rawId', tag: 'Categories');
              await (db.delete(db.productCategories)..where((t) => t.id.equals(existingByName.id))).go();
            }

            await db.into(db.productCategories).insertOnConflictUpdate(
              ProductCategoriesCompanion(
                id: Value(rawId),
                name: Value(catName),
                description: Value(cat['description']?.toString()),
                iconName: Value((cat['icon_name'] ?? cat['iconName'])?.toString()),
                isSynced: const Value(true),
              ),
            );
          } catch (e) {
            AppLogger.error('Falha ao sincronizar categoria individual: $catName', error: e, tag: 'Categories');
          }
          
          final mappedCat = ProductCategory(
            id: rawId,
            name: catName,
            description: cat['description']?.toString(),
            iconName: (cat['icon_name'] ?? cat['iconName'])?.toString(),
            isSynced: true,
            lastUpdated: DateTime.now(),
          );
          tempList.add(mappedCat);
        }
        
        // 3. Limpeza de categorias órfãs (o que está local mas não está no remoto)
        try {
          final localCats = await (db.select(db.productCategories)).get();
          final remoteIds = remoteCats.map((c) => 
            c['id'] is String ? int.parse(c['id']) : (c['id'] as int)
          ).toSet();

          for (var local in localCats) {
            if (!remoteIds.contains(local.id)) {
              AppLogger.warning('Removendo categoria órfã local: ${local.name} (ID: ${local.id})', tag: 'Categories');
              await (db.delete(db.productCategories)..where((t) => t.id.equals(local.id))).go();
            }
          }
        } catch (e) {
          AppLogger.error('Erro ao limpar categorias órfãs', error: e, tag: 'Categories');
        }

        // 4. Atualiza o estado com os dados finais do banco local
        try {
          final updatedList = await (db.select(db.productCategories)).get();
          state = state.copyWith(categories: updatedList, isLoading: false);
        } catch (_) {
          state = state.copyWith(categories: tempList, isLoading: false);
        }
        
        AppLogger.success('Sincronização de categorias concluída (${remoteCats.length} remotas).', tag: 'Categories');
      } else {
        AppLogger.warning('Nenhuma categoria encontrada no Supabase.', tag: 'Categories');
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      AppLogger.error('Erro ao sincronizar categorias remotas.', error: e, tag: 'Categories');
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> forceRefresh() async {
    state = state.copyWith(isLoading: true);
    await _init();
  }


  void selectCategory(int? categoryId) {
    state = state.copyWith(selectedCategoryId: categoryId);
  }

  // Filtrar fornecedores que atendem a categoria selecionada
  Future<List<AppContact>> getSuppliersForCategory(int categoryId) async {
    final db = ref.read(databaseProvider);
    final query = db.select(db.appContacts).join([
      innerJoin(
        db.supplierCategories,
        db.supplierCategories.supplierId.equalsExp(db.appContacts.id),
      ),
    ])..where(db.supplierCategories.categoryId.equals(categoryId));

    final rows = await query.get();
    return rows.map((row) => row.readTable(db.appContacts)).toList();
  }
}
