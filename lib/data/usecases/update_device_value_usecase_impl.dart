import 'package:dartz/dartz.dart';
import 'package:hihome/data/models/device/device_type.dart';
import 'package:hihome/data/models/failure.dart';
import 'package:hihome/domain/models/device.dart';
import 'package:hihome/domain/usecases/update_device_value_usecase.dart';
import 'package:hihome/domain/usecases/update_onoff_value_usecase.dart';

class UpdateDeviceValueUseCaseImpl extends UpdateDeviceValueUseCase {
  final UpdateOnOffValueUseCase updateOnOffValueUseCase;

  UpdateDeviceValueUseCaseImpl(this.updateOnOffValueUseCase);

  @override
  Future<Either<Failure, void>> call(DeviceEntity device) async {
    if (device.type.isOnOffDevice) {
      final result = await updateOnOffValueUseCase(device);
      return result;
    }
    return Left(Failure('type (${device.type}) not implemented'));
    //TODO: implement the others types of devices
  }
}
