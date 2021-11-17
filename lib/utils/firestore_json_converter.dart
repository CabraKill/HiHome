import 'package:hihome/data/models/device/device_point.dart';

Map<String, dynamic> firestoreJsonConverter(Map<String, dynamic> json) {
  final firestoreJson = <String, dynamic>{};
  json.forEach((key, value) => firestoreJson[key] = _getMapFromType(value));
  return {'fields': firestoreJson};
}

Map<String, dynamic> _getMapFromType(value) {
  if (value is String) {
    return _stringType(value);
  } else if (value is int) {
    return _intType(value);
  } else if (value is double) {
    return _doubleType(value);
  } else if (value is bool) {
    return _boolType(value);
  } else if (value is DevicePointModel) {
    return _pointType(value);
  } else if (value is Map<String, dynamic>) {
    return _mapType(value);
  }
  return {};
}

Map<String, dynamic> _stringType(String value) {
  return {'stringValue': value};
}

Map<String, dynamic> _intType(int value) {
  return {'integerValue': value};
}

Map<String, dynamic> _doubleType(double value) {
  return {'doubleValue': value};
}

Map<String, dynamic> _boolType(bool value) {
  return {'booleanValue': value};
}

Map<String, dynamic> _pointType(DevicePointModel value) {
  return {
    'mapValue': {
      'fields': {
        'x': _getMapFromType(value.x),
        'y': _getMapFromType(value.y),
      }
    }
  };
}

Map<String, dynamic> _mapType(Map<String, dynamic> value) {
  return {'mapValue': firestoreJsonConverter(_getMapFromType(value))};
}
