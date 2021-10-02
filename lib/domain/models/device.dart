import 'package:hihome/data/models/device/device_point.dart';

class DeviceEntity {
  final String id;
  final String state;
  final String name;
  final DevicePointModel point;

  DeviceEntity(
      {required this.id,
      required this.name,
      required this.state,
      required this.point});
}
