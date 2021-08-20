import 'package:get/get.dart';
import 'package:hihome/data/models/house.dart';
import 'package:hihome/data/repository/dataBase_repository.dart';
import 'package:hihome/routes/routes.dart';

class _Rx {
  final houseList = <HouseModel>[].obs;
}

class HomeController extends GetxController {
  final _rx = _Rx();
  DataBaseRepository get _dataBaseRepository => Get.find();

  List<HouseModel> get houseList => _rx.houseList;
  set houseList(List<HouseModel> newList) => _rx.houseList.value = newList;

  @override
  void onReady() {
    super.onReady();
    updateHouseList();
  }

  ///Get the [house list] from repo and update the current list
  void updateHouseList() async {
    try {
      houseList = await _dataBaseRepository.getHomeList();
    } catch (e) {}
  }

  void goToDetails(String id) {
    Get.toNamed(Routes.HOME_DETAILS);
  }
}
