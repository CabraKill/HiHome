import 'package:hihome/data/models/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:hihome/domain/models/device.dart';
import 'package:hihome/domain/repositories/database_repository.dart';
import 'package:hihome/domain/usecases/update_onoff_value_usecase.dart';

class UpdateOnOffValueUseCaseImpl implements UpdateOnOffValueUseCase {
  final DatabaseRepository database;

  UpdateOnOffValueUseCaseImpl(this.database);

  @override
  Future<Either<Failure, void>> call(DeviceEntity device) {
    return database.updateDeviceDocument(device);
  }
}
