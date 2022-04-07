import 'package:collection/collection.dart';

import '../../../../core/core.dart';

enum DrugTracking {
  manuel,
  pillarSmall, // İlaç Kutusu
}

extension DrugTrackingExtensions on DrugTracking {
  String get xRawValue => getEnumValue(this);

  String toShortString() {
    switch (this) {
      case DrugTracking.manuel:
        return LocaleProvider.current.manuel;

      case DrugTracking.pillarSmall:
        return LocaleProvider.current.pillar_small;

      default:
        return "";
    }
  }
}

extension DrugTrackingStringExt on String {
  DrugTracking? get xGetDrugTracking => DrugTracking.values
      .firstWhereOrNull((element) => element.xRawValue == this);
}
