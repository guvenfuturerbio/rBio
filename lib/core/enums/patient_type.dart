import 'package:collection/collection.dart';

import '../core.dart';

enum PatientType {
  BloodGlucose,
  Weight,
  BloodPressure,
}

extension PatientTypeStringExt on String {
  PatientType get xPatientType => PatientType.values
      .firstWhereOrNull((element) => element.xRawValue == this);
}

extension PatientTypeExt on PatientType {
  String get xRawValue => GetEnumValue(this);
}
