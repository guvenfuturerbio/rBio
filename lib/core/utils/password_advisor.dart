enum PasswordScore {
  blank,
  veryWeak,
  weak,
  medium,
  strong,
  veryStrong,
}

class PasswordAdvisor {
  static const int requiredPasswordLength = 8;
  RegExp numberInclude = RegExp("(?=.*?[0-9])");
  RegExp lowerCase = RegExp("(?=.*?[a-z])");
  RegExp upperCase = RegExp("(?=.*?[A-Z])");
  RegExp specialCharacter = RegExp(r"[$&+,:;=?@#|'<>.^*()%!-]");

  bool upperCaseValue = false;
  bool lowerCaseValue = false;
  bool numericValue = false;
  bool specialValue = false;
  bool lengthValue = false;

  bool validateStructureByPattern(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  bool validateStructure() =>
      upperCaseValue &&
      lowerCaseValue &&
      numericValue &&
      specialValue &&
      lengthValue;

  void checkPassword(String password) {
    _checkUpperCase(password);
    _checkLowercase(password);
    _checkNumberInclude(password);
    _checkSpecialCharacter(password);
    _checkRequiredPasswordLength(password);
  }

  void _checkUpperCase(String password) {
    upperCaseValue = upperCase.hasMatch(password);
  }

  void _checkLowercase(String password) {
    lowerCaseValue = lowerCase.hasMatch(password);
  }

  void _checkNumberInclude(String password) {
    numericValue = numberInclude.hasMatch(password);
  }

  void _checkSpecialCharacter(String password) {
    specialValue = specialCharacter.hasMatch(password);
  }

  void _checkRequiredPasswordLength(String password) {
    lengthValue = password.length < requiredPasswordLength ? false : true;
  }

  PasswordScore checkStrength(String password) {
    int score = 0;
    if (password.isEmpty) return PasswordScore.blank;
    if (password.length < 4) return PasswordScore.veryWeak;
    if (password.length >= 8) score++;
    if (password.length >= 12) score++;
    if (numberInclude.firstMatch(password) != null) score++;
    if (lowerCase.firstMatch(password) != null &&
        upperCase.firstMatch(password) != null) score++;
    if (specialCharacter.firstMatch(password) != null) score++;

    switch (score) {
      case 0:
        return PasswordScore.blank;
      case 1:
        return PasswordScore.veryWeak;
      case 2:
        return PasswordScore.weak;
      case 3:
        return PasswordScore.medium;
      case 4:
        return PasswordScore.strong;
      case 5:
        return PasswordScore.veryStrong;
      default:
        return PasswordScore.blank;
    }
  }
}
