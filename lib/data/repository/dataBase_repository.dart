import 'package:hihome/data/models/house.dart';
import 'package:hihome/data/provider/database/database_interface.dart';

class DataBaseRepository {
  final DatabasePlatform _database;

  DataBaseRepository(this._database);

  Future<List<HouseModel>> getHomeList() {
    return _database.getHomeList();
  }
}
