import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hihome/data/models/family.dart';
import 'package:hihome/data/models/house.dart';
import 'package:hihome/data/models/room.dart';
import 'package:hihome/data/models/user.dart';
import 'package:hihome/data/models/user_credentials.dart';
import 'package:hihome/domain/repositories/database_repository.dart';
import 'package:hihome/domain/repositories/user_details_repository.dart';
import 'package:hihome/infra/valueState/value_state.dart';
import 'package:hihome/infra/valueState/value_state_getx.dart';
import 'package:hihome/modules/helpers/error_dialog.dart';

class _Rx {
  final houseList = ValueCommomStateListGetX(<HouseModel>[].obs);
  final family = ValueCommomStateGetX(FamilyModel(familyId: "", name: ""));
  final roomList = ValueCommomStateListGetX(<RoomModel>[].obs);
  final home = ValueCommomStateGetX(HouseModel(id: "", name: ""));
  final userDetails = ValueCommomStateGetX(UserModel(name: ""));
  final userCredentials = (Get.arguments as UserCredentials).obs;
}

class HomeController extends GetxController with StateMixin, ErrorDialog {
  final _rx = _Rx();
  final IUserDetailsRepository userDetailsRepository;
  final IDatabaseRepository databaseRepository;

  HomeController(this.userDetailsRepository, this.databaseRepository);

  bool get isHomeChoosed => _rx.home.stateValue == CommomState.success;
  ValueCommomStateListGetX<HouseModel, dynamic> get houseList => _rx.houseList;
  ValueCommomStateGetX<HouseModel, dynamic> get home => _rx.home;
  ValueCommomStateGetX<UserModel, dynamic> get userDetails => _rx.userDetails;
  UserCredentials get userCredentials => _rx.userCredentials.value;
  ValueCommomStateGetX<FamilyModel, dynamic> get family => _rx.family;

  @override
  void onReady() {
    super.onReady();
    initFamily();
  }

  ///Get the [family] from repo and update the current list
  Future<CommomState> updateFamily() async {
    family(CommomState.loading);
    final result =
        await databaseRepository.getFamily(userDetails.value.familyId!);
    result.fold(
      (failure) {
        family(CommomState.error, error: failure);
      },
      (_family) {
        family(CommomState.success, data: _family);
      },
    );
    return family.stateValue;
  }

  ///Get the [houseList] from repo and update the current list
  Future<CommomState> updateHouseList() async {
    houseList(CommomState.loading);
    final result =
        await databaseRepository.getHouseList(userDetails.value.familyId!);
    result.fold(
      (failure) {
        houseList(CommomState.error, error: failure);
      },
      (_houseList) {
        houseList(CommomState.success, data: _houseList);
      },
    );
    return houseList.stateValue;
  }

  Future<CommomState> updateHome() async {
    home(CommomState.loading);
    final HouseModel? hhome = houseList.value
        .firstWhere((house) => house.id == home.value.id, orElse: null);
    if (hhome != null)
      home(CommomState.success, data: hhome);
    else
      home(CommomState.empty);
    return home.stateValue;
  }

  void goToDetails(HouseModel house) {
    _rx.home.value.id = house.id;
    updateHome();
  }

  Future<CommomState> updateUser() async {
    final result = await userDetailsRepository.getUser(userCredentials.id);
    result.fold((failure) {
      userDetails(CommomState.error, error: failure);
    }, (user) {
      userDetails(CommomState.success, data: user);
    });
    return userDetails.stateValue;
  }

  void initFamily() async {
    if (await updateUser() != CommomState.success) return;
    if (await updateFamily() != CommomState.success) return;
    if (await updateHouseList() != CommomState.success) return;
  }
}
