import 'package:drift/drift.dart';
import 'connection.dart';
import 'schema.dart';

import 'daos/buyers_dao.dart';
import 'daos/suppliers_dao.dart';
import 'daos/products_dao.dart';
import 'daos/quotations_dao.dart';
import 'daos/supplier_responses_dao.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    Buyers,
    Suppliers,
    Products,
    ProductSuppliers,
    Quotations,
    QuotationItems,
    SupplierResponses,
  ],
  daos: [
    BuyersDao,
    SuppliersDao,
    ProductsDao,
    QuotationsDao,
    SupplierResponsesDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());

  @override
  int get schemaVersion => 1;
}
