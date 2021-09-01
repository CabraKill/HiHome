import 'package:get/get.dart';
import 'package:hihome/data/models/user.dart';
import 'package:hihome/data/models/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:hihome/data/provider/database/database.dart';
import 'package:hihome/domain/repositories/userDetails_repository.dart';

class UserDetailsRepository implements IUserDetailsRepository {
  final DataBase database;

  UserDetailsRepository() : database = Get.find();

  @override
  Future<Either<Failure, UserModel>> getUser(String uid) async {
    try {
      final userDetails = await database.getUser(uid);
      return Right(userDetails);
    } catch (a) {
      //TODO: implement specific failures
      return Left(Failure());
    }
  }
}