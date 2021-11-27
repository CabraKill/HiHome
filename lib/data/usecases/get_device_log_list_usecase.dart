import 'package:dartz/dartz.dart';
import 'package:hihome/data/models/failure.dart';
import 'package:hihome/domain/models/device_log_list_result.dart';
import 'package:hihome/domain/repositories/database_repository.dart';
import 'package:hihome/domain/usecases/get_device_log_list_usecase.dart';

class GetDeviceLogListUseCaseImpl implements GetDeviceLogListUseCase {
  final DatabaseRepository databaseRepository;

  GetDeviceLogListUseCaseImpl(this.databaseRepository);

  @override
  Future<Either<Failure, DeviceLogListResult>> call(String path) {
    return databaseRepository.getDeviceLogList(path);
  }
}
