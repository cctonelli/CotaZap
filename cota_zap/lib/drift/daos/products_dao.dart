import 'package:drift/drift.dart';
import '../database.dart';
import '../schema.dart';

part 'products_dao.g.dart';

@DriftAccessor(tables: [Products, ProductSuppliers])
class ProductsDao extends DatabaseAccessor<AppDatabase> with _$ProductsDaoMixin {
  ProductsDao(AppDatabase db) : super(db);

  Future<List<Product>> getAllProducts() => select(products).get();
  
  Future<List<Product>> searchProducts(String query) => 
    (select(products)..where((t) => t.description.contains(query))).get();
  
  Future<int> insertProduct(ProductsCompanion product) => into(products).insert(product);
  
  Future updateProduct(Product product) => update(products).replace(product);
  
  Future deleteProduct(Product product) => delete(products).delete(product);

  Future<List<Product>> getUnsynced() => (select(products)..where((t) => t.isSynced.equals(false))).get();

  Future<Product?> getProductById(int id) {
    return (select(products)..where((t) => t.id.equals(id))).getSingleOrNull();
  }
}

