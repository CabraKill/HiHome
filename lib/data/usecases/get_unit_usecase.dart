import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:hihome/data/models/failure.dart';
import 'package:hihome/data/models/family.dart';
import 'package:hihome/domain/repositories/database_repository.dart';
import 'package:hihome/domain/usecases/get_unit_usecase.dart';

class GetUnitUseCase implements IGetUnitUseCase {
  final IDatabaseRepository databaseRepository;

  GetUnitUseCase() : databaseRepository = Get.find();

  @override
  Future<Either<Failure, FamilyModel>> getUnit() {
    // TODO: implement getUnit
    throw UnimplementedError();
  }
}
