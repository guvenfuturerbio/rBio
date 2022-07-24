import '../../../features/symptom_checker/symptoms_result_page/model/get_body_symptoms_response.dart';
import '../../core/core.dart';
import '../../features/symptom_checker/home/model/symptoms_auth_response.dart';
import '../../features/symptom_checker/symptoms_body_location/model/get_bodylocations_response.dart';
import '../../features/symptom_checker/symptoms_body_sublocations_page/model/get_bodysublocation_response.dart';
import '../../features/symptom_checker/symptoms_result_page/model/get_specialisations.response.dart';

class SymptomRepository {
  final SymptomApiService service;

  SymptomRepository(this.service);

  String get getToken {
    final token = getIt<ISharedPreferencesManager>()
        .getString(SharedPreferencesKeys.symtomAuthToken);

    if (token == null) {
      throw Exception("token null");
    }

    return token;
  }

  Map<String, dynamic> get getAuthHeaders => {
        'Authorization':
            'Bearer Dc6r5_GUVENFUTURE_COM_AUT:YFETusG8gLaTVGaZQiR8eg=='
      };

  Future<SymptomAuthResponse> getSymtptomsApiToken() =>
      service.getSymtptomsApiToken();

  Future<List<GetBodySymptomsResponse>> getProposedSymptoms(
    String symptoms,
    String gender,
    String yearOfBirth,
  ) =>
      service.getProposedSymptoms(
        symptoms,
        gender,
        yearOfBirth,
        getToken,
        LocaleProvider.current.symptomChecker_language,
      );

  Future<List<GetSpecialisationsResponse>> getSpeacialisations(
    String symptoms,
    String gender,
    String yearOfBirth,
    String format,
  ) =>
      service.getSpeacialisations(
        symptoms,
        gender,
        yearOfBirth,
        getToken,
        format,
        LocaleProvider.current.symptomChecker_language,
      );

  Future<List<GetBodyLocationResponse>> getBodyLocations() async =>
      service.getBodyLocations(
        getToken,
        LocaleProvider.current.symptomChecker_language,
      );

  Future<List<GetBodySublocationResponse>> getBodySubLocations(
    int locationID,
  ) =>
      service.getBodySubLocations(
        getToken,
        LocaleProvider.current.symptomChecker_language,
        locationID,
      );

  Future<List<GetBodySymptomsResponse>> getBodySymptoms(
    int locationID,
    int gender,
  ) =>
      service.getBodySymptoms(
        getToken,
        LocaleProvider.current.symptomChecker_language,
        locationID,
        gender,
      );
}
