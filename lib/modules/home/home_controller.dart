import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hihome/data/models/house.dart';
import 'package:hihome/data/models/room.dart';
import 'package:hihome/data/models/user.dart';
import 'package:hihome/data/models/userCredentials.dart';
import 'package:hihome/data/provider/database/database.dart';
import 'package:hihome/domain/repositories/database_repository.dart';
import 'package:hihome/domain/repositories/userDetails_repository.dart';
import 'package:hihome/infra/valueState/valueState.dart';
import 'package:hihome/infra/valueState/valueStateGetx.dart';
import 'package:hihome/modules/helpers/error_dialog.dart';

class _Rx {
  final houseList = ValueCommomStateListGetX(<HouseModel>[].obs);
  final roomList = ValueCommomStateListGetX(<RoomModel>[].obs);
  final homeId = "".obs;
  final userDetails = UserModel(name: "").obs;
  final userCredentials = (Get.arguments as UserCredentials).obs;
}

class HomeController extends GetxController with StateMixin, ErrorDialog {
  final _rx = _Rx();
  final IUserDetailsRepository userDetailsRepository;
  final IDatabaseRepository databaseRepository;

  HomeController(this.userDetailsRepository, this.databaseRepository);

  ValueCommomStateListGetX<HouseModel, dynamic> get houseListState =>
      _rx.houseList;

  List<HouseModel> get houseList => _rx.houseList.data;
  set houseList(List<HouseModel> newList) => _rx.houseList.data.value = newList;

  bool get isHomeChoosed => _rx.homeId.isNotEmpty;

  HouseModel? get house => houseList
      .firstWhere((house) => house.id == _rx.homeId.value, orElse: null);

  UserCredentials get userCredentials => _rx.userCredentials.value;

  @override
  void onReady() {
    super.onReady();
    updateUser();
  }

  ///Get the [house list] from repo and update the current list
  void updateHouseList() async {
    houseListState(HomeState.loading);
    final result = await databaseRepository.getHouseList();
    result.fold(
      (failure) {
        houseListState(HomeState.error);
        // houseListState.error.value = failure.toString();
      },
      (houseList) {
        this.houseList = houseList;
        houseListState(HomeState.success);
      },
    );
  }

  void goToDetails(HouseModel house) {
    _rx.homeId.value = house.id;
  }

  void updateUser() async {
    final result = await userDetailsRepository.getUser(userCredentials.id);
    result.fold((failure) {
      showErrorDialog(Text("error: ${failure.text}"));
    }, (userDetails) {
      _rx.userDetails(userDetails);
      updateHouseList();
    });
  }
}
