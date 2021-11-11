import 'package:dartz/dartz.dart';
import 'package:hihome/data/models/failure.dart';
import 'package:hihome/domain/models/device.dart';

abstract class AddDeviceUseCase {
  Future<Either<Failure, bool>> call(String path, DeviceEntity device);
}
