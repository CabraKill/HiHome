import 'package:hihome/data/helper/auth_error/auth_error.dart';
import 'package:hihome/data/helper/auth_error/emailNotFound_error.dart';
import 'package:hihome/data/helper/auth_error/invalidPassword_error.dart';

mixin LoginExceptionHandler {
  AuthException getExceptionType(String error) {
    if (error == 'EMAIL_NOT_FOUND') return EmailNotFoundException();
    if (error == 'INVALID_PASSWORD') return InvalidPasswordException();
    return AuthException();
  }
}
