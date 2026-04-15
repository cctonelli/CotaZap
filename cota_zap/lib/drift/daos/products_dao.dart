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

  Stream<List<Product>> watchUniversal(String query, {String? ownerId, bool onlyNetwork = false, int? categoryId}) {
    final queryLower = query.toLowerCase().trim();
    
    // Filtro de base (Descrição ou Nome da Categoria)
    Expression<bool> contentFilter;
    if (queryLower.isEmpty) {
      contentFilter = const Constant(true);
    } else {
      contentFilter = products.description.lower().contains(queryLower) |
               coalesce([productCategories.name, const Constant('')]).lower().contains(queryLower);
    }

    // Filtro de Categoria (se fornecido explicitamente)
    Expression<bool> categoryFilter = const Constant(true);
    if (categoryId != null) {
      categoryFilter = products.categoryId.equals(categoryId);
    }

    // Filtro de Propriedade/Rede
    final effectiveOwnerId = ownerId ?? 'unauthenticated';
    Expression<bool> ownershipFilter = onlyNetwork 
        ? products.isFromRede.equals(true) 
        : (products.ownerId.equals(effectiveOwnerId) | products.isFromRede.equals(true));

    final queryObj = select(products).join([
      leftOuterJoin(productCategories, productCategories.id.equalsExp(products.categoryId)),
    ])..where(contentFilter & categoryFilter & ownershipFilter);

    return queryObj.watch().map((rows) => rows.map((row) => row.readTable(products)).toList());
  }

  Future<List<Product>> searchUniversal(String query, {String? ownerId, bool onlyNetwork = false, int? categoryId}) {
    return watchUniversal(query, ownerId: ownerId, onlyNetwork: onlyNetwork, categoryId: categoryId).first;
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

