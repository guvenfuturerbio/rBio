enum ScaleUnit { KG, LBS }
enum StripMode { ADD, SUBTRACT, NONE }

extension SUE on ScaleUnit {
  String get toStr {
    switch (this) {
      case ScaleUnit.KG:
        return 'kg';
        break;
      case ScaleUnit.LBS:
        return 'lbs';
      default:
        throw Exception('Unhandled scale type');
    }
  }
}
