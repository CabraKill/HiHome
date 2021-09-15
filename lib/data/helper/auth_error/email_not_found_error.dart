import 'package:hihome/data/helper/connection_erro/auth_error.dart';

class EmailNotFoundException extends AuthException {
  EmailNotFoundException([String? text]) : super(text);
}
