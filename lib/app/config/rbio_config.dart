part of 'app_config.dart';

class RbioConfig implements AppConfig {
  @override
  ITheme get theme => RbioTheme();

  @override
  bool get chronicTracking => true;

  @override
  bool get symptomChecker => true;

  @override
  bool get takeOnlineAppointment => true;

  @override
  bool get takeHospitalAppointment => true;

  @override
  bool get mediminder => true;
}
