part of '../../abstract/app_config.dart';

class OneDoseSymptomCheckerEndpoints extends SymptomCheckerEndpoints {
  @override
  String get symptomGetProposed => '/symptoms/proposed'.xSymptomCheckerRequest;

  @override
  String get symptomGetSpecialisations =>
      '/diagnosis/specialisations'.xSymptomCheckerRequest;

  @override
  String get symptomGetBodyLocations =>
      '/body/locations'.xSymptomCheckerRequest;

  @override
  String symptomGetBodySubLocations(int locationID) =>
      '/body/locations/$locationID'.xSymptomCheckerRequest;

  @override
  String symptomGetBodySymptoms(int locationID, int gender) =>
      '/symptoms/$locationID/$gender'.xSymptomCheckerRequest;

  @override
  String get symptomCheckerLogin => '/login'.xSymptomCheckerLogin;
}
