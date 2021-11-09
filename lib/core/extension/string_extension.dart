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
