import 'package:dartz/dartz.dart';
import 'package:hihome/data/models/failure.dart';
import 'package:hihome/domain/models/device.dart';

abstract class GetSectionDeviceListUseCase {
  Future<Either<Failure, List<DeviceEntity>>> call(String path);
}
