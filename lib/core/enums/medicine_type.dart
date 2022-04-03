import 'package:collection/collection.dart';

import '../core.dart';

enum MedicineType {
  manuel,
  pillarSmall, // İlaç Kutusu
}

extension MedicineTypeExtensions on MedicineType {
  String get xRawValue => getEnumValue(this);

  String toShortString() {
    switch (this) {
      case MedicineType.manuel:
        return LocaleProvider.current.manuel;

      case MedicineType.pillarSmall:
        return LocaleProvider.current.pillar_small;

      default:
        return "";
    }
  }
}

extension MedicineTypeStringExt on String {
  MedicineType? get xMedicineType => MedicineType.values
      .firstWhereOrNull((element) => element.xRawValue == this);
}
