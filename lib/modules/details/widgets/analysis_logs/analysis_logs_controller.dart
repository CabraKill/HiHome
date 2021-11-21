import 'package:get/get.dart';
import 'package:hihome/domain/models/device_log.dart';

class AnylisLogsController {
  final deviceAnlysisLogs = RxList<DeviceLogEntity>();
  final currentDevicePathRx = ''.obs;

  String get currentDevicePath => currentDevicePathRx.value;
  set currentDevicePath(String value) => currentDevicePathRx.value = value;

  void uptadeLogs(List<DeviceLogEntity> logs) {
    deviceAnlysisLogs.value = logs;
  }
}
