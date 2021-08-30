import 'package:hihome/data/helper/loginError_type.dart';

mixin LoginErrorHandler {
  LoginFailureType getFailureType(String error) {
    if (error == 'EMAIL_NOT_FOUND') return LoginFailureType.emailNotFound;
    if (error == 'INVALID_PASSWORD') return LoginFailureType.invalidPassword;
    return LoginFailureType.unknown;
  }
}
