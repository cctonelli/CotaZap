import 'package:drift/drift.dart';
import '../database.dart';
import '../schema.dart';

part 'suppliers_dao.g.dart';

@DriftAccessor(tables: [Suppliers])
class SuppliersDao extends DatabaseAccessor<AppDatabase> with _$SuppliersDaoMixin {
  SuppliersDao(AppDatabase db) : super(db);

  Future<List<Supplier>> getAllSuppliers() => select(suppliers).get();
  
  Future<List<Supplier>> getActiveSuppliers() => 
    (select(suppliers)..where((t) => t.active.equals(true))).get();
  
  Future<int> insertSupplier(SuppliersCompanion supplier) => into(suppliers).insert(supplier);
  
  Future updateSupplier(Supplier supplier) => update(suppliers).replace(supplier);
  
  Future deleteSupplier(Supplier supplier) => delete(suppliers).delete(supplier);

  Future<List<Supplier>> getUnsynced() => (select(suppliers)..where((t) => t.isSynced.equals(false))).get();

  // Rede CotaZap: Fornecedores verificados na plataforma
  Stream<List<Supplier>> watchRedeSuppliers() => 
      (select(suppliers)..where((t) => t.isRedeCotazap.equals(true))
      ..orderBy([(t) => OrderingTerm(expression: t.priorityScore, mode: OrderingMode.desc)]))
      .watch();

  Future<List<Supplier>> getRedeSuppliers() => 
      (select(suppliers)..where((t) => t.isRedeCotazap.equals(true))
      ..orderBy([(t) => OrderingTerm(expression: t.priorityScore, mode: OrderingMode.desc)]))
      .get();

  Future<Supplier?> getSupplierById(int id) {
    return (select(suppliers)..where((t) => t.id.equals(id))).getSingleOrNull();
  }
}

