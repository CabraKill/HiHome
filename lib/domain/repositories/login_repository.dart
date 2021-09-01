import 'package:dartz/dartz.dart';
import 'package:hihome/data/helper/auth_error/loginFailure_type.dart';
import 'package:hihome/data/models/userCredentials.dart';

abstract class ILogingRepository {
  Future<Either<LoginFailureType, UserCredentials>> login(
      String email, String password);
}
