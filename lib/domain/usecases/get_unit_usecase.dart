import 'package:dartz/dartz.dart';
import 'package:hihome/data/models/failure.dart';
import 'package:hihome/data/models/family.dart';

abstract class GetUnitUseCase {
  Future<Either<Failure, FamilyModel>> call(String familyId);
}
