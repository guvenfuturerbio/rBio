import '../core/core.dart';

part 'concrete/burgundy_config.dart';
part 'concrete/default_config.dart';

abstract class AppConfig {
  ITheme get theme;
  bool get chronicTracking;
  bool get symptomChecker;
  bool get takeOnlineAppointment;
  bool get takeHospitalAppointment;
  bool get mediminder;
}
