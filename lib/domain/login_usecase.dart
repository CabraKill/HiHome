import 'package:hihome/data/helper/auth_error/loginFailure_type.dart';
import 'package:dartz/dartz.dart';
import 'package:hihome/data/models/user.dart';
import 'package:hihome/data/repositories/login_repository.dart';
import 'package:hihome/domain/Ilogin_usecase.dart';

class LoginUseCase implements ILoginUseCase {
  final LoginRepository loginRepository;

  LoginUseCase(this.loginRepository);

  @override
  Future<Either<LoginFailureType, UserModel>> call(
      String email, String password) async {
    return loginRepository.login(email, password);
  }
}
