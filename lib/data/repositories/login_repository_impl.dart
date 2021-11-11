import 'package:get/get.dart';
import 'package:hihome/data/helper/auth_error/email_not_found_error.dart';
import 'package:hihome/data/helper/auth_error/invalid_password_error.dart';
import 'package:hihome/data/helper/auth_error/login_failure_type.dart';
import 'package:dartz/dartz.dart';
import 'package:hihome/data/models/user_credentials.dart';
import 'package:hihome/data/provider/database/database.dart';
import 'package:hihome/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LogingRepository {
  final DataBase dataBase;

  LoginRepositoryImpl() : dataBase = Get.find();

  @override
  Future<Either<LoginFailureType, UserCredentials>> login(
      String email, String password) async {
    try {
      final result = await dataBase.login(email, password);
      return Right(result);
    } on EmailNotFoundException catch (_) {
      return const Left(LoginFailureType.emailNotFound);
    } on InvalidPasswordException catch (_) {
      return const Left(LoginFailureType.invalidPassword);
    } catch (error) {
      return const Left(LoginFailureType.unknown);
    }
  }
}
