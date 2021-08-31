import 'package:hihome/data/helper/auth_error/auth_error.dart';

class InvalidPasswordException extends AuthException {
  InvalidPasswordException([String? text]) : super(text);
}
