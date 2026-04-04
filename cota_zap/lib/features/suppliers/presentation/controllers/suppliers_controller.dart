import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cota_zap/drift/database.dart';
import 'package:cota_zap/core/di/injection.dart';
import 'package:cota_zap/core/network/supabase_service.dart';
import 'package:cota_zap/core/utils/app_logger.dart';
import 'package:cota_zap/features/suppliers/presentation/controllers/categories_controller.dart';
import 'package:drift/drift.dart';

class SuppliersState {
  final List<AppContact> suppliers;
  final bool isLoading;
  final String? errorMessage;

  SuppliersState({
    this.suppliers = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  SuppliersState copyWith({
    List<AppContact>? suppliers,
    bool? isLoading,
    String? errorMessage,
  }) {
    return SuppliersState(
      suppliers: suppliers ?? this.suppliers,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

final suppliersControllerProvider = NotifierProvider<SuppliersController, SuppliersState>(SuppliersController.new);

class SuppliersController extends Notifier<SuppliersState> {
  @override
  SuppliersState build() {
    final categoriesState = ref.watch(categoriesControllerProvider);
    Future.microtask(() => _init(categoriesState.selectedCategoryId));
    return SuppliersState(isLoading: true);
  }

  Future<void> _init(int? categoryId) async {
    final userId = ref.read(userIdProvider);
    if (userId == null) return;

    try {
      final dao = ref.read(contactsDaoProvider);
      final cache = await dao.watchSuppliers(userId).first;
      if (cache.isNotEmpty) {
        state = state.copyWith(suppliers: cache, isLoading: false);
      }
    } catch (e) {
      AppLogger.error('Erro ao ler cache', error: e);
    }
    await _syncFromSupabase();
    await _loadFiltered(categoryId);
  }

  Future<void> _syncFromSupabase() async {
    final db = ref.read(databaseProvider);
    try {
      final remoteSupps = await SupabaseService.fetchTable(table: 'app_contacts');
      if (remoteSupps.isNotEmpty) {
        for (var supp in remoteSupps) {
          await db.into(db.appContacts).insertOnConflictUpdate(
            AppContactsCompanion(
              id: Value(supp['id']),
              tradeName: Value(supp['trade_name']),
              whatsapp: Value(supp['whatsapp'] ?? ''),
              address: Value(supp['address']),
              active: Value(supp['active'] ?? true),
              isRedeCotazap: Value(supp['is_rede_cotazap'] ?? false),
              priorityScore: Value(supp['priority_score'] ?? 0),
              cnpjCpf: Value(supp['cnpj_cpf']),
              contactName: Value(supp['contact_name']),
              email: Value(supp['email']),
              city: Value(supp['city']),
              state: Value(supp['state']),
              neighborhood: Value(supp['neighborhood']),
              zipCode: Value(supp['zip_code']),
              complement: Value(supp['complement']),
              isBuyer: Value(supp['is_buyer'] ?? false),
              isSupplier: Value(supp['is_supplier'] ?? true),
              isSynced: const Value(true),
            ),
          );
        }
      }
    } catch (e) {
      AppLogger.error('Erro sync', error: e);
    }
  }

  Future<void> _loadFiltered(int? categoryId) async {
    final dao = ref.read(contactsDaoProvider);
    final userId = ref.read(userIdProvider);
    final userRole = ref.read(userRoleProvider);
    
    List<AppContact> list;
    if (userRole == UserRole.admin) {
      list = await dao.watchAll().first;
    } else {
      if (userId == null) {
        list = [];
      } else {
        final all = await dao.watchSuppliers(userId).first;
        list = all.toList();
      }
    }
    state = state.copyWith(suppliers: list, isLoading: false);
  }

  Future<void> addSupplier({
    required String name,
    required String whatsapp,
    String? email,
    String? cnpjCpf,
    String? contactName,
    String? address,
    String? city,
    String? uf,
    String? neighborhood,
    String? zipCode,
    String? complement,
  }) async {
    state = state.copyWith(isLoading: true);
    final dao = ref.read(contactsDaoProvider);
    try {
      final companion = AppContactsCompanion(
        tradeName: Value(name),
        whatsapp: Value(whatsapp),
        active: const Value(true),
        email: Value(email),
        cnpjCpf: Value(cnpjCpf),
        contactName: Value(contactName),
        address: Value(address),
        city: Value(city),
        state: Value(uf),
        neighborhood: Value(neighborhood),
        zipCode: Value(zipCode),
        complement: Value(complement),
        isBuyer: const Value(false),
        isSupplier: const Value(true),
        ownerId: Value(ref.read(userIdProvider)),
      );
      final id = await dao.upsertContact(companion);
      
      await SupabaseService.updateProfile(
        table: 'app_contacts',
        data: {
          'trade_name': name,
          'whatsapp': whatsapp,
          'is_buyer': false,
          'is_supplier': true,
          'email': email,
          'cnpj_cpf': cnpjCpf,
          'contact_name': contactName,
          'address': address,
          'city': city,
          'state': uf,
          'neighborhood': neighborhood,
          'zip_code': zipCode,
          'complement': complement,
          'owner_id': ref.read(userIdProvider),
        },
      );

      final db = ref.read(databaseProvider);
      await (db.update(db.appContacts)..where((t) => t.id.equals(id))).write(
        const AppContactsCompanion(isSynced: Value(true))
      );
      
      await _loadFiltered(ref.read(categoriesControllerProvider).selectedCategoryId);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> forceRefresh() async {
    final catId = ref.read(categoriesControllerProvider).selectedCategoryId;
    await _init(catId);
  }

  Future<void> deleteSupplier(AppContact supplier) async {
    state = state.copyWith(isLoading: true);
    await ref.read(contactsDaoProvider).deleteContact(supplier);
    await _loadFiltered(ref.read(categoriesControllerProvider).selectedCategoryId);
  }
}
