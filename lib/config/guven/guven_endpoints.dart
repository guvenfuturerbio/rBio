part of '../abstract/app_config.dart';

class GuvenEndpoints extends IAppEndpoints {
  @override
  AccessTokenEndpoints accessToken = GuvenAccessTokenEndpoints();

  @override
  AppointmentInterpreterEndpoints appointmentInterpreter =
      GuvenAppointmentInterpreterEndpoints();

  @override
  DoctorEndpoints doctor = GuvenDoctorEndpoints();

  @override
  FileEndpoints file = GuvenFileEndpoints();

  @override
  MeasurementEndpoints measurement = GuvenMeasurementEndpoints();

  @override
  PackageEndpoints package = GuvenPackageEndpoints();

  @override
  ProfileEndpoints profile = GuvenProfileEndpoints();

  @override
  PusulaEndpoints pusula = GuvenPusulaEndpoints();

  @override
  SingleEndpoints single = GuvenSingleEndpoints();

  @override
  SocialPostEndpoints socialPost = GuvenSocialPostEndpoints();

  @override
  SuggestionRateEndpoints suggestionRate = GuvenSuggestionRateEndpoints();

  @override
  SymptomCheckerEndpoints symptom = GuvenSymptomCheckerEndpoints();

  @override
  TreatmentEndpoints treatment = GuvenTreatmentEndpoints();

  @override
  UserEndpoints user = GuvenUserEndpoints();

  @override
  UserRegisterEndpoints userRegister = GuvenUserRegisterEndpoints();
}
