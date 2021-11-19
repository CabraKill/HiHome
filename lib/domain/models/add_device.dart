import 'package:hihome/data/models/device/device_point.dart';
import 'package:hihome/data/models/device/device_type.dart';
import 'package:hihome/dialogs/device/models/changing_device.dart';

/// Represents a new device.
class AddDeviceEntity {
  String bruteValue;
  String name;
  DevicePointModel point;
  DeviceType type;
  final String path;

  AddDeviceEntity({
    required this.bruteValue,
    required this.name,
    required this.point,
    required this.type,
    required this.path,
  });

  AddDeviceEntity.fromChanginDevice(ChangingDevice changingDevice, this.path)
      : bruteValue = changingDevice.value,
        name = changingDevice.name,
        point = changingDevice.point,
        type = changingDevice.type;
}
