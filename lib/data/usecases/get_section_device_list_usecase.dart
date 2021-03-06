import 'package:dartz/dartz.dart';
import 'package:hihome/data/models/failure.dart';
import 'package:hihome/domain/models/device_list_result.dart';
import 'package:hihome/domain/repositories/database_repository.dart';
import 'package:hihome/domain/usecases/get_device_list_usecase.dart';

class GetDeviceListUseCaseImpl implements GetDeviceListUseCase {
  final DatabaseRepository databaseRepository;

  GetDeviceListUseCaseImpl(this.databaseRepository);

  @override
  Future<Either<Failure, DeviceListResult>> call(String path) {
    return databaseRepository.getDeviceList(path);
  }
}
