import 'package:hihome/domain/models/device.dart';
import 'package:hihome/utils/device_type_converter.dart';

class OnOffDevice {
  OnOffDevice({
    required this.device,
  });

  final DeviceEntity device;

  bool get value => device.bruteValue.isDeviceOn;
}
