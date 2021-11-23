import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hihome/data/models/device/device.dart';
import 'package:hihome/data/models/log.dart';
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
import 'package:hihome/domain/models/device_list_result.dart';
import 'package:hihome/domain/models/device_log_list_result.dart';
import 'package:hihome/domain/models/section.dart';
import 'package:hihome/domain/repositories/database_repository.dart';
import 'package:hihome/domain/usecases/add_device_usecase.dart';
import 'package:hihome/domain/usecases/edit_device_usecase.dart';
import 'package:hihome/domain/usecases/get_device_list_usecase.dart';
import 'package:hihome/domain/usecases/get_device_log_list_usecase.dart';
import 'package:hihome/domain/usecases/get_section_list_usecase.dart';
import 'package:hihome/domain/usecases/remove_device_usecase.dart';
import 'package:hihome/domain/usecases/update_device_value_usecase.dart';
import 'package:hihome/infra/simple_cache/simple_cache.dart';
import 'package:hihome/infra/valueState/value_state.dart';
import 'package:hihome/infra/valueState/value_state_getx.dart';
import 'package:hihome/modules/details/models/device_route_argumentos.dart';
import 'package:hihome/modules/details/models/zoom_type.dart';
import 'package:hihome/modules/details/widgets/app_bar/app_bar_controller.dart';
import 'package:hihome/modules/details/widgets/app_bar/app_bar_mode_type.dart';
import 'package:hihome/modules/details/widgets/app_bar/section_mode_type.dart';
import 'package:hihome/modules/home/home_controller.dart';
import 'package:hihome/utils/check_platform_type.dart';
import 'package:hihome/utils/device_type_converter.dart';
import 'details_page.dart';
import 'widgets/analysis_logs/analysis_logs_controller.dart';

class _Rx {
  final onSwitch = false.obs;
  final sectionList = <SectionEntity>[].obs;
  final position = const Offset(0, 0).obs;
  final deviceList = <DeviceEntity>[].obs;
  final subSectionList = ValueCommomStateListGetX<SectionEntity, dynamic>([]);
  final isTitleModeOn = true.obs;
  final deviceZoom = DeviceZoomType.normal.obs;
}

class DetailsController extends GetxController
    with DetailsAppBarController, AnylisLogsController {
  final _rx = _Rx();
  final SectionEntity sectionEntity =
      (Get.arguments as DeviceRouteArguments).section;
  final DatabaseRepository databaseRepository;
  late GetDeviceListUseCase getDeviceListUseCaseImpl;
  late GetSectionListUseCase getSectionListUseCaseImpl;
  final AddDeviceUseCase addDeviceUseCaseImpl;
  final EditDeviceUseCase editDeviceUseCaseImpl;
  final GetDeviceLogListUseCase getDeviceLogListUseCase;
  late RemoveDeviceUseCase removeDeviceUseCaseImpl;
  late UpdateDeviceValueUseCase updateDeviceValueUseCaseImpl;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>?
      deviceStreamSubscription;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>?
      deviceLogStreamSubscription;
  Timer? timerController;

  DetailsController(
    this.databaseRepository, {
    required this.addDeviceUseCaseImpl,
    required this.removeDeviceUseCaseImpl,
    required this.editDeviceUseCaseImpl,
    required this.getDeviceLogListUseCase,
  }) {
    getDeviceListUseCaseImpl = GetDeviceListUseCaseImpl(databaseRepository);
    getSectionListUseCaseImpl = GetSectionListUseCaseImpl(databaseRepository);
    updateDeviceValueUseCaseImpl = Get.find<UpdateDeviceValueUseCaseImpl>();
  }

  ValueCommomStateListGetX<SectionEntity, dynamic> get subSectionList =>
      _rx.subSectionList;

  bool get onSwitch => _rx.onSwitch.value;

  bool get isTitleModeOn => _rx.isTitleModeOn.value;

  get offSetHeight => (Get.arguments as DeviceRouteArguments).size.height;
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
    ever(currentSectionModeRx, (value) {
      if (value == SectionMode.device) {
        if (isWindows) {
          updateDeviceList();
        }
      } else {
        updateSubSectionList();
      }
    });
    ever(currentDeviceModeRx, (mode) {
      if (mode == DetailsAppBarModeType.analysis) {
        if (currentDeviceInAnalysis != null) {
          updateDeviceLogListSync();
        }
      }
    });
    updateSubSectionList();
    setDefaultZoom();
    initDeviceListSync();
  }

  @override
  void onClose() {
    timerController?.cancel();
    deviceStreamSubscription?.cancel();
    deviceLogStreamSubscription?.cancel();
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

  void updateSubSectionList() async {
    final result = await getSectionListUseCaseImpl(sectionEntity.path);
    result.fold(
      (error) => subSectionList(CommomState.error, error: error.toString()),
      (_subSetionList) =>
          subSectionList(CommomState.success, data: _subSetionList),
    );
  }

  Future<DeviceListResult?> updateDeviceList() async {
    final result = await getDeviceListUseCaseImpl(sectionEntity.path);
    return result.fold<DeviceListResult?>((error) {
      debugPrint("device list error: $error");
    }, (_deviceList) {
      _rx.deviceList(_deviceList.deviceList);
      return _deviceList;
    });
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
    if (!isWindows) {
      return;
    }
    _rx.deviceList.removeWhere((device) => device.id == oldDevice.id);
    _rx.deviceList.add(newDevice ?? oldDevice);
  }

  void deviceOnTap(DeviceEntity device) async {
    if (isEditModeOn) {
      deviceEditFlow(device);
      return;
    }
    if (isAnalysisModeOn) {
      updateDeviceLogAnalysisUseCase(device).then(configDeviceLogStream);
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
    final userDelay = Get.find<HomeController>().unit.value.userDelay;
    timerController =
        Timer.periodic(Duration(milliseconds: userDelay), (timer) {
      if (currentSectionMode != SectionMode.device) return;
      updateDeviceList();
      if (currentDeviceInAnalysis != null &&
          currentDeviceMode == DetailsAppBarModeType.analysis) {
        updateDeviceLogAnalysisUseCase(currentDeviceInAnalysis!);
      }
    });
  }

  void initDeviceListSync() {
    if (isWindows) {
      initUpdateDeviceListTimer();
    } else {
      updateDeviceList().then((deviceList) {
        if (deviceList == null) {
          return;
        }
        if (deviceList.collectionReference != null) {
          //TODO: should be a QueryDocumentSnapshot<Map<String, dynamic>> e not a  QuerySnapshot<Map<String, dynamic>>
          deviceStreamSubscription =
              deviceList.collectionReference!.snapshots().listen(
            (snap) {
              final newDeviceList = snap.docs
                  .map(
                    (deviceDocument) =>
                        DeviceModel.fromDocument(deviceDocument).toEntity(),
                  )
                  .toList();
              _rx.deviceList(
                newDeviceList,
              );
            },
          );
        }
      });
    }
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
    if (isWindows) {
      _rx.deviceList.remove(device);
    }
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

  Future<DeviceLogListResult?> updateDeviceLogAnalysisUseCase(
      DeviceEntity deviceEntity) async {
    final result = await getDeviceLogListUseCase(deviceEntity.path);
    return result.fold<DeviceLogListResult?>(
      (failure) {
        debugPrint('error while trying to get logs. Error: $failure');
      },
      (logs) {
        uptadeDeviceAnalysis(deviceEntity, logs.deviceLogList);
        return logs;
      },
    );
  }

  void goToSection(SectionEntity section) {
    Get.to(
      () => const DetailsPage(),
      arguments: DeviceRouteArguments(section, Size(0, offSetHeight)),
      routeName: 'details-${section.name}',
    );
  }

  void updateDeviceLogListSync() {
    if (!isWindows && currentDeviceInAnalysis?.document != null) {
      deviceLogStreamSubscription?.cancel();
      updateDeviceLogAnalysisUseCase(currentDeviceInAnalysis!)
          .then(configDeviceLogStream);
    } else {
      updateDeviceLogAnalysisUseCase(currentDeviceInAnalysis!);
    }
  }

  void configDeviceLogStream(DeviceLogListResult? deviceLog) {
    if (deviceLog == null || deviceLog.collectionReference == null) {
      return;
    }
    deviceLogStreamSubscription =
        (deviceLog.collectionReference!).snapshots().listen((snap) {
      deviceAnlysisLogsRx(
        snap.docs
            .map((log) => DeviceLogModel.fromDocument(log).toEntity())
            .toList(),
      );
      print("oioioi");
    });
  }
}

class Connect extends GetConnect {
  Future<Response> switchSate() => (get(
        'https://home-dbb7e.rj.r.appspot.com/homes/buHkimoPE1e5NMx7C4kX/devices/60:01:94:21:E7:FA/switch',
      ));
}
