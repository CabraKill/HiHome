import 'package:dartz/dartz.dart';
import 'package:hihome/data/models/failure.dart';
import 'package:hihome/domain/models/device.dart';

abstract class RemoveDeviceUseCase {
  //TODO: specify failure
  Future<Either<Failure, void>> call(DeviceEntity device);
}
