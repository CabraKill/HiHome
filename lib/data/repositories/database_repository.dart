import 'package:get/get.dart';
import 'package:hihome/data/models/family.dart';
import 'package:hihome/data/models/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:hihome/data/models/house.dart';
import 'package:hihome/data/provider/database/database.dart';
import 'package:hihome/domain/repositories/database_repository.dart';

class DatabaseRepository implements IDatabaseRepository {
  final DataBase dataBase;

  DatabaseRepository() : dataBase = Get.find();

  @override
  Future<Either<Failure, FamilyModel>> getFamily(String familyId) async {
    try {
      final result = await dataBase.getFamily(familyId);
      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<HouseModel>>> getHouseList() async {
    try {
      final result = await dataBase.getHomeList();
      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
