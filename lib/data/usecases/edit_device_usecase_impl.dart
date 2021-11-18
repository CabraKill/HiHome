import 'package:dartz/dartz.dart';
import 'package:hihome/data/models/failure.dart';
import 'package:hihome/domain/models/device.dart';
import 'package:hihome/domain/repositories/database_repository.dart';
import 'package:hihome/domain/usecases/edit_device_usecase.dart';

class EditDeviceUseCaseImpl extends EditDeviceUseCase {
  final DatabaseRepository database;

  EditDeviceUseCaseImpl(this.database);

  @override
  Future<Either<Failure, void>> call(DeviceEntity device) async {
    return database.updateDeviceDocument(device);
  }
}
