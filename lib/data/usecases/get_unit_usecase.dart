import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:hihome/data/models/failure.dart';
import 'package:hihome/data/models/family.dart';
import 'package:hihome/domain/repositories/database_repository.dart';
import 'package:hihome/domain/usecases/get_unit_usecase.dart';

class GetUnitUseCase implements IGetUnitUseCase {
  final IDatabaseRepository databaseRepository;

  GetUnitUseCase(this.databaseRepository);

  //TODO: create specific failure
  @override
  Future<Either<Failure, FamilyModel>> getUnit(String familyId) async {
    final homeResult = await databaseRepository.getFamily(familyId);
    late FamilyModel home;
    homeResult.fold((failure) => failure, (homeData) => home = homeData);
    // final homeResult = await databaseRepository.getHouseList(familyId);
    if (homeResult is Right<Failure, FamilyModel>) home = homeResult.value;
    if (homeResult is Left<Failure, FamilyModel>) return Left(homeResult.value);
    // final homeResult = await databaseRepository.get(familyId);
    homeResult.fold((failure) => failure, (homeData) => home = homeData);
  }
}
