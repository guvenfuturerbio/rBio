extension ScaleUnitParse on int {
  String getScaleUnit() {
    switch (this) {
      case 1:
        return 'kg';

      case 0:
        return 'lbs';

      default:
        throw Exception('Unit has not defined');
    }
  }
}