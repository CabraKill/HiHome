import 'package:dartz/dartz.dart';
import 'package:hihome/data/models/failure.dart';
import 'package:hihome/domain/models/device.dart';
import 'package:hihome/domain/repositories/database_repository.dart';
import 'package:hihome/domain/usecases/get_section_device_list_usecase.dart';

class GetSectionDeviceListUseCaseImpl implements GetSectionDeviceListUseCase {
  final DatabaseRepository databaseRepository;

  GetSectionDeviceListUseCaseImpl(this.databaseRepository);

  Future<Either<Failure, List<DeviceEntity>>> call(String sectionId) {}
}
