import 'package:dartz/dartz.dart';
import 'package:hihome/data/helper/auth_error/login_failure_type.dart';
import 'package:hihome/data/models/userCredentials.dart';

abstract class ILoginUseCase {
  Future<Either<LoginFailureType, UserCredentials>> call(
      String email, String password);
}
