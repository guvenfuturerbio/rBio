import '../../scale_dependencies.dart';

class ScaleHealthModel {
  bool? isManuel;

  String? deviceId;

  /// millisecondsSinceEpoch
  String occurrenceTime;

  ScaleUnit? scaleUnit;

  /// Ağırlık
  double? weight;

  /// Vücut Kitle İndeksi
  double? bmi;

  /// Vücut Yağ Oranı
  double? bodyFat;

  ScaleHealthModel({
    required this.occurrenceTime,
    this.weight,
    this.scaleUnit,
    this.deviceId,
    this.isManuel,
    this.bmi,
    this.bodyFat,
  });

  @override
  String toString() {
    return 'ScaleHealthModel(isManuel: $isManuel, deviceId: $deviceId, occurrenceTime: $occurrenceTime, scaleUnit: $scaleUnit, weight: $weight, bmi: $bmi, bodyFat: $bodyFat)';
  }
}
