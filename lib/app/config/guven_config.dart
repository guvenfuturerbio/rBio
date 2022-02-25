part of 'app_config.dart';

class GuvenConfig implements AppConfig {
  @override
  ITheme get theme => GuvenTheme();

  @override
  bool get chronicTracking => true;

  @override
  bool get symptomChecker => true;

  @override
  bool get takeOnlineAppointment => false;

  @override
  bool get takeHospitalAppointment => false;

  @override
  bool get mediminder => true;
}
