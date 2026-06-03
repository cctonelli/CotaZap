import 'package:cota_zap/core/network/supabase_service.dart';
import 'package:cota_zap/core/utils/app_logger.dart';
import 'package:cota_zap/drift/daos/contacts_dao.dart';
import 'package:cota_zap/drift/database.dart';
import 'package:drift/drift.dart';

abstract class ProfileRepository {
  Future<AppProfile?> getProfile(String userId);
  Future<void> updateProfileRole(String userId, String role);
  Future<void> updatePlanType(String userId, String planType);
  Future<void> syncProfileToCloud(AppProfile profile);
  Future<AppContact?> getMyContact(String userId);
  Future<void> upsertMyContact(AppContactsCompanion contact);
}

class ProfileRepositoryImpl implements ProfileRepository {
  final AppDatabase _db;
  final ContactsDao _contactsDao;

  ProfileRepositoryImpl(this._db, this._contactsDao);

  @override
  Future<AppProfile?> getProfile(String userId) {
    return (_db.select(_db.appProfiles)..where((t) => t.id.equals(userId))).getSingleOrNull();
  }

  @override
  Future<void> updateProfileRole(String userId, String role) async {
    await (_db.update(_db.appProfiles)..where((t) => t.id.equals(userId)))
        .write(AppProfilesCompanion(role: Value(role)));
    
    try {
      await SupabaseService.client.from('profiles').update({'role': role}).eq('id', userId);
    } catch (e) {
      AppLogger.error('Erro ao atualizar papel no Supabase', error: e);
    }
  }

  @override
  Future<void> updatePlanType(String userId, String planType) async {
    await (_db.update(_db.appProfiles)..where((t) => t.id.equals(userId)))
        .write(AppProfilesCompanion(planType: Value(planType)));
    
    try {
      await SupabaseService.client.from('profiles').update({'plan_type': planType}).eq('id', userId);
    } catch (e) {
      AppLogger.error('Erro ao atualizar plano no Supabase', error: e);
    }
  }

  @override
  Future<void> syncProfileToCloud(AppProfile profile) async {
    try {
      await SupabaseService.client.from('profiles').upsert({
        'id': profile.id,
        'name': profile.name,
        'role': profile.role,
        'plan_type': profile.planType,
        'avatar_url': profile.avatarUrl,
        'organization_id': profile.organizationId,
      });
    } catch (e) {
      AppLogger.error('Erro ao sincronizar perfil com Supabase', error: e);
    }
  }

  @override
  Future<AppContact?> getMyContact(String userId) {
    return _contactsDao.getMyProfile(userId);
  }

  @override
  Future<void> upsertMyContact(AppContactsCompanion contact) async {
    await _contactsDao.upsertContact(contact);
    
    // Sync to Supabase
    try {
      final contactData = await _contactsDao.getMyProfile(contact.ownerId.value ?? '');
      if (contactData != null) {
        await SupabaseService.client.from('app_contacts').upsert({
          'owner_id': contactData.ownerId,
          'trade_name': contactData.tradeName,
          'whatsapp': contactData.whatsapp,
          'contact_name': contactData.contactName,
          'email': contactData.email,
          'is_buyer': contactData.isBuyer,
          'is_supplier': contactData.isSupplier,
          'cnpj_cpf': contactData.cnpjCpf,
          'city': contactData.city,
          'state': contactData.state,
          // Adicione outros campos se necessário
        });
      }
    } catch (e) {
       AppLogger.error('Erro ao sincronizar contato pessoal com Supabase', error: e);
    }
  }
}
