import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cota_zap/drift/database.dart';
import 'package:cota_zap/core/di/injection.dart';
import 'package:drift/drift.dart';
import 'package:cota_zap/core/network/supabase_service.dart';
import 'package:cota_zap/core/utils/app_logger.dart';
import 'package:cota_zap/features/suppliers/presentation/controllers/categories_controller.dart';

class AdminState {
  final List<CategoryRequest> pendingCategoryRequests;
  final bool isLoading;

  AdminState({
    this.pendingCategoryRequests = const [],
    this.isLoading = false,
  });

  AdminState copyWith({
    List<CategoryRequest>? pendingCategoryRequests,
    bool? isLoading,
  }) {
    return AdminState(
      pendingCategoryRequests: pendingCategoryRequests ?? this.pendingCategoryRequests,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

final adminControllerProvider = NotifierProvider<AdminController, AdminState>(AdminController.new);

class AdminController extends Notifier<AdminState> {
  @override
  AdminState build() {
    _loadRequests();
    return AdminState(isLoading: true);
  }

  Future<void> _loadRequests() async {
    try {
      final dao = ref.read(categoryRequestsDaoProvider);
      final requests = await dao.getPendingRequests();
      state = state.copyWith(pendingCategoryRequests: requests);
    } catch (e) {
      AppLogger.error('Erro ao carregar solicitações administrativas', error: e, tag: 'Admin');
      // No ambiente Web, o Drift pode falhar. Mantemos a lista vazia mas liberamos o loading.
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> approveCategory(int requestId, String iconName) async {
    state = state.copyWith(isLoading: true);
    final dao = ref.read(categoryRequestsDaoProvider);
    final productsDao = ref.read(productsDaoProvider);

    final request = state.pendingCategoryRequests.firstWhere((r) => r.id == requestId);

    // 1. Criar a categoria oficial
    await productsDao.insertCategory(ProductCategoriesCompanion.insert(
      name: request.name,
      description: Value(request.description),
      iconName: Value(iconName),
    ));

    // 2. Atualizar status da solicitação
    await dao.updateStatus(requestId, 'approved');
    await _loadRequests();
  }

  Future<void> rejectCategory(int requestId) async {
    state = state.copyWith(isLoading: true);
    final dao = ref.read(categoryRequestsDaoProvider);
    await dao.updateStatus(requestId, 'rejected');
    await _loadRequests();
  }

  // --- Gerenciamento de Categorias Direto ---

  Future<void> deleteCategory(int id) async {
    state = state.copyWith(isLoading: true);
    try {
      await SupabaseService.client
          .from('product_categories')
          .delete()
          .eq('id', id);
      
      // Força o CategoriesController a recarregar
      await ref.read(categoriesControllerProvider.notifier).forceRefresh();
    } catch (e) {
      AppLogger.error('Erro ao excluir categoria', error: e, tag: 'Admin');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> upsertCategory({int? id, required String name, String? description, String? iconName}) async {
    state = state.copyWith(isLoading: true);
    try {
      final data = {
        'name': name,
        'description': description,
        'icon_name': iconName ?? 'inventory_2',
      };

      if (id != null) {
        await SupabaseService.client
            .from('product_categories')
            .update(data)
            .eq('id', id);
      } else {
        await SupabaseService.client
            .from('product_categories')
            .insert(data);
      }

      await ref.read(categoriesControllerProvider.notifier).forceRefresh();
    } catch (e) {
      AppLogger.error('Erro ao salvar categoria', error: e, tag: 'Admin');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
