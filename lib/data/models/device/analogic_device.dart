import 'package:hihome/domain/models/device.dart';

class AnalogicDevice {
  AnalogicDevice({
    required this.device,
  });
  final DeviceEntity device;

  double get state => double.parse(device.bruteValue);
}
