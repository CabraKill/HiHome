import 'package:dartz/dartz.dart';
import 'package:hihome/data/models/failure.dart';
import 'package:hihome/data/models/user.dart';

abstract class UserDetailsRepository {
  Future<Either<Failure, UserModel>> getUser(String uid);
}
