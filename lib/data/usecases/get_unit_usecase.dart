import 'package:dartz/dartz.dart';
import 'package:hihome/data/models/failure.dart';
import 'package:hihome/domain/models/section.dart';
import 'package:hihome/domain/models/unit.dart';
import 'package:hihome/domain/repositories/database_repository.dart';
import 'package:hihome/domain/usecases/get_unit_usecase.dart';

class GetUnitUseCaseImpl implements GetUnitUseCase {
  final DatabaseRepository databaseRepository;

  GetUnitUseCaseImpl(this.databaseRepository);

  //TODO: create specific failure
  @override
  Future<Either<Failure, UnitEntity>> call(String familyId) async {
    late UnitEntity home;
    final homeResult = await databaseRepository.getUnit(familyId);
    if (homeResult is Right<Failure, UnitEntity>) home = homeResult.value;
    if (homeResult is Left<Failure, UnitEntity>) return Left(homeResult.value);

    final houseListResult = await databaseRepository.getSectionList(home.path);
    if (houseListResult is Right<Failure, List<SectionEntity>>) {
      home.sectionList = houseListResult.value;
    }
    if (houseListResult is Left<Failure, List<SectionEntity>>) {
      return Left(houseListResult.value);
    }
    return Right(home);
  }
}
