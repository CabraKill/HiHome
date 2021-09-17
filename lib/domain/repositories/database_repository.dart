import 'package:dartz/dartz.dart';
import 'package:hihome/data/models/failure.dart';
import 'package:hihome/data/models/unit.dart';
import 'package:hihome/data/models/house.dart';

abstract class DatabaseRepository {
  //TODO: specify failure
  Future<Either<Failure, UnitModel>> getFamily(String familyId);
  //TODO: specify failure
  Future<Either<Failure, List<HouseModel>>> getHouseList(String familyId);
}
