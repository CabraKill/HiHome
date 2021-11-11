import 'package:hihome/data/models/device/device_point.dart';
import 'package:hihome/domain/models/device.dart';

class OnOffDevice implements DeviceEntity {
  @override
  final String id;
  @override
  final String? bruteState;
  @override
  final String? name;
  @override
  DevicePointModel? point;

  bool get state => bruteState == '1';

  OnOffDevice({
    required this.id,
    required this.name,
    required this.bruteState,
    required this.point,
  });
}
