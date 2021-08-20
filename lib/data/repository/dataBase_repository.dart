import 'package:hihome/data/models/house.dart';
import 'package:hihome/data/provider/firebase/firebase_interface.dart';

class DataBaseRepository {
  final FireBase _database;

  DataBaseRepository(this._database);

  Future<List<HouseModel>> getHomeList() {
    return _database.getHomeList();
  }
}
