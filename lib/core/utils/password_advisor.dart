enum PasswordScore { Blank, VeryWeak, Weak, Medium, Strong, VeryStrong }

bool validateStructure(String value) {
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}

class PasswordAdvisor {
  int REQUIRED_PASSWORD_LENGTH = 8;
  RegExp numberInclude = RegExp("(?=.*?[0-9])");
  RegExp lowerCase = RegExp("(?=.*?[a-z])");
  RegExp upperCase = RegExp("(?=.*?[A-Z])");
  RegExp specialCharacter = RegExp(r"[$&+,:;=?@#|'<>.^*()%!-]");

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  PasswordScore CheckStrength(String password) {
    int score = 0;
    if (password.length < 1) return PasswordScore.Blank;
    if (password.length < 4) return PasswordScore.VeryWeak;
    if (password.length >= 8) score++;
    if (password.length >= 12) score++;
    if (numberInclude.firstMatch(password) != null) score++;
    if (lowerCase.firstMatch(password) != null &&
        upperCase.firstMatch(password) != null) score++;
    if (specialCharacter.firstMatch(password) != null) score++;

    switch (score) {
      case 0:
        return PasswordScore.Blank;
      case 1:
        return PasswordScore.VeryWeak;
      case 2:
        return PasswordScore.Weak;
      case 3:
        return PasswordScore.Medium;
      case 4:
        return PasswordScore.Strong;
      case 5:
        return PasswordScore.VeryStrong;
      default:
        return PasswordScore.Blank;
    }
  }

  bool checkNumberInclude(String password) {
    return numberInclude.hasMatch(password);
  }

  bool checkLowercase(String password) {
    return lowerCase.hasMatch(password);
  }

  bool checkUpperCase(String password) {
    return upperCase.hasMatch(password);
  }

  bool checkSpecialCharacter(String password) {
    return specialCharacter.hasMatch(password);
  }

  bool checkRequiredPasswordLength(String password) {
    return password.length < REQUIRED_PASSWORD_LENGTH ? false : true;
  }
}
