import 'package:get/get.dart';
import 'package:hihome/data/models/house.dart';
import 'package:hihome/data/provider/database/database.dart';

class _Rx {
  final houseList = <HouseModel>[].obs;
  final homeId = "".obs;
}

class HomeController extends GetxController {
  final _rx = _Rx();
  DataBase get _dataBase => Get.find();

  List<HouseModel> get houseList => _rx.houseList;
  set houseList(List<HouseModel> newList) => _rx.houseList.value = newList;

  bool get isHomeChoosed => _rx.homeId.isNotEmpty;

  HouseModel? get house => houseList
      .firstWhere((house) => house.id == _rx.homeId.value, orElse: null);

  @override
  void onReady() {
    super.onReady();
    updateHouseList();
  }

  ///Get the [house list] from repo and update the current list
  void updateHouseList() async {
    try {
      houseList = await _dataBase.getHomeList();
    } catch (e) {
      print(e);
    }
  }

  void goToDetails(HouseModel house) {
    _rx.homeId.value = house.id;
  }
}
