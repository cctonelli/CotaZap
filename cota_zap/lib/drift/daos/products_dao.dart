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

  Future<List<Product>> searchUniversal(String query, {String? ownerId, bool onlyNetwork = false, int? categoryId}) async {
    final queryLower = query.toLowerCase();
    
    // Filtro de base para descrição do produto
    Expression<bool> filter = products.description.replaceNullWith('').lower().contains(queryLower);
    
    if (query.isNotEmpty) {
      filter = filter | productCategories.name.replaceNullWith('').lower().contains(queryLower);
    }

    // Filtro de Categoria (se fornecido)
    if (categoryId != null) {
      filter = filter & products.categoryId.equals(categoryId);
    }

    // Filtro de Propriedade/Rede
    Expression<bool> ownershipFilter = onlyNetwork 
        ? products.isFromRede.equals(true) 
        : products.ownerId.equals(ownerId ?? '???');

    final results = await (select(products).join([
      leftOuterJoin(productCategories, productCategories.id.equalsExp(products.categoryId)),
    ])..where(filter & ownershipFilter)).get();

    return results.map((row) => row.readTable(products)).toList();
  }
  
  Future<int> insertProduct(ProductsCompanion product) => into(products).insert(product);
  
  Future updateProduct(Product product) => update(products).replace(product);
  
  Future deleteProduct(Product product) => delete(products).delete(product);

  Future<List<Product>> getUnsynced() => (select(products)..where((t) => t.isSynced.equals(false))).get();

  Future<Product?> getProductById(int id) {
    return (select(products)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<List<Product>> getProductsByOwner(String ownerId) => 
    (select(products)..where((t) => t.ownerId.equals(ownerId))).get();

  // Vínculos Fornecedor-Produto
  Future<List<ProductSupplier>> getSuppliersForProduct(int productId) => 
    (select(productSuppliers)..where((t) => t.productId.equals(productId))).get();

  Future<int> linkProductToSupplier(int productId, int supplierId) => 
    into(productSuppliers).insert(ProductSuppliersCompanion.insert(
      productId: productId,
      supplierId: supplierId,
    ));

  Future<int> unlinkProductFromSupplier(int productId, int supplierId) => 
    (delete(productSuppliers)..where((t) => t.productId.equals(productId) & t.supplierId.equals(supplierId))).go();
}

