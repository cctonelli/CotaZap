import 'package:drift/drift.dart';
import '../database.dart';
import '../schema.dart';

part 'products_dao.g.dart';

@DriftAccessor(tables: [Products, ProductSuppliers, ProductCategories])
class ProductsDao extends DatabaseAccessor<AppDatabase> with _$ProductsDaoMixin {
  ProductsDao(AppDatabase db) : super(db);

  Future<List<Product>> getAllProducts() => select(products).get();
  
  // Categorias
  Future<List<ProductCategory>> getAllCategories() => select(productCategories).get();
  Future<int> insertCategory(ProductCategoriesCompanion category) => into(productCategories).insert(category);
  Future updateCategory(ProductCategory category) => update(productCategories).replace(category);
  Future deleteCategory(ProductCategory category) => delete(productCategories).delete(category);

  Future<List<Product>> searchProducts(String query) => 
    (select(products)..where((t) => t.description.contains(query))).get();

  Future<List<Product>> searchNetworkProducts(String query) => 
    (select(products)
          ..where((t) => t.description.contains(query) & t.isFromRede.equals(true)))
        .get();

  Future<List<Product>> getProductsByCategory(int categoryId) => 
    (select(products)..where((t) => t.categoryId.equals(categoryId))).get();
  
  Future<int> insertProduct(ProductsCompanion product) => into(products).insert(product);
  
  Future updateProduct(Product product) => update(products).replace(product);
  
  Future deleteProduct(Product product) => delete(products).delete(product);

  Future<List<Product>> getUnsynced() => (select(products)..where((t) => t.isSynced.equals(false))).get();

  Future<Product?> getProductById(int id) {
    return (select(products)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<List<Product>> getProductsByOwner(String ownerId) => 
    (select(products)..where((t) => t.ownerId.equals(ownerId))).get();
}

