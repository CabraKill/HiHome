import 'package:hihome/data/models/device/device_point.dart';
import 'package:hihome/data/models/device/device_type.dart';

/// Represents a device.
class DeviceEntity {
  final String id;
  final String bruteValue;
  final String? name;
  DevicePointModel? point;
  final DeviceType type;

  DeviceEntity({
    required this.id,
    required this.name,
    required this.bruteValue,
    required this.point,
    required this.type,
  });
}
