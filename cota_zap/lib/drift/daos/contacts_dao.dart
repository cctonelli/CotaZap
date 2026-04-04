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
  
  // Assiste apenas fornecedores do usuário logado
  Stream<List<AppContact>> watchSuppliers(String ownerId) {
    return (select(appContacts)
          ..where((t) => t.isSupplier.equals(true) & t.ownerId.equals(ownerId)))
        .watch();
  }

  // Assiste fornecedores da Rede CotaZap (Globais/Verificados)
  // Nota: Aqui filtramos onde ownerId é nulo ou pertence ao sistema Admin
  Stream<List<AppContact>> watchRedeSuppliers() {
    return (select(appContacts)
          ..where((t) => t.isSupplier.equals(true) & t.ownerId.isNull())
          ..orderBy([(t) => OrderingTerm(expression: t.priorityScore, mode: OrderingMode.desc)]))
        .watch();
  }

  // Assiste fornecedores recomendados por categoria
  Stream<List<AppContact>> watchRecommendedSuppliers(List<int> categoryIds) {
    // Para simplificar agora, pegamos da rede e filtramos no stream ou SQL se possível.
    // Como a tabela app_contacts não tem categoriaIds direto (está em SupplierCategories),
    // por enquanto retornamos a rede completa ordenada por score.
    return watchRedeSuppliers();
  }

  // Busca o perfil do usuário logado (Usa o e-mail do Auth como âncora de segurança + owner_id)
  Future<AppContact?> getMyProfile(String userId, {String? email}) {
    var query = select(appContacts)..where((t) => t.ownerId.equals(userId));
    if (email != null) {
      query = query..where((t) => t.email.equals(email));
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

  // Deleta um contato
  Future<int> deleteContact(AppContact contact) => delete(appContacts).delete(contact);

  // Busca por ID
  Future<AppContact?> getContactById(int id) {
    return (select(appContacts)..where((t) => t.id.equals(id))).getSingleOrNull();
  }
}
