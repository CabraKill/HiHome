import 'package:hihome/data/models/device/device_type.dart';

class DeviceLogEntity {
  final String name;
  final DeviceType type;
  final String value;
  final DateTime date;

  DeviceLogEntity({
    required this.name,
    required this.type,
    required this.value,
    required this.date,
  });
}
