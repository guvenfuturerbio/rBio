import '../../core/core.dart';

part 'guven_config.dart';
part 'rbio_config.dart';

abstract class AppConfig {
  ITheme get theme;
  bool get chronicTracking;
  bool get symptomChecker;
  bool get takeOnlineAppointment;
  bool get takeHospitalAppointment;
  bool get mediminder;
}
