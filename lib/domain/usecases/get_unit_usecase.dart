import 'package:dartz/dartz.dart';
import 'package:hihome/data/models/failure.dart';
import 'package:hihome/data/models/unit.dart';

abstract class GetUnitUseCase {
  Future<Either<Failure, UnitModel>> call(String familyId);
}
