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
  final String? errorMessage;

  ProductsState({
    this.products = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  ProductsState copyWith({
    List<Product>? products,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ProductsState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

final productsControllerProvider = NotifierProvider<ProductsController, ProductsState>(ProductsController.new);

class ProductsController extends Notifier<ProductsState> {
  @override
  ProductsState build() {
    final categoriesState = ref.watch(categoriesControllerProvider);
    _loadFiltered(categoriesState.selectedCategoryId);
    return ProductsState(isLoading: true);
  }

  Future<void> _loadFiltered(int? categoryId) async {
    final dao = ref.read(productsDaoProvider);
    final userRole = ref.read(userRoleProvider);
    final userId = ref.read(userIdProvider);
    
    List<Product> list;
    
    // Na v1.5, o Fornecedor vê seus produtos da Rede. 
    // O Comprador vê seus produtos privados + sugestões da Rede.
    if (userRole == UserRole.supplier) {
      list = await dao.getProductsByOwner(userId ?? '');
    } else {
      // Comprador: Vê seus produtos (ownerId) + Produtos da Rede
      final myProducts = await dao.getProductsByOwner(userId ?? '');
      final networkProducts = await dao.searchNetworkProducts(''); // Carrega todos da rede para filtrar por categoria se necessário
      list = [...myProducts, ...networkProducts];
    }
    
    if (categoryId != null) {
      list = list.where((p) => p.categoryId == categoryId).toList();
    }
    
    state = state.copyWith(products: list, isLoading: false);
    
    // Inicia sync remoto em background se necessário
    if (categoryId != null) {
      _syncFromSupabase(categoryId);
    }
  }

  Future<void> _syncFromSupabase(int categoryId) async {
    final db = ref.read(databaseProvider);
    try {
      final remoteProducts = await SupabaseService.fetchTable(
        table: 'products',
        filter: {'category_id': categoryId},
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
      }
    } catch (e) {
      AppLogger.error('Erro ao sincronizar produtos do Supabase', error: e, tag: 'Products');
    }
  }

  Future<void> searchNetwork(String query) async {
    if (query.isEmpty) {
      await refresh();
      return;
    }
    state = state.copyWith(isLoading: true);
    final dao = ref.read(productsDaoProvider);
    final results = await dao.searchNetworkProducts(query);
    state = state.copyWith(products: results, isLoading: false);
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true);
    final categoryId = ref.read(categoriesControllerProvider).selectedCategoryId;
    await _loadFiltered(categoryId);
  }

  Future<void> insertProduct({
    required String description,
    required String unitMeasure,
    String? sku,
    int? categoryId,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    final dao = ref.read(productsDaoProvider);
    final userRole = ref.read(userRoleProvider);
    final plan = ref.read(planTypeProvider);
    final userId = ref.read(userIdProvider);

    // Verificação de Limites (v1.5) usando o QuotaService
    final quotaService = ref.read(quotaServiceProvider);
    
    final canAdd = await quotaService.canPerformAction(userId ?? '', plan, QuotaType.products);

    if (!canAdd) {
      state = state.copyWith(
        isLoading: false, 
        errorMessage: 'Limite de produtos atingido no seu plano ($plan). Faça upgrade para cadastrar mais.'
      );
      return;
    }

    try {
      final companion = ProductsCompanion.insert(
        description: description,
        unitMeasure: unitMeasure,
        packagingType: 'Unidade', 
        attributesJson: '{}',
        sku: Value(sku),
        categoryId: Value(categoryId),
        ownerId: Value(userId),
        isFromRede: Value(userRole == UserRole.supplier),
      );
      // 1. Tentar salvar remoto PRIMEIRO para obter o ID oficial (bigint) do Supabase
      try {
        final List<Map<String, dynamic>> response = await SupabaseService.client.from('products').insert({
          'description': description,
          'unit_measure': unitMeasure,
          'packaging_type': 'Unidade',
          'attributes_json': '{}',
          'sku': sku,
          'category_id': categoryId,
          'owner_id': userId,
          'is_from_rede': userRole == UserRole.supplier,
        }).select();

        if (response.isNotEmpty) {
          final remoteId = response.first['id'] as int;
          
          // 2. Salva localmente com o ID oficial do servidor
          await dao.insertProduct(ProductsCompanion(
            id: Value(remoteId), // Usa o ID retornado pelo Supabase
            description: Value(description),
            unitMeasure: Value(unitMeasure),
            packagingType: const Value('Unidade'),
            attributesJson: const Value('{}'),
            sku: Value(sku),
            categoryId: Value(categoryId),
            ownerId: Value(userId),
            isFromRede: Value(userRole == UserRole.supplier),
            isSynced: const Value(true),
          ));
        } else {
          throw Exception('Supabase não retornou o ID do produto.');
        }
      } catch (remoteError) {
        AppLogger.error('Erro ao salvar no Supabase, tentando local...', error: remoteError);
        // Fallback: Salva local apenas se o remoto falhar (offline mode)
        final localId = await dao.insertProduct(companion);
        AppLogger.info('Salvo localmente com ID temporário: $localId');
      }

      // Registrar a ação de produto cadastrado
      await quotaService.recordAction(userId ?? '', QuotaType.products);
      
      await refresh();
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> deleteProduct(Product product) async {
    state = state.copyWith(isLoading: true);
    final dao = ref.read(productsDaoProvider);
    await dao.deleteProduct(product);
    await refresh();
  }
}
