import 'package:dartz/dartz.dart';
import 'package:hihome/data/models/failure.dart';
import 'package:hihome/domain/models/device.dart';

abstract class GetDeviceListUseCase {
  Future<Either<Failure, List<DeviceEntity>>> call(String path);
}
