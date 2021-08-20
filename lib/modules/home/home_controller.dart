import 'package:get/get.dart';
import 'package:hihome/data/models/house.dart';
import 'package:hihome/data/repository/dataBase_repository.dart';

class _Rx {
  final houseList = <HouseModel>[].obs;
}

class HomeController extends GetxController {
  final _rx = _Rx();
  DataBaseRepository get _dataBaseRepository => Get.find();

  List<HouseModel> get houseList => _rx.houseList;
  set houseList(List<HouseModel> newList) => _rx.houseList.value = newList;

  ///Get the [house list] from repo and update the current list
  void updateHouseList() async {
    try {
      final newHouseList = await _dataBaseRepository.getHomeList();
    } catch (e) {}
  }
}
