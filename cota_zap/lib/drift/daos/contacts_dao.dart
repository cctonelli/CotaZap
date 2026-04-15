import 'package:drift/drift.dart';
import '../database.dart';
import '../schema.dart';

part 'contacts_dao.g.dart';

@DriftAccessor(tables: [AppContacts])
class ContactsDao extends DatabaseAccessor<AppDatabase> with _$ContactsDaoMixin {
  ContactsDao(AppDatabase db) : super(db);

  // Assiste a todos os contatos
  Future<AppContact?> getSupplierById(int id) {
    return (select(appContacts)..where((t) => t.id.equals(id) & t.isSupplier.equals(true)))
        .getSingleOrNull();
  }

  Stream<List<AppContact>> watchAll() => select(appContacts).watch();
  
  // Assiste fornecedores do usuário logado, filtrados por categorias ou produtos se fornecidos
  Stream<List<AppContact>> watchSuppliers(String ownerId, {List<int>? categoryIds, List<int>? productIds}) {
    var query = select(appContacts).join([
      leftOuterJoin(db.supplierCategories, db.supplierCategories.supplierId.equalsExp(appContacts.id)),
      leftOuterJoin(db.productSuppliers, db.productSuppliers.supplierId.equalsExp(appContacts.id)),
    ]);

    query.where(appContacts.isSupplier.equals(true) & appContacts.ownerId.equals(ownerId));

    if ((categoryIds != null && categoryIds.isNotEmpty) || (productIds != null && productIds.isNotEmpty)) {
      Expression<bool> filter = const Constant(false);
      
      if (categoryIds != null && categoryIds.isNotEmpty) {
        filter = filter | db.supplierCategories.categoryId.isIn(categoryIds);
      }
      
      if (productIds != null && productIds.isNotEmpty) {
        filter = filter | db.productSuppliers.productId.isIn(productIds);
      }
      
      query.where(filter);
    }

    // Usamos distinct para não repetir fornecedores se eles baterem em mais de uma categoria/produto
    return query.map((row) => row.readTable(appContacts)).watch().map((list) => list.toSet().toList());
  }

  // Assiste fornecedores da Rede CotaZap (Globais/Verificados)
  Stream<List<AppContact>> watchRedeSuppliers() {
    return (select(appContacts)
          ..where((t) => t.isSupplier.equals(true) & t.ownerId.isNull())
          ..orderBy([(t) => OrderingTerm(expression: t.priorityScore, mode: OrderingMode.desc)]))
        .watch();
  }

  // Assiste fornecedores recomendados por categoria na Rede
  Stream<List<AppContact>> watchRecommendedSuppliers(List<int> categoryIds) {
    if (categoryIds.isEmpty) return watchRedeSuppliers();

    final query = select(appContacts).join([
      innerJoin(db.supplierCategories, db.supplierCategories.supplierId.equalsExp(appContacts.id)),
    ]);

    query.where(
      appContacts.isSupplier.equals(true) & 
      appContacts.ownerId.isNull() & 
      db.supplierCategories.categoryId.isIn(categoryIds)
    );

    query.orderBy([OrderingTerm(expression: appContacts.priorityScore, mode: OrderingMode.desc)]);

    return query.map((row) => row.readTable(appContacts)).watch().map((list) => list.toSet().toList());
  }

  // Busca o perfil do usuário logado (Usa o e-mail do Auth como âncora de segurança + owner_id)
  Future<AppContact?> getMyProfile(String userId, {String? email, bool? isBuyer, bool? isSupplier}) {
    var query = select(appContacts)..where((t) => t.ownerId.equals(userId));
    if (email != null) {
      query = query..where((t) => t.email.equals(email));
    }
    if (isBuyer != null) {
      query = query..where((t) => t.isBuyer.equals(isBuyer));
    }
    if (isSupplier != null) {
      query = query..where((t) => t.isSupplier.equals(isSupplier));
    }
    return (query..limit(1)).getSingleOrNull();
  }

  // Inserção ou Atualização (Upsert)
  Future<AppContact?> getFirstBuyer(String ownerId) {
    return (select(appContacts)
          ..where((t) => t.ownerId.equals(ownerId) & t.isBuyer.equals(true))
          ..limit(1))
        .getSingleOrNull();
  }

  Future<int> upsertContact(AppContactsCompanion contact) {
    return into(appContacts).insertOnConflictUpdate(contact);
  }

  // Busca Universal de Fornecedores/Contatos (CNPJ, Nome, WhatsApp, etc)
  Stream<List<AppContact>> watchUniversal(String query, {String? ownerId, bool onlyRede = false}) {
    final queryLower = query.toLowerCase().trim();
    var q = select(appContacts);
    
    q.where((t) {
      // Filtro de conteúdo (Pesquisa dinâmica)
      Expression<bool> contentFilter;
      if (queryLower.isEmpty) {
        contentFilter = const Constant(true);
      } else {
        contentFilter = t.tradeName.lower().contains(queryLower) |
                        coalesce([t.cnpjCpf, const Constant('')]).contains(queryLower) |
                        coalesce([t.contactName, const Constant('')]).lower().contains(queryLower) |
                        t.whatsapp.contains(queryLower) |
                        coalesce([t.email, const Constant('')]).lower().contains(queryLower);
      }
      
      Expression<bool> ownershipFilter;
      if (onlyRede) {
        // Apenas Rede Oficial (Verificados)
        ownershipFilter = (t.ownerId.isNull() | t.isRedeCotazap.equals(true)) & t.isSupplier.equals(true);
      } else {
        // Meus Contatos: Meus cadastros PRIVADOS + cadastros da REDE que estão locais
        // CRÍTICO: Garantir que se ownerId for nulo (não logado), não quebre a query
        final effectiveOwnerId = ownerId ?? 'unauthenticated';
        ownershipFilter = (t.ownerId.equals(effectiveOwnerId) | t.isRedeCotazap.equals(true)) & t.isSupplier.equals(true);
      }
      
      return contentFilter & ownershipFilter;
    });

    q.orderBy([
      (t) => OrderingTerm(expression: t.priorityScore, mode: OrderingMode.desc),
      (t) => OrderingTerm(expression: t.tradeName),
    ]);

    return q.watch();
  }

  Future<List<AppContact>> searchUniversal(String query, {String? ownerId, bool onlyRede = false}) {
    return watchUniversal(query, ownerId: ownerId, onlyRede: onlyRede).first;
  }

  // Deleta um contato
  Future<int> deleteContact(AppContact contact) => delete(appContacts).delete(contact);

  // Busca por ID
  Future<AppContact?> getContactById(int id) {
    return (select(appContacts)..where((t) => t.id.equals(id))).getSingleOrNull();
  }
}
