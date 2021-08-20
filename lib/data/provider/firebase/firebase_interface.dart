import 'package:hihome/data/models/house.dart';

abstract class FireBase {
  Future<List<HouseModel>> getHomeList();
}
