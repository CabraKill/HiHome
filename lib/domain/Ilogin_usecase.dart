import 'package:dartz/dartz.dart';
import 'package:hihome/data/helper/auth_error/loginFailure_type.dart';
import 'package:hihome/data/models/user.dart';

abstract class ILoginUseCase {
  Future<Either<LoginFailureType, UserModel>> call(
      String email, String password);
}
