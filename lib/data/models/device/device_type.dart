import 'package:hihome/data/models/device/analogic_device.dart';
import 'package:hihome/data/models/device/onoff_device.dart';
import 'package:hihome/domain/models/device.dart';

enum DeviceType {
  lamp,
  valveOnOff,
  temperature,
  motor,
  waterPump,
  robotArm,
  generic,
}

dynamic convertDeviceToType(DeviceEntity device) {
  switch (device.type) {
    case DeviceType.lamp:
      return OnOffDevice(device: device);
    case DeviceType.valveOnOff:
      return OnOffDevice(device: device);
    case DeviceType.temperature:
      return AnalogicDevice(device: device);
    default:
      return device;
  }
}

extension DeviceTypeExtension on DeviceType {
  bool get isOnOffDevice =>
      this == DeviceType.lamp || this == DeviceType.valveOnOff;
}
