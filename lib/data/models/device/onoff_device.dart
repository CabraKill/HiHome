import 'package:hihome/domain/models/device.dart';

class OnOffDevice {
  OnOffDevice({
    required this.device,
  });

  final DeviceEntity device;

  bool get value => device.bruteValue == 'on';
}
