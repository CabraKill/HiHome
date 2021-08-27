import 'package:get/get.dart';
import 'package:hihome/data/models/house.dart';
import 'package:hihome/data/models/room.dart';
import 'package:hihome/data/provider/database/database.dart';
import 'package:hihome/infra/valueState/valueState.dart';
import 'package:hihome/infra/valueState/valueStateGetx.dart';

class _Rx {
  final houseList = ValueCommomStateListGetX(<HouseModel>[].obs);
  final roomList = ValueCommomStateListGetX(<RoomModel>[].obs);
  final homeId = "".obs;
}

class HomeController extends GetxController with StateMixin {
  final _rx = _Rx();
  DataBase get _dataBase => Get.find();

  ValueCommomStateListGetX<HouseModel, dynamic> get houseListState =>
      _rx.houseList;
  List<HouseModel> get houseList => _rx.houseList.data;
  set houseList(List<HouseModel> newList) => _rx.houseList.data.value = newList;

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
      houseListState(HomeState.loading);
      houseList = await _dataBase.getHomeList();
      houseListState(HomeState.success);
    } catch (e) {
      houseListState(HomeState.error);
    }
  }

  void goToDetails(HouseModel house) {
    _rx.homeId.value = house.id;
  }
}
