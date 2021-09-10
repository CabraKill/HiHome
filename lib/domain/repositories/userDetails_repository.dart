import 'package:dartz/dartz.dart';
import 'package:hihome/data/models/failure.dart';
import 'package:hihome/data/models/user.dart';

abstract class IUserDetailsRepository {
  Future<Either<Failure, UserModel>> getUser(String uid);
}
