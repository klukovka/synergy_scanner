extension CredentialsValidationExtension on String {
  //TODO: Extract
  bool get isValidEmail {
    final regex =
        RegExp(r"^[a-zA-Z0-9._-]+[\+\d+]*@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$");

    return regex.hasMatch(this);
  }

  bool get isPasswordValid {
    final passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_])[A-Za-z\d\W_]{8,}$',
    );

    return passwordRegex.hasMatch(this);
  }
}
