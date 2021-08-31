import 'package:hihome/data/helper/auth_error/auth_error.dart';

class EmailNotFoundException extends AuthException {
  EmailNotFoundException([String? text]) : super(text);
}
