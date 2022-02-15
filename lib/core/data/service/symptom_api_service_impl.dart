part of 'symptom_api_service.dart';

class SymptomApiServiceImpl extends SymptomApiService {
  SymptomApiServiceImpl(IDioHelper helper) : super(helper);

  Options get authOptions => Options(
        headers: {
          'Authorization':
              'Bearer Dc6r5_GUVENFUTURE_COM_AUT:YFETusG8gLaTVGaZQiR8eg==',
        },
      );

  // #region getSymtptomsApiToken
  @override
  Future<SymptomAuthResponse> getSymtptomsApiToken() async {
    try {
      final response = await helper.dioPost(
        R.endpoints.symptomCheckerLogin,
        {},
        options: authOptions,
      );
      if (response is Map<String, dynamic>?) {
        if (response != null) {
          return SymptomAuthResponse.fromJson(response);
        }
      }

      throw Exception('/getSymtptomsApiToken: $response');
    } catch (e) {
      throw Exception('/getSymtptomsApiToken: $e');
    }
  }
  // #endregion

  // #region getProposedSymptoms
  @override
  Future<List<GetBodySymptomsResponse>> getProposedSymptoms(
    String symptoms,
    String gender,
    String yearOfBirth,
    String token,
    String language,
  ) async {
    try {
      final response = await helper.dioGet(
        R.endpoints.symptomGetProposed,
        queryParameters: <String, dynamic>{
          'symptoms': symptoms,
          'gender': gender,
          'year_of_birth': yearOfBirth,
          'token': token,
          'language': language
        },
      );

      if (response == null) {
        throw Exception("/getProposedSymptoms data null");
      }

      if (response is List<dynamic>) {
        return (response.map((e) => GetBodySymptomsResponse.fromJson(e)))
            .toList();
      } else {
        throw RbioNotListException(
          '/getProposedSymptoms : ${response.runtimeType}',
        );
      }
    } catch (e) {
      throw Exception('/getProposedSymptoms: $e');
    }
  }
  // #endregion

  // #region getSpeacialisations
  @override
  Future<List<GetSpecialisationsResponse>> getSpeacialisations(
    String symptoms,
    String gender,
    String yearOfBirth,
    String token,
    String format,
    String language,
  ) async {
    try {
      final response = await helper.dioGet(
        R.endpoints.symptomGetSpecialisations,
        queryParameters: <String, dynamic>{
          'symptoms': symptoms,
          'gender': gender,
          'year_of_birth': yearOfBirth,
          'token': token,
          'format': format,
          'language': language
        },
      );
      if (response == null) {
        throw Exception("/getSpeacialisations data null");
      }

      if (response is List<dynamic>) {
        return response
            .map((e) => GetSpecialisationsResponse.fromJson(e))
            .toList();
      } else {
        throw RbioNotListException(
          '/getSpeacialisations : ${response.runtimeType}',
        );
      }
    } catch (e) {
      throw Exception('/getSpeacialisations : $e');
    }
  }
  // #endregion

  // #region getBodyLocations
  @override
  Future<List<GetBodyLocationResponse>> getBodyLocations(
    String token,
    String language,
  ) async {
    try {
      final response = await helper.dioGet(
        R.endpoints.symptomGetBodyLocations,
        queryParameters: <String, dynamic>{
          'token': token,
          'language': language
        },
      );
      if (response == null) {
        throw Exception("/getBodyLocations data null");
      }

      if (response is List<dynamic>) {
        return response
            .map((e) => GetBodyLocationResponse.fromJson(e))
            .toList();
      } else {
        throw RbioNotListException(
          '/getBodyLocations : ${response.runtimeType}',
        );
      }
    } catch (e) {
      throw Exception('/getBodyLocations : $e');
    }
  }
  // #endregion

  // #region getBodySubLocations
  @override
  Future<List<GetBodySublocationResponse>> getBodySubLocations(
    String token,
    String language,
    int locationID,
  ) async {
    try {
      final response = await helper.dioGet(
        R.endpoints.symptomGetBodySubLocations(locationID),
        queryParameters: <String, dynamic>{
          'token': token,
          'language': language,
        },
      );
      if (response == null) {
        throw Exception("/getBodySubLocations data null");
      }

      if (response is List<dynamic>) {
        return response
            .map((e) => GetBodySublocationResponse.fromJson(e))
            .toList();
      } else {
        throw RbioNotListException(
          '/getBodySubLocations : ${response.runtimeType}',
        );
      }
    } catch (e) {
      throw Exception('/getBodySubLocations : $e');
    }
  }
  // #endregion

  // #region getBodySymptoms
  @override
  Future<List<GetBodySymptomsResponse>> getBodySymptoms(
    String token,
    String language,
    int locationID,
    int gender,
  ) async {
    try {
      final response = await helper.dioGet(
        R.endpoints.symptomGetBodySymptoms(locationID, gender),
        queryParameters: <String, dynamic>{
          'token': token,
          'language': language,
        },
      );
      if (response == null) {
        throw Exception("/getBodySymptoms data null");
      }

      if (response is List<dynamic>) {
        return response
            .map((e) => GetBodySymptomsResponse.fromJson(e))
            .toList();
      } else {
        throw RbioNotListException(
          '/getBodySymptoms : ${response.runtimeType}',
        );
      }
    } catch (e) {
      throw Exception('/getBodySymptoms : $e');
    }
  }
  // #endregion
}
