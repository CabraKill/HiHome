import 'package:dartz/dartz.dart';
import 'package:hihome/data/models/failure.dart';
import 'package:hihome/domain/models/device.dart';
import 'package:hihome/domain/models/section.dart';
import 'package:hihome/domain/repositories/database_repository.dart';
import 'package:hihome/domain/usecases/get_section_list_usecase.dart';

class GetSectionListUseCaseImpl implements GetSectionListUseCase {
  final DatabaseRepository databaseRepository;

  GetSectionListUseCaseImpl(this.databaseRepository);

  @override
  Future<Either<Failure, List<SectionEntity>>> call(String unitId) async {
    final sectionListResult = await databaseRepository.getSectionList(unitId);
    late List<SectionEntity> sectionList;
    if (sectionListResult is Left<Failure, List<SectionEntity>>) {
      return Left(sectionListResult.value);
    }

    sectionList = (sectionListResult as Right<Failure, List<SectionEntity>>).value;

    dynamic error;
    sectionList.forEach((section) async {
      final deviceListResult =
          await databaseRepository.getDeviceList(section.path);
      if (deviceListResult is Left<Failure, List<DeviceEntity>>) {
        error = deviceListResult.value;
        return;
      }
      section.deviceList = (deviceListResult as Right).value;
    });
    if (error != null) return Left(error);
    return databaseRepository.getSectionList(unitId);
  }
}
