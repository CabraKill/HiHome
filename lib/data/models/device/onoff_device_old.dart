//TODO: delete whenever its is for sure desnecessary
import 'package:hihome/data/models/device/device_point.dart';
import 'package:hihome/data/models/device/device_type.dart';
import 'package:hihome/domain/models/device.dart';

class OnOffDeviceOld implements DeviceEntity {
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

  OnOffDeviceOld({
    required this.id,
    required this.type,
    required this.bruteValue,
    required this.path,
    required this.name,
    required this.point,
    this.document,
  });

  bool get value => bruteValue == 'on';

  @override
  DevicePointModel point;

  @override
  String bruteValue;

  @override
  String id;

  @override
  String name;

  @override
  DeviceType type;

  @override
  dynamic document;

  @override
  // TODO: implement path
  String path;
}
