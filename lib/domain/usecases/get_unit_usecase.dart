import 'package:dartz/dartz.dart';
import 'package:hihome/data/models/failure.dart';
import 'package:hihome/domain/models/unit.dart';

abstract class GetUnitUseCase {
  Future<Either<Failure, UnitEntity>> call(String familyId);
}
