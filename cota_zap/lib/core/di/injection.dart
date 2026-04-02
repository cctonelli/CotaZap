import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:cota_zap/core/network/dio_client.dart';
import 'package:cota_zap/drift/database.dart';
import 'package:cota_zap/drift/daos/buyers_dao.dart';
import 'package:cota_zap/drift/daos/suppliers_dao.dart';
import 'package:cota_zap/drift/daos/products_dao.dart';
import 'package:cota_zap/drift/daos/quotations_dao.dart';
import 'package:cota_zap/drift/daos/supplier_responses_dao.dart';
import 'package:cota_zap/features/quotation/domain/services/procurement_engine.dart';

// Perfil de usuário
enum UserRole { buyer, supplier }

final userRoleProvider = StateProvider<UserRole>((ref) => UserRole.buyer);

// Database Provider
final databaseProvider = Provider<AppDatabase>((ref) => AppDatabase());

// DAO Providers
final buyersDaoProvider = Provider<BuyersDao>((ref) => ref.watch(databaseProvider).buyersDao);
final suppliersDaoProvider = Provider<SuppliersDao>((ref) => ref.watch(databaseProvider).suppliersDao);
final productsDaoProvider = Provider<ProductsDao>((ref) => ref.watch(databaseProvider).productsDao);
final quotationsDaoProvider = Provider<QuotationsDao>((ref) => ref.watch(databaseProvider).quotationsDao);
final supplierResponsesDaoProvider = Provider<SupplierResponsesDao>((ref) => ref.watch(databaseProvider).supplierResponsesDao);

// Domain Services
final procurementEngineProvider = Provider<ProcurementEngine>((ref) {
  return ProcurementEngine(
    quotationsDao: ref.watch(quotationsDaoProvider),
    supplierResponsesDao: ref.watch(supplierResponsesDaoProvider),
  );
});

// Infrastructure Providers
final dioProvider = Provider<Dio>((ref) => DioClient.instance);
