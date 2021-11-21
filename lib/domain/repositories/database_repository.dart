import 'package:dartz/dartz.dart';
import 'package:hihome/data/models/failure.dart';
import 'package:hihome/domain/models/add_device.dart';
import 'package:hihome/domain/models/device.dart';
import 'package:hihome/domain/models/device_log.dart';
import 'package:hihome/domain/models/section.dart';
import 'package:hihome/domain/models/unit.dart';

abstract class DatabaseRepository {
  //TODO: specify failure
  Future<Either<Failure, UnitEntity>> getUnit(String familyId);
  Future<Either<Failure, List<SectionEntity>>> getSectionList(String familyId);
  Future<Either<Failure, List<DeviceEntity>>> getDeviceList(String path);
  Future<Either<Failure, void>> addDevice(AddDeviceEntity device);
  Future<Either<Failure, void>> updateDeviceDocument(DeviceEntity deviceEntity);
  Future<Either<Failure, void>> removeDevice(DeviceEntity device);
  Future<Either<Failure, List<DeviceLogEntity>>> getDeviceLogList(String path);
}
