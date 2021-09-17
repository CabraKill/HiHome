import 'package:dartz/dartz.dart';
import 'package:hihome/data/models/failure.dart';
import 'package:hihome/data/models/family.dart';
import 'package:hihome/data/models/house.dart';
import 'package:hihome/domain/repositories/database_repository.dart';
import 'package:hihome/domain/usecases/get_unit_usecase.dart';

class GetUnitUseCaseImpl implements GetUnitUseCase {
  final DatabaseRepository databaseRepository;

  GetUnitUseCaseImpl(this.databaseRepository);

  //TODO: create specific failure
  @override
  Future<Either<Failure, FamilyModel>> call(String familyId) async {
    late FamilyModel home;
    final homeResult = await databaseRepository.getFamily(familyId);
    if (homeResult is Right<Failure, FamilyModel>) home = homeResult.value;
    if (homeResult is Left<Failure, FamilyModel>) return Left(homeResult.value);

    final houseListResult = await databaseRepository.getHouseList(familyId);
    if (houseListResult is Right<Failure, List<HouseModel>>) {
      home.houseList = houseListResult.value;
    }
    if (houseListResult is Left<Failure, List<HouseModel>>) {
      return Left(houseListResult.value);
    }
    return Right(home);
  }
}
