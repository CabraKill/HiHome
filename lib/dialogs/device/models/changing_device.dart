import 'package:hihome/data/models/device/device_point.dart';
import 'package:hihome/data/models/device/device_type.dart';

class ChangingDevice {
  String name;
  String value;
  DeviceType type;
  DevicePointModel point;
  ChangingDevice({
    required this.name,
    required this.value,
    required this.type,
    required this.point,
  });
}
