import 'package:dartz/dartz.dart';
import 'package:hihome/data/helper/loginError_type.dart';
import 'package:hihome/data/models/loginResult.dart';

abstract class ILogingRepository {
  Future<Either<LoginFailureType, LoginResult>> login(
      String email, String password);
}
