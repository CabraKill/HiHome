extension DeviceBoolToString on bool {
  String get deviceBoolFromString => this ? 'on' : 'off';
}

extension DeviceStringToBool on String {
  bool get isDeviceOn => this == 'on' ? true : false;
}
