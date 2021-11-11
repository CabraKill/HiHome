import 'package:hihome/data/models/device/device_point.dart';

class DeviceEntity {
  final String id;
  final String? bruteState;
  final String? name;
  DevicePointModel? point;

  DeviceEntity({
    required this.id,
    required this.name,
    required this.bruteState,
    required this.point,
  });
}
