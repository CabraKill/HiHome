import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hihome/dialogs/device/dialog_result_type.dart';
import 'package:hihome/dialogs/device/models/changing_device.dart';
import 'package:hihome/dialogs/device/show_add_device_dialog.dart';
import 'package:hihome/data/models/device/device_point.dart';
import 'package:hihome/data/models/device/device_type.dart';
import 'package:hihome/data/usecases/get_section_device_list_usecase.dart';
import 'package:hihome/data/usecases/get_section_list_usecase.dart';
import 'package:hihome/data/usecases/update_device_value_usecase_impl.dart';
import 'package:hihome/dialogs/device/show_edit_device_dialog.dart';
import 'package:hihome/domain/models/device.dart';
import 'package:hihome/domain/models/section.dart';
import 'package:hihome/domain/repositories/database_repository.dart';
import 'package:hihome/domain/usecases/add_device_usecase.dart';
import 'package:hihome/domain/usecases/edit_device_usecase.dart';
import 'package:hihome/domain/usecases/get_device_list_usecase.dart';
import 'package:hihome/domain/usecases/get_section_list_usecase.dart';
import 'package:hihome/domain/usecases/remove_device_usecase.dart';
import 'package:hihome/domain/usecases/update_device_value_usecase.dart';
import 'package:hihome/infra/simple_cache/simple_cache.dart';
import 'package:hihome/infra/valueState/value_state.dart';
import 'package:hihome/infra/valueState/value_state_getx.dart';
import 'package:hihome/modules/details/models/zoom_type.dart';
import 'package:hihome/modules/details/widgets/app_bar/app_bar_controller.dart';
import 'package:hihome/utils/device_type_converter.dart';

class _Rx {
  final onSwitch = false.obs;
  final sectionList = <SectionEntity>[].obs;
  final position = const Offset(0, 0).obs;
  final deviceList = <DeviceEntity>[].obs;
  final subSectionList = ValueCommomStateListGetX<SectionEntity, dynamic>([]);
  final isTitleModeOn = true.obs;
  final deviceZoom = DeviceZoomType.normal.obs;
}

class DetailsController extends GetxController with DetailsAppBarController {
  final _rx = _Rx();
  final SectionEntity sectionEntity = Get.arguments;
  final DatabaseRepository databaseRepository;
  late GetDeviceListUseCase getDeviceListUseCaseImpl;
  late GetSectionListUseCase getSectionListUseCaseImpl;
  final AddDeviceUseCase addDeviceUseCaseImpl;
  final EditDeviceUseCase editDeviceUseCaseImpl;
  late RemoveDeviceUseCase removeDeviceUseCaseImpl;
  late UpdateDeviceValueUseCase updateDeviceValueUseCaseImpl;
  late Timer timerController;

  DetailsController(
    this.databaseRepository, {
    required this.addDeviceUseCaseImpl,
    required this.removeDeviceUseCaseImpl,
    required this.editDeviceUseCaseImpl,
  }) {
    getDeviceListUseCaseImpl = GetDeviceListUseCaseImpl(databaseRepository);
    getSectionListUseCaseImpl = GetSectionListUseCaseImpl(databaseRepository);
    updateDeviceValueUseCaseImpl = Get.find<UpdateDeviceValueUseCaseImpl>();
  }

  ValueCommomStateListGetX<SectionEntity, dynamic> get subSectionList =>
      _rx.subSectionList;

  bool get onSwitch => _rx.onSwitch.value;

  bool get isTitleModeOn => _rx.isTitleModeOn.value;
  set isTitleModeOn(bool value) => _rx.isTitleModeOn.value = value;

  set onSwitch(bool value) => _rx.onSwitch.value = value;

  Offset get position => _rx.position.value;
  set position(Offset offset) => _rx.position.value = offset;

  RxList<DeviceEntity> get devices => _rx.deviceList;

  DeviceZoomType get deviceZoom => _rx.deviceZoom.value;
  set deviceZoom(DeviceZoomType value) => _rx.deviceZoom.value = value;

  @override
  void onInit() {
    super.onInit();
    // updateSectionList();
    setDefaultZoom();
    updateDeviceList();
    initUpdateDeviceListTimer();
  }

  @override
  void onClose() {
    timerController.cancel();
    super.onClose();
  }

  void addDeviceToList(DeviceEntity device) {
    devices.add(device);
  }

  void switchState() async {
    final connect = Connect();
    final response = await connect.switchSate();
    if (response.statusCode != 200) {
      Get.defaultDialog(
        title: "Erro",
        content: Text(
          'Algo deu de errado.\n${response.body}',
        ),
      );
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
          subSectionList(CommomState.success, data: _subSetionList),
    );
    if (subSectionList.stateValue == CommomState.success) {
      for (var subSection in subSectionList.value) {
        dynamic error;
        (await getDeviceListUseCaseImpl(subSection.path + '/' + subSection.id))
            .fold(
          (_error) => error = _error,
          (deviceList) => subSection.deviceList = deviceList,
        );
        if (error != null) {
          subSectionList(CommomState.error, error: error);
          return;
        }
      }
    }
  }

  void updateDeviceList() async {
    final result = await getDeviceListUseCaseImpl(sectionEntity.path);
    result.fold(
      (error) => debugPrint("device list error: $error"),
      (_deviceList) => _rx.deviceList(_deviceList),
    );
  }

  void addDevice(DeviceType type, DevicePointModel point) async {
    final newDevice =
        await showAddNewDeviceDialog(type, point, sectionEntity.path);
    if (newDevice == null) return;

    final result = await addDeviceUseCaseImpl(newDevice);
    result.fold(
      (error) => debugPrint("add device error: $error"),
      (_device) => updateDeviceList(),
    );
  }

  void updateDeviceOnScreen(DeviceEntity oldDevice, [DeviceEntity? newDevice]) {
    _rx.deviceList.removeWhere((device) => device.id == oldDevice.id);
    _rx.deviceList.add(newDevice ?? oldDevice);
  }

  void deviceOnTap(DeviceEntity device) async {
    if (isEditModeOn) {
      deviceEditFlow(device);
      return;
    }
    if (!device.type.isOnOffDevice) return;
    device.bruteValue = (!device.bruteValue.isDeviceOn).deviceBoolFromString;
    updateDeviceOnScreen(device);
    final result = await updateDeviceValueUseCaseImpl(device);
    result.fold(
      (error) => debugPrint("update device error: $error"),
      (_) {},
    );
  }

  void initUpdateDeviceListTimer() {
    timerController =
        Timer.periodic(const Duration(milliseconds: 1200), (timer) {
      updateDeviceList();
    });
  }

  void switchTitleMode() {
    isTitleModeOn = !isTitleModeOn;
  }

  void deviceEditFlow(DeviceEntity device) async {
    final result = await showEditDeviceDialog(device);
    if (result.type == DeviceDialogOperationType.edit) {
      editDevice(device, result.device!);
    } else if (result.type == DeviceDialogOperationType.remove) {
      removeDevice(device);
    }
  }

  void editDevice(DeviceEntity device, ChangingDevice changingDevice) async {
    final deviceUpdated = DeviceEntity(
      id: device.id,
      name: changingDevice.name,
      bruteValue: changingDevice.value,
      point: changingDevice.point,
      type: changingDevice.type,
      path: device.path,
    );
    updateDeviceOnScreen(device, deviceUpdated);
    final result = await editDeviceUseCaseImpl(deviceUpdated);
    result.fold(
      (error) => debugPrint("edit device error: $error"),
      (_) {},
    );
  }

  void removeDevice(DeviceEntity device) async {
    _rx.deviceList.remove(device);
    final result = await removeDeviceUseCaseImpl(device);
    result.fold(
      (error) => debugPrint("remove device error: $error"),
      (_) {},
    );
  }

  void nextZoom() {
    deviceZoom = deviceZoom.next;
    SimpleCache.instance.updateValue('device_zoom', deviceZoom.index);
  }

  void updatePoint(DeviceEntity device, DevicePointModel point) async {
    device.point = point;
    updateDeviceOnScreen(device);
    final result = await editDeviceUseCaseImpl(device);
    result.fold(
      (error) => debugPrint("edit device error: $error"),
      (_) {},
    );
  }

  void setDefaultZoom() async {
    final zoomNumber = await SimpleCache.instance.readValue('device_zoom') ?? 0;
    deviceZoom = DeviceZoomType.values[zoomNumber];
  }
}

class Connect extends GetConnect {
  Future<Response> switchSate() => (get(
        'https://home-dbb7e.rj.r.appspot.com/homes/buHkimoPE1e5NMx7C4kX/devices/60:01:94:21:E7:FA/switch',
      ));
}
