import 'package:hihome/data/models/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:hihome/domain/models/device.dart';
import 'package:hihome/domain/repositories/database_repository.dart';
import 'package:hihome/domain/usecases/remove_device_usecase.dart';

class RemoveDeviceUseCaseImpl implements RemoveDeviceUseCase {
  final DatabaseRepository databaseRepository;

  RemoveDeviceUseCaseImpl(this.databaseRepository);

  @override
  Future<Either<Failure, void>> call(DeviceEntity device) {
    //TODO: implement specific errors
    return databaseRepository.removeDevice(device);
  }
}
