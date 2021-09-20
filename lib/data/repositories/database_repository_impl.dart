import 'package:hihome/data/models/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:hihome/data/provider/database/database_interface.dart';
import 'package:hihome/domain/models/section.dart';
import 'package:hihome/domain/models/unit.dart';
import 'package:hihome/domain/repositories/database_repository.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  final DatabasePlatform dataBase;

  DatabaseRepositoryImpl(this.dataBase);

  @override
  Future<Either<Failure, UnitEntity>> getUnit(String familyId) async {
    try {
      final result = await dataBase.getFamily(familyId);
      return Right(result.toEntity());
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SectionEntity>>> getSectionList(
      String familyId) async {
    try {
      final result = await dataBase.getHomeList(familyId);
      return Right(
          result.map<SectionEntity>((home) => home.toEntity()).toList());
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
