import 'package:hihome/data/models/device/device_point.dart';
import 'package:hihome/data/models/device/device_type.dart';

/// Represents a device.
class AddDeviceEntity {
  String? bruteValue;
  String? name;
  DevicePointModel? point;
  DeviceType? type;

  AddDeviceEntity({
    this.name,
    this.bruteValue,
    this.point,
    this.type,
  });
}
