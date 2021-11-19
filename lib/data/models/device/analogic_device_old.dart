//TODO: delete whenever its is for sure desnecessary
import 'package:hihome/data/models/device/device_point.dart';
import 'package:hihome/data/models/device/device_type.dart';
import 'package:hihome/domain/models/device.dart';

class AnalogicDeviceOld extends DeviceEntity {
  AnalogicDeviceOld({
    required String id,
    required String bruteState,
    required DeviceType type,
    required String path,
    required String name,
    DevicePointModel? point,
  }) : super(
          id: id,
          name: name,
          bruteValue: bruteState,
          point: point,
          type: type,
          path: path,
        );

  double get state => double.parse(bruteValue);
}
