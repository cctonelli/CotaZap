import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cota_zap/drift/database.dart';
import 'package:cota_zap/core/di/injection.dart';
import 'package:cota_zap/core/network/supabase_service.dart';
import 'package:cota_zap/core/utils/app_logger.dart';
import 'package:cota_zap/features/suppliers/presentation/controllers/categories_controller.dart';
import 'package:cota_zap/core/services/quota_service.dart';
import 'package:drift/drift.dart';

class ProductsState {
  final List<Product> products;
  final bool isLoading;
  final bool showNetwork;
  final String searchQuery;
  final String? errorMessage;

  ProductsState({
    this.products = const [],
    this.isLoading = false,
    this.showNetwork = false,
    this.searchQuery = '',
    this.errorMessage,
  });

  ProductsState copyWith({
    List<Product>? products,
    bool? isLoading,
    bool? showNetwork,
    String? searchQuery,
    String? errorMessage,
  }) {
    return ProductsState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      showNetwork: showNetwork ?? this.showNetwork,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage,
    );
  }
}

final productsControllerProvider = NotifierProvider<ProductsController, ProductsState>(ProductsController.new);

class ProductsController extends Notifier<ProductsState> {
  @override
  ProductsState build() {
    // Observa o usuário para carga inicial
    final userId = ref.watch(userIdProvider);
    
    // Escuta mudanças de categoria sem resetar o estado do Notifier
    ref.listen(categoriesControllerProvider, (prev, next) {
      if (prev?.selectedCategoryId != next.selectedCategoryId) {
        _loadFiltered(next.selectedCategoryId);
      }
    });

    if (userId != null) {
      // Carga inicial
      Future.microtask(() {
        final categoryId = ref.read(categoriesControllerProvider).selectedCategoryId;
        _loadFiltered(categoryId);
      });
    }
    
    return ProductsState(isLoading: userId != null);
  }

  Future<void> _loadFiltered(int? categoryId, {bool skipSync = false}) async {
    final dao = ref.read(productsDaoProvider);
    final userId = ref.read(userIdProvider);
    
    AppLogger.info('Iniciando carga de produtos: UserID=$userId, CategoryID=$categoryId, Network=${state.showNetwork}', tag: 'Products');
    
    state = state.copyWith(isLoading: true);
    
    try {
      final list = await dao.searchUniversal(
        state.searchQuery, 
        ownerId: userId, 
        onlyNetwork: state.showNetwork,
        categoryId: categoryId,
      );

      AppLogger.info('Produtos carregados: ${list.length} itens encontrados.', tag: 'Products');
      state = state.copyWith(products: list, isLoading: false);
    } catch (e) {
      AppLogger.error('Erro ao carregar produtos do banco local', error: e, tag: 'Products');
      state = state.copyWith(isLoading: false, errorMessage: 'Erro ao carregar dados locais.');
    }
    
    // Sincroniza em background apenas se não viermos de um sync
    if (!skipSync) {
      _syncFromSupabase(categoryId);
    }
  }

  Future<void> _syncFromSupabase(int? categoryId) async {
    final userId = ref.read(userIdProvider);
    if (userId == null) return;

    final db = ref.read(databaseProvider);
    try {
      final queryFilter = <String, dynamic>{
        'or': '(owner_id.eq.$userId,is_from_rede.eq.true)'
      };
      
      if (categoryId != null) {
        queryFilter['category_id'] = categoryId;
      }

      final remoteProducts = await SupabaseService.fetchTable(
        table: 'products',
        filter: queryFilter,
      );
      
      if (remoteProducts.isNotEmpty) {
        for (var p in remoteProducts) {
          await db.into(db.products).insertOnConflictUpdate(
            ProductsCompanion(
              id: Value(p['id']),
              description: Value(p['description']),
              unitMeasure: Value(p['unit_measure']),
              packagingType: Value(p['packaging_type'] ?? 'Unidade'),
              attributesJson: Value(p['attributes_json'] ?? '{}'),
              sku: Value(p['sku']),
              categoryId: Value(p['category_id']),
              ownerId: Value(p['owner_id']),
              isFromRede: Value(p['is_from_rede'] ?? false),
              isSynced: const Value(true),
            ),
          );
        }
        // Force refresh local UI after sync, SKIPPING further syncs to avoid loop
        await _loadFiltered(categoryId, skipSync: true);
      }
    } catch (e) {
      AppLogger.error('Erro ao sincronizar produtos do Supabase', error: e, tag: 'Products');
    }
  }

  void updateSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
    final categoryId = ref.read(categoriesControllerProvider).selectedCategoryId;
    _loadFiltered(categoryId);
  }

  Future<void> toggleNetworkMode() async {
    state = state.copyWith(showNetwork: !state.showNetwork, isLoading: true);
    final categoryId = ref.read(categoriesControllerProvider).selectedCategoryId;
    await _loadFiltered(categoryId);
  }

  Future<void> searchNetwork(String query) async {
    updateSearchQuery(query);
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true);
    final categoryId = ref.read(categoriesControllerProvider).selectedCategoryId;
    await _loadFiltered(categoryId);
  }

  Future<bool> insertProduct({
    required String description,
    required String unitMeasure,
    String? sku,
    int? categoryId,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    final dao = ref.read(productsDaoProvider);
    final userRole = ref.read(userRoleProvider);
    final plan = ref.read(planTypeProvider);
    var userId = ref.read(userIdProvider);
    
    if (userId == null) {
      userId = SupabaseService.client.auth.currentUser?.id;
      if (userId != null) {
        ref.read(userIdProvider.notifier).state = userId;
      }
    }

    AppLogger.info('Tentando cadastrar novo produto: $description para usuário $userId (Categoria ID: $categoryId)', tag: 'Products');

    if (userId == null) {
      state = state.copyWith(isLoading: false, errorMessage: 'Usuário não autenticado. Faça login novamente.');
      return false;
    }

    final quotaService = ref.read(quotaServiceProvider);
    
    try {
      final canAdd = await quotaService.canPerformAction(userId, plan, QuotaType.products);
      if (!canAdd) {
        state = state.copyWith(isLoading: false, errorMessage: 'Limite de produtos atingido.');
        return false;
      }
    } catch (_) {}

    try {
      final isFromRede = userRole == UserRole.supplier;
      
      final response = await SupabaseService.client.from('products').insert({
        'description': description,
        'unit_measure': unitMeasure,
        'packaging_type': 'Unidade',
        'attributes_json': '{}',
        'sku': sku,
        'category_id': categoryId,
        'owner_id': userId,
        'is_from_rede': isFromRede,
      }).select();

      if (response.isNotEmpty) {
        final remoteId = response.first['id'] as int;
        
        await dao.insertProduct(ProductsCompanion(
          id: Value(remoteId),
          description: Value(description),
          unitMeasure: Value(unitMeasure),
          packagingType: const Value('Unidade'),
          attributesJson: const Value('{}'),
          sku: Value(sku),
          categoryId: Value(categoryId),
          ownerId: Value(userId),
          isFromRede: Value(isFromRede),
          isSynced: const Value(true),
        ));
      }

      try {
        await quotaService.recordAction(userId, QuotaType.products);
      } catch (_) {}
      
      await refresh();
      return true;
    } catch (e) {
      AppLogger.error('Erro fatal ao cadastrar produto no Supabase (Categoria ID: $categoryId): $e', tag: 'Products');
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return false;
    }
  }

  Future<void> deleteProduct(Product product) async {
    state = state.copyWith(isLoading: true);
    final dao = ref.read(productsDaoProvider);
    await dao.deleteProduct(product);
    await refresh();
  }
}
