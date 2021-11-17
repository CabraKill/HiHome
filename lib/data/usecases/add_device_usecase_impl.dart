import 'package:hihome/domain/models/add_device.dart';
import 'package:hihome/data/models/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:hihome/domain/repositories/database_repository.dart';
import 'package:hihome/domain/usecases/add_device_usecase.dart';

class AddDeviceUseCaseImpl implements AddDeviceUseCase {
  final DatabaseRepository databaseRepository;

  AddDeviceUseCaseImpl(this.databaseRepository);

  @override
  Future<Either<Failure, void>> call(AddDeviceEntity device) {
    //TODO: implement specific errors
    return databaseRepository.addDevice(device);
  }
}
