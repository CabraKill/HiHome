import 'package:hihome/data/helper/auth_error/login_failure_type.dart';
import 'package:dartz/dartz.dart';
import 'package:hihome/data/models/user_credentials.dart';
import 'package:hihome/data/repositories/login_repository.dart';
import 'package:hihome/domain/usecases/Ilogin_usecase.dart';

class LoginUseCase implements ILoginUseCase {
  final LoginRepository loginRepository;

  LoginUseCase(this.loginRepository);

  @override
  Future<Either<LoginFailureType, UserCredentials>> call(
      String email, String password) async {
    return loginRepository.login(email, password);
  }
}
