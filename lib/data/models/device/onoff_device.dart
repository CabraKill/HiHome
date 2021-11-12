import 'package:hihome/data/models/device/device_point.dart';
import 'package:hihome/data/models/device/device_type.dart';
import 'package:hihome/domain/models/device.dart';

class OnOffDevice implements DeviceEntity {
  // OnOffDevice({
  //   required String id,
  //   required DeviceType type,
  //   required String bruteValue,
  //   String? name,
  //   DevicePointModel? point,
  // }) : super(
  //         id: id,
  //         name: name,
  //         bruteValue: bruteValue,
  //         point: point,
  //         type: type,
  //       );

  OnOffDevice({
    required this.id,
    required this.type,
    required this.bruteValue,
    this.name,
    this.point,
  });

  bool get value => bruteValue == 'on';

  @override
  DevicePointModel? point;

  @override
  String bruteValue;

  @override
  String id;

  @override
  String? name;

  @override
  DeviceType type;
}
