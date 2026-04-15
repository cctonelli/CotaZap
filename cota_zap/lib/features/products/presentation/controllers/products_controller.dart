import 'dart:async';
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
  StreamSubscription? _subscription;
  @override
  ProductsState build() {
    // Assiste ao userId e à categoria selecionada. Se qualquer um mudar, o build re-executa.
    final userId = ref.watch(userIdProvider);
    final categoryId = ref.watch(categoriesControllerProvider.select((s) => s.selectedCategoryId));
    
    ref.onDispose(() {
      _subscription?.cancel();
    });

    // Se o usuário estiver logado, dispara a observação do Stream.
    if (userId != null) {
      Future.microtask(() => _loadFiltered(categoryId));
    } else {
      // Se deslogou, limpa a lista.
      Future.microtask(() => state = ProductsState(isLoading: false));
    }
    
    return ProductsState(isLoading: userId != null);
  }

  void _loadFiltered(int? categoryId) {
    _subscription?.cancel();
    
    final userId = ref.read(userIdProvider);
    if (userId == null) return;

    AppLogger.info('Lendo produtos (Network: ${state.showNetwork}, Cat: $categoryId, Query: ${state.searchQuery})', tag: 'Products');

    final dao = ref.read(productsDaoProvider);
    _subscription = dao.watchUniversal(
      state.searchQuery,
      ownerId: userId,
      onlyNetwork: state.showNetwork,
      categoryId: categoryId,
    ).listen((items) {
      state = state.copyWith(products: items, isLoading: false);
      AppLogger.success('Stream de produtos atualizada: ${items.length} itens.', tag: 'Products');
    });
    
    _syncFromSupabase(categoryId);
  }

  Future<void> _syncFromSupabase(int? categoryId) async {
    final userId = ref.read(userIdProvider);
    if (userId == null) return;

    final db = ref.read(databaseProvider);
    try {
      final queryFilter = <String, dynamic>{
        'or': 'owner_id.eq.$userId,is_from_rede.eq.true'
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
        // Note: Com o uso de Streams (watchUniversal), não precisamos mais chamar _loadFiltered manualmente após o sync local.
        // O Drift detectará a inserção e notificará o stream.
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
    _loadFiltered(categoryId);
  }

  Future<void> searchNetwork(String query) async {
    updateSearchQuery(query);
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, errorMessage: null); // Limpa erro no refresh
    final categoryId = ref.read(categoriesControllerProvider).selectedCategoryId;
    _loadFiltered(categoryId);
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
      
      AppLogger.success('Produto salvo localmente.', tag: 'Products');
      state = state.copyWith(isLoading: false); // Garante que o loading pare após sucesso
      return true;
    } catch (e) {
      AppLogger.error('Erro ao cadastrar produto', error: e, tag: 'Products');
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return false;
    }
  }

  Future<void> deleteProduct(Product product) async {
    state = state.copyWith(isLoading: true);
    final dao = ref.read(productsDaoProvider);
    await dao.deleteProduct(product);
  }
}
