import 'package:dartz/dartz.dart';
import 'package:hihome/data/models/failure.dart';
import 'package:hihome/domain/models/add_device.dart';

abstract class AddDeviceUseCase {
  Future<Either<Failure, void>> call(AddDeviceEntity device);
}
