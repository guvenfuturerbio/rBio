enum TreatmentItemType {
  diet,
  treatment,
}

extension TreatmentItemTypeExtension on TreatmentItemType {
  int get xGetRawValue {
    switch (this) {
      case TreatmentItemType.diet:
        return 1;

      case TreatmentItemType.treatment:
        return 2;
    }
  }
}
