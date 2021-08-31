import 'package:get/get.dart';
import 'package:hihome/data/helper/auth_error/emailNotFound_error.dart';
import 'package:hihome/data/helper/auth_error/invalidPassword_error.dart';
import 'package:hihome/data/helper/auth_error/loginFailure_type.dart';
import 'package:dartz/dartz.dart';
import 'package:hihome/data/models/user.dart';
import 'package:hihome/data/provider/database/database.dart';
import 'package:hihome/domain/repositories/login_repository.dart';

class LoginRepository implements ILogingRepository {
  final DataBase dataBase;

  LoginRepository() : dataBase = Get.find();

  @override
  Future<Either<LoginFailureType, UserModel>> login(
      String email, String password) async {
    try {
      final result = await dataBase.login(email, password);
      return Right(result);
    } on EmailNotFoundException catch (_) {
      return Left(LoginFailureType.emailNotFound);
    } on InvalidPasswordException catch (_) {
      return Left(LoginFailureType.invalidPassword);
    } catch (error) {
      return Left(LoginFailureType.unknown);
    }
  }
}
