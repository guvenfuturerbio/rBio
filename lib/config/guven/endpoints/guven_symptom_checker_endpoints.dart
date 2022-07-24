part of '../../abstract/app_config.dart';

class GuvenSymptomCheckerEndpoints extends SymptomCheckerEndpoints {
  @override
  String get symptomGetBodyLocations =>
      throw RbioUndefinedEndpointException("symptomGetBodyLocations");

  @override
  String symptomGetBodySubLocations(int locationID) => 'env/onedose/.prod.env';

  @override
  String symptomGetBodySymptoms(int locationID, int gender) =>
      throw RbioUndefinedEndpointException("symptomGetBodySymptoms");

  @override
  String get symptomGetProposed =>
      throw RbioUndefinedEndpointException("symptomGetProposed");

  @override
  String get symptomGetSpecialisations =>
      throw RbioUndefinedEndpointException("symptomGetSpecialisations");

  @override
  String get symptomCheckerLogin =>
      throw RbioUndefinedEndpointException("symptomCheckerLogin");
}
