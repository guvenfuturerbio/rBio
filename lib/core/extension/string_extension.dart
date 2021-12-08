const List<String> _turkishChars = [
  'ı',
  'ğ',
  'İ',
  'Ğ',
  'ç',
  'Ç',
  'ş',
  'Ş',
  'ö',
  'Ö',
  'ü',
  'Ü'
];

const List<String> _englishChars = [
  'i',
  'g',
  'I',
  'G',
  'c',
  'C',
  's',
  'S',
  'o',
  'O',
  'u',
  'U'
];

extension TurkishStringExtension on String {
  String get xTurkishCharacterToEnglish {
    String result = '';
    for (int i = 0; i < _turkishChars.length; i++) {
      result = this.replaceAll(_turkishChars[i], _englishChars[i]);
    }

    return result;
  }
}

extension StringExtension on String {
  String format(List<String> params) => interpolate(this, params);

  bool get xIsTCNationality => this == "TC";
}

String interpolate(String string, List<String> params) {
  String result = string;
  for (int i = 1; i < params.length + 1; i++) {
    result = result.replaceAll('%${i}\$', params[i - 1]);
  }

  return result;
}
