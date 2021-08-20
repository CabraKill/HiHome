import 'package:hihome/data/models/house.dart';
import 'package:hihome/data/provider/firebase/firebase_interface.dart';

class FirebaseMock implements FireBase {
  static final houseList = <HouseModel>[
    HouseModel(id: "23412", name: "Netuno Galáxia Club"),
    HouseModel(id: "23412", name: "Marte Galáxia Club"),
  ];
  @override
  Future<List<HouseModel>> getHomeList() async {
    return houseList;
  }
}
