import 'package:drift/drift.dart';
import '../database.dart';
import '../schema.dart';

part 'buyers_dao.g.dart';

@DriftAccessor(tables: [Buyers])
class BuyersDao extends DatabaseAccessor<AppDatabase> with _$BuyersDaoMixin {
  BuyersDao(AppDatabase db) : super(db);

  Future<List<Buyer>> getAllBuyers() => select(buyers).get();
  
  Future<int> insertBuyer(BuyersCompanion buyer) => into(buyers).insert(buyer);
  
  Future updateBuyer(Buyer buyer) => update(buyers).replace(buyer);
  
  Future deleteBuyer(Buyer buyer) => delete(buyers).delete(buyer);

  Future<Buyer?> getFirstBuyer() => (select(buyers)..limit(1)).getSingleOrNull();
  
  Future<List<Buyer>> getUnsynced() => (select(buyers)..where((t) => t.isSynced.equals(false))).get();
}
