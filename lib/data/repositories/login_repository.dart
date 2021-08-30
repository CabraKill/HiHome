import 'package:get/get.dart';
import 'package:hihome/data/helper/auth_error.dart';
import 'package:hihome/data/helper/loginCheck_error.dart';
import 'package:hihome/data/helper/loginError_type.dart';
import 'package:hihome/data/models/loginResult.dart';
import 'package:dartz/dartz.dart';
import 'package:hihome/data/provider/database/database.dart';
import 'package:hihome/domain/repositories/login_repository.dart';

class LoginRepository with LoginErrorHandler implements ILogingRepository {
  final DataBase dataBase;

  LoginRepository() : dataBase = Get.find();

  @override
  Future<Either<LoginFailureType, LoginResult>> login(
      String email, String password) async {
    try {
      final result = await dataBase.login(email, password);
      return Right(result);
    } on AuthException catch (error) {
      return Left(getFailureType(error.text));
    } catch (error) {
      return Left(LoginFailureType.unknown);
    }
  }
}
