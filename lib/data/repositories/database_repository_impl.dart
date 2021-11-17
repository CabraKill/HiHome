import 'package:hihome/data/models/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:hihome/data/provider/database/database_interface.dart';
import 'package:hihome/domain/models/add_device.dart';
import 'package:hihome/domain/models/device.dart';
import 'package:hihome/domain/models/section.dart';
import 'package:hihome/domain/models/unit.dart';
import 'package:hihome/domain/repositories/database_repository.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  final Database dataBase;

  DatabaseRepositoryImpl(this.dataBase);

  @override
  Future<Either<Failure, UnitEntity>> getUnit(String familyId) async {
    try {
      final result = await dataBase.getUnit(familyId);
      return Right(result.toEntity());
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SectionEntity>>> getSectionList(
    String path,
  ) async {
    try {
      final result = await dataBase.getSectionList(path);
      return Right(result.map<SectionEntity>((home) => home).toList());
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DeviceEntity>>> getDeviceList(String path) async {
    try {
      final result = await dataBase.getDeviceList(path);
      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addDevice(
    AddDeviceEntity device,
  ) async {
    try {
      final result = await dataBase.addDevice(device);
      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateDeviceDocument(
    DeviceEntity device,
  ) async {
    try {
      await dataBase.updateDeviceDocument(device);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
