import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hihome/data/models/device/device.dart';
import 'package:hihome/data/usecases/get_section_device_list_usecase.dart';
import 'package:hihome/data/usecases/get_section_list_usecase.dart';
import 'package:hihome/domain/models/section.dart';
import 'package:hihome/domain/repositories/database_repository.dart';
import 'package:hihome/domain/usecases/get_device_list_usecase.dart';
import 'package:hihome/domain/usecases/get_section_list_usecase.dart';
import 'package:hihome/infra/valueState/value_state.dart';
import 'package:hihome/infra/valueState/value_state_getx.dart';

class _Rx {
  final onSwitch = false.obs;
  final sectionList = <SectionEntity>[].obs;
  final position = const Offset(0, 0).obs;
  final itens = <DeviceModel>[].obs;
  final subSectionList = ValueCommomStateListGetX<SectionEntity, dynamic>([]);
}

class DetailsController extends GetxController {
  final _rx = _Rx();
  final SectionEntity sectionEntity = Get.arguments;
  final DatabaseRepository databaseRepository;
  late GetDeviceListUseCase getDeviceListUseCaseImpl;
  late GetSectionListUseCase getSectionListUseCaseImpl;

  DetailsController(this.databaseRepository) {
    getDeviceListUseCaseImpl = GetDeviceListUseCaseImpl(databaseRepository);
    getSectionListUseCaseImpl = GetSectionListUseCaseImpl(databaseRepository);
  }

  ValueCommomStateListGetX<SectionEntity, dynamic> get subSectionList =>
      _rx.subSectionList;

  bool get onSwitch => _rx.onSwitch.value;
  set onSwitch(bool value) => _rx.onSwitch.value = value;

  Offset get position => _rx.position.value;
  set position(Offset offset) => _rx.position.value = offset;

  List<DeviceModel> get itens => _rx.itens;

  @override
  void onInit() {
    super.onInit();
    updateSectionList();
  }

  void addDeviceToList(DeviceModel device) {
    itens.add(device);
  }

  void switchState() async {
    final connect = Connect();
    final response = await connect.switchSate();
    if (response.statusCode != 200) {
      Get.defaultDialog(
          title: "Erro",
          content: Text("Algo deu de errado.\n${response.body}"));
      return;
    }
    final Map<String, dynamic> bodyMap = jsonDecode(response.body);
    onSwitch = "on" == bodyMap['state'];
  }

  void updateSectionList() async {
    // _rx.roomList.value = await dataBase.getRoomList(
    //     homeController.family.value.familyId, homeController.home.value.id);
    // debugPrint(_rx.deviceList.map((device) => device.id).join(" - "));
    final result = await getSectionListUseCaseImpl(sectionEntity.path);
    result.fold(
        (error) => subSectionList(CommomState.error),
        (_subSetionList) =>
            subSectionList(CommomState.success, data: _subSetionList));
    if (subSectionList.stateValue == CommomState.success) {
      subSectionList.value.forEach((subSection) async {
        dynamic error;
        (await getDeviceListUseCaseImpl(subSection.path + '/' + subSection.id))
            .fold((_error) => error = _error,
                (deviceList) => subSection.deviceList = deviceList);
        if (error != null) {
          subSectionList(CommomState.error, error: error);
          return;
        }
      });
    }
  }
}

class Connect extends GetConnect {
  Future<Response> switchSate() => (get(
      'https://home-dbb7e.rj.r.appspot.com/homes/buHkimoPE1e5NMx7C4kX/devices/60:01:94:21:E7:FA/switch'));
}
