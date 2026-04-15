import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cota_zap/drift/database.dart';
import 'package:cota_zap/core/di/injection.dart';
import 'package:cota_zap/core/network/supabase_service.dart';
import 'package:cota_zap/core/utils/app_logger.dart';
import 'package:drift/drift.dart';

class SuppliersState {
  final List<AppContact> suppliers;
  final bool isLoading;
  final bool showNetwork;
  final String searchQuery;
  final String? errorMessage;

  SuppliersState({
    this.suppliers = const [],
    this.isLoading = false,
    this.showNetwork = false,
    this.searchQuery = '',
    this.errorMessage,
  });

  SuppliersState copyWith({
    List<AppContact>? suppliers,
    bool? isLoading,
    bool? showNetwork,
    String? searchQuery,
    String? errorMessage,
  }) {
    return SuppliersState(
      suppliers: suppliers ?? this.suppliers,
      isLoading: isLoading ?? this.isLoading,
      showNetwork: showNetwork ?? this.showNetwork,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage,
    );
  }
}

final suppliersControllerProvider = NotifierProvider<SuppliersController, SuppliersState>(SuppliersController.new);

class SuppliersController extends Notifier<SuppliersState> {
  StreamSubscription? _subscription;

  @override
  SuppliersState build() {
    // Assiste ao userId. Se mudar (login/logout), o build re-executa.
    final userId = ref.watch(userIdProvider);
    
    // Assiste a mudanças de categoria global (se houver, mas fornecedores não usam mais)
    
    ref.onDispose(() {
      _subscription?.cancel();
    });

    // Se o usuário logou, inicializa a carga. 
    // Usamos microtask para não disparar efeitos colaterais durante a fase de construção.
    if (userId != null) {
      Future.microtask(() => _init());
    } else {
      // Se deslogou, limpa a lista.
      Future.microtask(() => state = SuppliersState(isLoading: false));
    }
    
    return SuppliersState(isLoading: userId != null);
  }

  Future<void> _init() async {
    final userId = ref.read(userIdProvider);
    if (userId == null) return;

    // 1. Carregar local primeiro
    _loadFiltered();
    
    // 2. Sync apenas o que é do usuário + Rede Oficial
    await _syncFromSupabase();
  }

  Future<void> _syncFromSupabase() async {
    final userId = ref.read(userIdProvider);
    if (userId == null) return;
    
    final db = ref.read(databaseProvider);
    try {
      // FILTRO CRÍTICO: Busca apenas meus dados OU dados da Rede CotaZap
      // Não traz dados privados de outros compradores
      final remoteSupps = await SupabaseService.fetchTable(
        table: 'app_contacts',
        filter: {
          'or': 'owner_id.eq.$userId,is_rede_cotazap.eq.true'
        }
      );
      
      if (remoteSupps.isNotEmpty) {
        for (var supp in remoteSupps) {
          // Garante que se eu estiver baixando da rede, o owner_id local seja nulo para não confundir
          final bool fromRede = supp['is_rede_cotazap'] ?? false;
          
          await db.into(db.appContacts).insertOnConflictUpdate(
            AppContactsCompanion(
              id: Value(supp['id']),
              tradeName: Value(supp['trade_name']),
              whatsapp: Value(supp['whatsapp'] ?? ''),
              address: Value(supp['address']),
              active: Value(supp['active'] ?? true),
              isRedeCotazap: Value(fromRede),
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
              ownerId: Value(fromRede ? null : supp['owner_id']), 
              isSynced: const Value(true),
            ),
          );
        }
        _loadFiltered();
      }
    } catch (e) {
      AppLogger.error('Erro sync', error: e);
    }
  }

  void _loadFiltered() {
    // Evita cancelamento se os parâmetros forem idênticos (opcional, mas bom)
    _subscription?.cancel();
    
    final userId = ref.read(userIdProvider);
    if (userId == null) return;

    AppLogger.info('Iniciando observação de fornecedores (Network: ${state.showNetwork}, Query: ${state.searchQuery})', tag: 'Suppliers');
    
    final dao = ref.read(contactsDaoProvider);
    _subscription = dao.watchUniversal(
      state.searchQuery, 
      ownerId: userId, 
      onlyRede: state.showNetwork
    ).listen((list) {
      state = state.copyWith(suppliers: list, isLoading: false);
      AppLogger.success('Stream de fornecedores atualizada: ${list.length} itens.', tag: 'Suppliers');
    });
  }

  Future<void> toggleNetworkMode() async {
    state = state.copyWith(showNetwork: !state.showNetwork, isLoading: true);
    _loadFiltered();
  }

  void updateSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
    _loadFiltered();
  }

  Future<bool> addSupplier({
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
    state = state.copyWith(isLoading: true, errorMessage: null);
    final userId = ref.read(userIdProvider);
    
    if (userId == null) {
      state = state.copyWith(isLoading: false, errorMessage: 'Usuário não autenticado.');
      return false;
    }

    try {
      AppLogger.info('Cadastrando novo fornecedor no Supabase...', tag: 'Suppliers');
      
      // 1. Inserir no Supabase PRIMEIRO para garantir o ID oficial
      final response = await SupabaseService.client.from('app_contacts').insert({
        'trade_name': name,
        'whatsapp': whatsapp,
        'email': email,
        'cnpj_cpf': cnpjCpf,
        'contact_name': contactName,
        'address': address,
        'city': city,
        'state': uf,
        'neighborhood': neighborhood,
        'zip_code': zipCode,
        'complement': complement,
        'is_buyer': false,
        'is_supplier': true,
        'is_rede_cotazap': false, // Cadastro privativo do comprador
        'owner_id': userId,
      }).select();

      if (response.isEmpty) throw Exception('Falha ao obter ID do fornecedor no servidor.');
      
      final remoteId = response.first['id'] as int;
      AppLogger.success('Fornecedor cadastrado no Supabase com ID: $remoteId', tag: 'Suppliers');

      // 2. Salvar no SQLite local
      final dao = ref.read(contactsDaoProvider);
      await dao.upsertContact(AppContactsCompanion(
        id: Value(remoteId),
        tradeName: Value(name),
        whatsapp: Value(whatsapp),
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
        isRedeCotazap: const Value(false),
        ownerId: Value(userId),
        isSynced: const Value(true),
      ));

      AppLogger.success('Fornecedor salvo localmente.', tag: 'Suppliers');
      state = state.copyWith(isLoading: false); // Garante que o loading pare após sucesso
      return true;
    } catch (e) {
      AppLogger.error('Erro ao cadastrar fornecedor', error: e, tag: 'Suppliers');
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return false;
    }
  }

  Future<void> forceRefresh() async {
    state = state.copyWith(isLoading: true, errorMessage: null); // Limpa erros no refresh manual
    await _init();
  }

  Future<void> deleteSupplier(AppContact supplier) async {
    state = state.copyWith(isLoading: true);
    await ref.read(contactsDaoProvider).deleteContact(supplier);
  }
}
