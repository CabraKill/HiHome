import 'package:dartz/dartz.dart';
import 'package:hihome/data/models/failure.dart';
import 'package:hihome/domain/models/device_log.dart';

abstract class GetDeviceLogListUseCase {
  Future<Either<Failure, List<DeviceLogEntity>>> call(String path);
}
