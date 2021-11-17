import '../ui/medicine_selection/medicine_period_selection.dart';

MedicinePeriod fromShortString(String value) {
  print(value);
  switch (value) {
    case "Her Gün":
      return MedicinePeriod.EVERY_DAY;
    case "Every Day":
      return MedicinePeriod.EVERY_DAY;
    case "Belirli Günler":
      return MedicinePeriod.SPECIFIC_DAYS;
      break;
    case "Specific Days":
      return MedicinePeriod.SPECIFIC_DAYS;
    case "Aralıklı Günler":
      return MedicinePeriod.INTERMITTENT_DAYS;
    case "Intermittent Days":
      return MedicinePeriod.INTERMITTENT_DAYS;
    default:
      throw Exception('fromShortString');
  }
}

class Medicine {
  final List<dynamic> notificationIDs;
  final String medicineName;
  final int dosage;
  final String medicineType;
  final int interval;
  final String startTime;
  final MedicinePeriod medicinePeriod;

  Medicine(
      {this.notificationIDs,
      this.medicineName,
      this.dosage,
      this.medicineType,
      this.startTime,
      this.interval,
      this.medicinePeriod});

  String get getName => medicineName;
  int get getDosage => dosage;
  String get getType => medicineType;
  int get getInterval => interval;
  String get getStartTime => startTime;
  List<dynamic> get getIDs => notificationIDs;

  Map<String, dynamic> toJson() {
    return {
      "ids": this.notificationIDs,
      "name": this.medicineName,
      "dosage": this.dosage,
      "type": this.medicineType,
      "interval": this.interval,
      "start": this.startTime,
      "medicinePeriod": this.medicinePeriod.toShortString()
    };
  }

  factory Medicine.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['medicinePeriod']);
    return Medicine(
        notificationIDs: parsedJson['ids'],
        medicineName: parsedJson['name'],
        dosage: parsedJson['dosage'],
        medicineType: parsedJson['type'],
        interval: parsedJson['interval'],
        startTime: parsedJson['start'],
        medicinePeriod:
            fromShortString(parsedJson['medicinePeriod'].toString()));
  }
}
