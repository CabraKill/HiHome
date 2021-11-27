import 'package:dartz/dartz.dart';
import 'package:hihome/data/models/failure.dart';
import 'package:hihome/domain/models/device_list_result.dart';

abstract class GetDeviceListUseCase {
  Future<Either<Failure, DeviceListResult>> call(String path);
}
