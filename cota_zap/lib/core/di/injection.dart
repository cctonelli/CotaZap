import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cota_zap/core/network/dio_client.dart';
import 'package:cota_zap/core/network/supabase_service.dart';
import 'package:cota_zap/drift/database.dart';
import 'package:cota_zap/drift/daos/products_dao.dart';
import 'package:cota_zap/drift/daos/quotations_dao.dart';
import 'package:cota_zap/drift/daos/supplier_responses_dao.dart';
import 'package:cota_zap/drift/daos/usage_quotas_dao.dart';
import 'package:cota_zap/drift/daos/contacts_dao.dart';
import 'package:cota_zap/features/quotation/domain/services/procurement_engine.dart';
import 'package:cota_zap/core/services/quota_service.dart';

import 'package:cota_zap/features/quotation/domain/repositories/quotation_repository.dart';
import 'package:cota_zap/features/quotation/data/repositories/quotation_repository_impl.dart';
import 'package:cota_zap/features/quotation/domain/usecases/send_quotation_usecase.dart';
import 'package:cota_zap/features/auth/domain/repositories/profile_repository.dart';

// Providers Globais
final supabaseClientProvider = Provider<SupabaseClient>((ref) => SupabaseService.client);

// Perfil de usuário
enum UserRole { buyer, supplier, admin }

final userRoleProvider = StateProvider<UserRole>((ref) => UserRole.buyer);
final userIdProvider = StateProvider<String?>((ref) => null); // UUID do Supabase
final planTypeProvider = StateProvider<String>((ref) => 'free'); // free, premium

// Database Provider
final databaseProvider = Provider<AppDatabase>((ref) => AppDatabase());

// DAO Providers
final contactsDaoProvider = Provider<ContactsDao>((ref) => ref.watch(databaseProvider).contactsDao);
final buyersDaoProvider = Provider<ContactsDao>((ref) => ref.watch(contactsDaoProvider));
final suppliersDaoProvider = Provider<ContactsDao>((ref) => ref.watch(contactsDaoProvider));
final productsDaoProvider = Provider<ProductsDao>((ref) => ref.watch(databaseProvider).productsDao);
final quotationsDaoProvider = Provider<QuotationsDao>((ref) => ref.watch(databaseProvider).quotationsDao);
final supplierResponsesDaoProvider = Provider<SupplierResponsesDao>((ref) => ref.watch(databaseProvider).supplierResponsesDao);
final usageQuotasDaoProvider = Provider<UsageQuotasDao>((ref) => ref.watch(databaseProvider).usageQuotasDao);
final categoryRequestsDaoProvider = Provider((ref) => ref.watch(databaseProvider).categoryRequestsDao);
final unitsOfMeasureDaoProvider = Provider((ref) => ref.watch(databaseProvider).unitsOfMeasureDao);
// Repository Providers
final quotationRepositoryProvider = Provider<QuotationRepository>((ref) {
  return QuotationRepositoryImpl(ref.watch(quotationsDaoProvider));
});

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepositoryImpl(ref.watch(databaseProvider), ref.watch(contactsDaoProvider));
});

// Domain Services
final procurementEngineProvider = Provider<ProcurementEngine>((ref) {
  return ProcurementEngine(
    quotationsDao: ref.watch(quotationsDaoProvider),
    supplierResponsesDao: ref.watch(supplierResponsesDaoProvider),
    contactsDao: ref.watch(contactsDaoProvider),
  );
});

// UseCase Providers
final sendQuotationUseCaseProvider = Provider<SendQuotationUseCase>((ref) {
  return SendQuotationUseCase(
    quotationRepository: ref.watch(quotationRepositoryProvider),
    contactsDao: ref.watch(contactsDaoProvider),
    quotaService: ref.watch(quotaServiceProvider),
    dio: ref.watch(dioProvider),
  );
});

// Quota Service Provider
final quotaServiceProvider = Provider<QuotaService>((ref) {
  return QuotaService(
    ref.watch(usageQuotasDaoProvider),
    ref.watch(supabaseClientProvider),
  );
});

// Infrastructure Providers
final dioProvider = Provider<Dio>((ref) => DioClient.instance);
