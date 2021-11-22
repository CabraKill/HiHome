import 'package:get/get.dart';
import 'package:hihome/domain/models/device.dart';
import 'package:hihome/domain/models/device_log.dart';

class AnylisLogsController {
  final currentDeviceInAnalysisRx = Rx<DeviceEntity?>(null);
  final deviceAnlysisLogsRx = RxList<DeviceLogEntity>();
  final currentDevicePathRx = ''.obs;

  final double analysisHeightFactor = 0.2;

  DeviceEntity? get currentDeviceInAnalysis => currentDeviceInAnalysisRx.value;
  set currentDeviceInAnalysis(DeviceEntity? device) =>
      currentDeviceInAnalysisRx.value = device;

  void uptadeDeviceAnalysis(
    DeviceEntity deviceEntity,
    List<DeviceLogEntity> logs,
  ) {
    currentDeviceInAnalysis = deviceEntity;
    deviceAnlysisLogsRx.value = logs;
  }
}
