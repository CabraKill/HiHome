import 'package:hihome/data/models/device/deviceTypes/thermostat_celsius.dart';
import 'package:hihome/data/models/device/deviceTypes/valve_onoff.dart';
import 'package:hihome/domain/models/device.dart';

import 'deviceTypes/lamp.dart';

enum DeviceType {
  lamp,
  valveOnOff,
  temperature,
  motor,
  waterPump,
  robotArm,
  generic,
}

DeviceEntity convertDeviceToType(DeviceEntity device) {
  switch (device.type) {
    case DeviceType.lamp:
      return device as Lamp;
    case DeviceType.valveOnOff:
      return device as ValveOnOff;
    case DeviceType.temperature:
      return device as ThermostatCelsius;
    default:
      return device;
  }
}
