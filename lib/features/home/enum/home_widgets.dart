part of '../view/home_screen.dart';

enum HomeWidgets {
  hospitalAppointment,
  onlineAppointment,
  chronicTracking,
  appointments,
  slider,
  results,
  symptomChecker,
  detailedSymptom,
  healthcareEmployee,
}

extension HomeWidgetsExt on HomeWidgets {
  String get xRawValue => getEnumValue(this);
  bool isShowDefault() => this != HomeWidgets.detailedSymptom;
}

extension HomeWidgetsStringExt on String {
  HomeWidgets? get xHomeWidgets => HomeWidgets.values
      .firstWhereOrNull((element) => element.xRawValue == this);
}
