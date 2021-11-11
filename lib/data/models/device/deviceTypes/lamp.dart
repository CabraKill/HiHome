import 'package:hihome/data/models/device/device_point.dart';
import 'package:hihome/data/models/device/lamp_device.dart';
import 'package:hihome/domain/models/device.dart';

class Lamp extends OnOffDevice implements DeviceEntity {
  Lamp(
    String id,
    String? name,
    String? bruteState,
    DevicePointModel? point,
  ) : super(
          id: id,
          name: name,
          point: point,
          bruteState: bruteState,
        );
}
