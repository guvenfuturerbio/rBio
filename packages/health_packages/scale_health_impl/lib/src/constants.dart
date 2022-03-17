part of 'scale_health_impl.dart';

class Constants {
  Constants._();

  static Constants? _instance;

  static Constants get instance {
    _instance ??= Constants._();
    return _instance!;
  }

  final DateTime startDate = DateTime(1997, 11, 9);
  final DateTime endDate = DateTime.now();

  final bloodGlucoseTypes = [
    HealthDataType.BLOOD_GLUCOSE,
  ];

  final scaleTypes = [
    HealthDataType.BODY_MASS_INDEX,
    HealthDataType.BODY_FAT_PERCENTAGE,
    HealthDataType.WEIGHT,
  ];

  final bloodPressureTypes = [
    HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
    HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
    HealthDataType.HEART_RATE,
  ];

  List<HealthDataType> get healthDataTypes => [
        ...bloodGlucoseTypes,
        ...scaleTypes,
        ...bloodPressureTypes,
      ];
}
