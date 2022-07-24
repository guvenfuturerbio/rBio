part of '../../abstract/app_config.dart';

class OneDoseAppointmentInterpreterEndpoints
    extends AppointmentInterpreterEndpoints {
  @override
  String get getAllTranslatorPath => '/appointmentinterpreter/get-all'.xBaseUrl;

  @override
  String requestTranslatorPath(String appoId) =>
      '/appointmentinterpreter/add-update-appointment-interpreter-pusula/$appoId'
          .xBaseUrl;
}
