extension TurkishStringExtension on String {
  String get xTurkishCharacterToEnglish {
    return replaceAll("ı", "i")
        .replaceAll("ğ", "g")
        .replaceAll("İ", "I")
        .replaceAll("Ğ", "G")
        .replaceAll("ç", "c")
        .replaceAll("Ç", "C")
        .replaceAll("ş", "s")
        .replaceAll("Ş", "s")
        .replaceAll("Ö", "O")
        .replaceAll("ö", "o")
        .replaceAll("ü", "u")
        .replaceAll("Ü", "U");
  }
}

extension StringExtension on String {
  String format(List<String> params) => interpolate(this, params);

  bool get xIsTCNationality => this == "TC";
}

String interpolate(String string, List<String> params) {
  String result = string;
  for (int i = 1; i < params.length + 1; i++) {
    result = result.replaceAll('%$i\$', params[i - 1]);
  }

  return result;
}
