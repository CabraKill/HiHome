enum LoginFailureType { emailNotFound, invalidPassword, unknown }

extension LoginFailureDescription on LoginFailureType {
  String get description {
    switch (this) {
      case LoginFailureType.emailNotFound:
        return "Email not found.";
      case LoginFailureType.invalidPassword:
        return "Invalid password.";
      case LoginFailureType.unknown:
        return "Something went wrong.";
    }
  }
}
