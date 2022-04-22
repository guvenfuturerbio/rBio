enum DiabetesType {
  type1,
  type2,
  nonDiabetes,
}

extension DiabetesTypeExtension on DiabetesType {
  int get xRawValue {
    switch (this) {
      case DiabetesType.type1:
        return 1;
      case DiabetesType.type2:
        return 2;
      case DiabetesType.nonDiabetes:
        return 3;
    }
  }
}

extension DiabetesTypeStringExtension on String? {
  DiabetesType get xGetDiabetesType {
    if (this == 'Diyabet Tip' || this == 'Diabet type') {
      return DiabetesType.nonDiabetes;
    } else if (this == 'Tip 1' || this == 'Type 1') {
      return DiabetesType.type1;
    } else if (this == 'Tip 2' || this == 'Type 2') {
      return DiabetesType.type2;
    }

    throw Exception("Undefined");
  }
}
