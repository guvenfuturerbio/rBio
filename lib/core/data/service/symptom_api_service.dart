import 'package:dio/dio.dart';

import '../helper/dio_helper.dart';
import '../../../model/model.dart';
import '../../core.dart';

part 'symptom_api_service_impl.dart';

abstract class SymptomApiService {
  final IDioHelper helper;
  SymptomApiService(this.helper);
  Future<SymptomAuthResponse> getSymtptomsApiToken();
  Future<List<GetBodySymptomsResponse>> getProposedSymptoms(
    String symptoms,
    String gender,
    String year_of_birth,
    String token,
    String language,
  );
  Future<List<GetSpecialisationsResponse>> getSpeacialisations(
    String symptoms,
    String gender,
    String year_of_birth,
    String token,
    String format,
    String language,
  );
  Future<List<GetBodyLocationResponse>> getBodyLocations(
    String token,
    String language,
  );
  Future<List<GetBodySublocationResponse>> getBodySubLocations(
    String token,
    String language,
    int locationID,
  );
  Future<List<GetBodySymptomsResponse>> getBodySymptoms(
    String token,
    String language,
    int locationID,
    int gender,
  );
}
