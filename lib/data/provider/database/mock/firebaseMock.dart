import 'package:hihome/data/models/house.dart';
import '../database_interface.dart';

class FirebaseMock implements DatabasePlatform {
  static final houseList = <HouseModel>[
    HouseModel(id: "23412", name: "Netuno Galáxia Club"),
    HouseModel(id: "23412", name: "Marte Galáxia Club"),
  ];

  @override
  Future<DatabasePlatform> init() async {
    return this;
  }

  @override
  Future<List<HouseModel>> getHomeList() async {
    return houseList;
  }
}
