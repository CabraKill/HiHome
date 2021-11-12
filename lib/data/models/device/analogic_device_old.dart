import 'package:hihome/data/models/device/device_point.dart';
import 'package:hihome/data/models/device/device_type.dart';
import 'package:hihome/domain/models/device.dart';

class AnalogicDeviceOld extends DeviceEntity {
  AnalogicDeviceOld({
    required String id,
    required String bruteState,
    required DeviceType type,
    String? name,
    DevicePointModel? point,
  }) : super(
          id: id,
          name: name,
          bruteValue: bruteState,
          point: point,
          type: type,
        );

  double get state => double.parse(bruteValue);
}
