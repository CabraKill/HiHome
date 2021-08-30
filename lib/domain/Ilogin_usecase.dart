import 'package:dartz/dartz.dart';
import 'package:hihome/data/helper/loginError_type.dart';
import 'package:hihome/data/models/loginResult.dart';

abstract class ILoginUseCase {
  Future<Either<LoginFailureType, LoginResult>> call(
      String email, String password);
}
