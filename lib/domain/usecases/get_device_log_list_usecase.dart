import 'package:dartz/dartz.dart';
import 'package:hihome/data/models/failure.dart';
import 'package:hihome/domain/models/device_log_list_result.dart';

abstract class GetDeviceLogListUseCase {
  Future<Either<Failure, DeviceLogListResult>> call(String path);
}
