import 'package:dartz/dartz.dart';
import 'package:hihome/data/models/failure.dart';
import 'package:hihome/data/models/family.dart';

abstract class IGetUnitUseCase {
  Future<Either<Failure, FamilyModel>> getUnit(String familyId);
}
