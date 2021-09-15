import 'package:hihome/data/helper/connection_erro/auth_error.dart';

class InvalidPasswordException extends AuthException {
  InvalidPasswordException([String? text]) : super(text);
}
