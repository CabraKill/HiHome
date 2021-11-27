import 'package:dartz/dartz.dart';
import 'package:hihome/data/models/failure.dart';
import 'package:hihome/domain/models/device.dart';
import 'package:hihome/domain/models/device_list_result.dart';
import 'package:hihome/domain/models/section.dart';
import 'package:hihome/domain/repositories/database_repository.dart';
import 'package:hihome/domain/usecases/get_section_list_usecase.dart';

class GetSectionListUseCaseImpl implements GetSectionListUseCase {
  final DatabaseRepository databaseRepository;

  GetSectionListUseCaseImpl(this.databaseRepository);

  @override
  Future<Either<Failure, List<SectionEntity>>> call(String unitId) async {
    final sectionListResult = await databaseRepository.getSectionList(unitId);
    return sectionListResult;
  }
}
