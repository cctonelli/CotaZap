import 'package:drift/drift.dart';
import '../database.dart';
import '../schema.dart';

part 'category_requests_dao.g.dart';

@DriftAccessor(tables: [CategoryRequests])
class CategoryRequestsDao extends DatabaseAccessor<AppDatabase> with _$CategoryRequestsDaoMixin {
  CategoryRequestsDao(AppDatabase db) : super(db);

  Future<List<CategoryRequest>> getAllRequests() => select(categoryRequests).get();
  
  Future<List<CategoryRequest>> getPendingRequests() => 
    (select(categoryRequests)..where((t) => t.status.equals('pending'))).get();

  Future<int> insertRequest(CategoryRequestsCompanion request) => 
    into(categoryRequests).insert(request);

  Future updateStatus(int id, String status) => 
    (update(categoryRequests)..where((t) => t.id.equals(id)))
      .write(CategoryRequestsCompanion(status: Value(status)));
}
