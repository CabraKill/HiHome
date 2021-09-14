class AuthException implements Exception {
  String? text;
  AuthException([this.text]);

  @override
  String toString() => text ?? "";
}
