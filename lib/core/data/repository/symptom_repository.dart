import '../../core.dart';
import '../service/symptom_api_service.dart';
import '../../manager/shared_preferences_manager.dart';
import '../../../model/model.dart';

class SymptomRepository {
  final SymptomApiService service;

  SymptomRepository(this.service);

  String get getToken => getIt<ISharedPreferencesManager>()
      .getString(SharedPreferencesKeys.SYMPTOM_AUTH_TOKEN);

  Map<String, dynamic> get getAuthHeaders => {
        'Authorization':
            'Bearer Dc6r5_GUVENFUTURE_COM_AUT:YFETusG8gLaTVGaZQiR8eg=='
      };

  Future<SymptomAuthResponse> getSymtptomsApiToken() =>
      service.getSymtptomsApiToken();

  Future<List<GetBodySymptomsResponse>> getProposedSymptoms(
          String symptoms, String gender, String year_of_birth) =>
      service.getProposedSymptoms(symptoms, gender, year_of_birth, getToken,
          LocaleProvider.current.symptomChecker_language);

  Future<List<GetSpecialisationsResponse>> getSpeacialisations(String symptoms,
          String gender, String year_of_birth, String format) =>
      service.getSpeacialisations(symptoms, gender, year_of_birth, getToken,
          format, LocaleProvider.current.symptomChecker_language);

  Future<List<GetBodyLocationResponse>> getBodyLocations() async =>
      service.getBodyLocations(
          getToken, LocaleProvider.current.symptomChecker_language);

  Future<List<GetBodySublocationResponse>> getBodySubLocations(
          int locationID) =>
      service.getBodySubLocations(
          getToken, LocaleProvider.current.symptomChecker_language, locationID);

  Future<List<GetBodySymptomsResponse>> getBodySymptoms(
          int locationID, int gender) =>
      service.getBodySymptoms(getToken,
          LocaleProvider.current.symptomChecker_language, locationID, gender);
}
