import 'package:drift/drift.dart';
import 'connection.dart';
import 'schema.dart';

import 'daos/contacts_dao.dart';
import 'daos/products_dao.dart';
import 'daos/quotations_dao.dart';
import 'daos/supplier_responses_dao.dart';
import 'daos/usage_quotas_dao.dart';
import 'daos/category_requests_dao.dart';
import 'daos/units_of_measure_dao.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    AppProfiles,
    AppContacts,
    Products,
    ProductCategories,
    ProductSuppliers,
    SupplierCategories,
    SupplierInteractions,
    Quotations,
    QuotationItems,
    SupplierResponses,
    UsageQuotas,
    CategoryRequests,
    UnitsOfMeasure,
  ],
  daos: [
    ContactsDao,
    ProductsDao,
    QuotationsDao,
    SupplierResponsesDao,
    UsageQuotasDao,
    CategoryRequestsDao,
    UnitsOfMeasureDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());

  @override
  int get schemaVersion => 11;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
      onUpgrade: (m, from, to) async {
        if (from < 3) {
          await m.createTable(productCategories);
          await m.createTable(supplierCategories);
          try {
            await m.addColumn(products, products.categoryId);
          } catch(e) {}
        }
        if (from < 4) {
          await m.createTable(appProfiles);
          await m.createTable(supplierInteractions);
          
          await m.addColumn(products, products.ownerId);
        }
        if (from < 6) {
          await m.createTable(usageQuotas);
          await m.createTable(categoryRequests);
        }
        if (from < 10) {
          await m.createTable(unitsOfMeasure);
        }
        if (from < 11) {
          try {
            await m.deleteTable('buyers');
            await m.deleteTable('suppliers');
          } catch(e) {}
          await m.createTable(appContacts);
        }
      },
    );
  }
}
