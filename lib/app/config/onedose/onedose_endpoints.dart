part of '../abstract/app_config.dart';

class OneDoseEndpoints extends IAppEndpoints {
  @override
  AccessTokenEndpoints accessToken = OneDoseAccessTokenEndpoints();

  @override
  AppointmentInterpreterEndpoints appointmentInterpreter =
      OneDoseAppointmentInterpreterEndpoints();

  @override
  DoctorEndpoints doctor = OneDoseDoctorEndpoints();

  @override
  FileEndpoints file = OneDoseFileEndpoints();

  @override
  MeasurementEndpoints measurement = OneDoseMeasurementEndpoints();

  @override
  PackageEndpoints package = OneDosePackageEndpoints();

  @override
  ProfileEndpoints profile = OneDoseProfileEndpoints();

  @override
  PusulaEndpoints pusula = OneDosePusulaEndpoints();

  @override
  SingleEndpoints single = OneDoseSingleEndpoints();

  @override
  SocialPostEndpoints socialPost = OneDoseSocialPostEndpoints();

  @override
  SuggestionRateEndpoints suggestionRate = OneDoseSuggestionRateEndpoints();

  @override
  SymptomCheckerEndpoints symptom = OneDoseSymptomCheckerEndpoints();

  @override
  TreatmentEndpoints treatment = OneDoseTreatmentEndpoints();

  @override
  UserEndpoints user = OneDoseUserEndpoints();

  @override
  UserRegisterEndpoints userRegister = OneDoseUserRegisterEndpoints();
}
