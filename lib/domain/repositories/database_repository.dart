import 'package:dartz/dartz.dart';
import 'package:hihome/data/models/failure.dart';
import 'package:hihome/data/models/family.dart';
import 'package:hihome/data/models/house.dart';

abstract class IDatabaseRepository {
  //TODO: specify failure
  Future<Either<Failure, FamilyModel>> getFamily(String familyId);
  //TODO: specify failure
  Future<Either<Failure, List<HouseModel>>> getHouseList();
}
