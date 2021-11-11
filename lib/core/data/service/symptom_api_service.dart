import 'package:dio/dio.dart';

import 'package:onedosehealth/core/data/helper/dio_helper.dart';
import 'package:onedosehealth/model/model.dart';
import '../../core.dart';

abstract class SymptomApiService {
  final IDioHelper helper;
  SymptomApiService(this.helper);
  Future<SymptomAuthResponse> getSymtptomsApiToken();
  Future<List<GetBodySymptomsResponse>> getProposedSymptoms(String symptoms,
      String gender, String year_of_birth, String token, String language);
  Future<List<GetSpecialisationsResponse>> getSpeacialisations(
      String symptoms,
      String gender,
      String year_of_birth,
      String token,
      String format,
      String language);
  Future<List<GetBodyLocationResponse>> getBodyLocations(
      String token, String language);
  Future<List<GetBodySublocationResponse>> getBodySubLocations(
      String token, String language, int locationID);
  Future<List<GetBodySymptomsResponse>> getBodySymptoms(
      String token, String language, int locationID, int gender);
}

class SymptomApiServiceImpl extends SymptomApiService {
  SymptomApiServiceImpl(IDioHelper helper) : super(helper);

  Options get authOptions => Options(headers: {
        'Authorization':
            'Bearer Dc6r5_GUVENFUTURE_COM_AUT:YFETusG8gLaTVGaZQiR8eg==',
      });

  @override
  Future<SymptomAuthResponse> getSymtptomsApiToken() async {
    try {
      final response = await helper.dioPost(R.endpoints.symptomCheckerLogin, {},
          options: authOptions);
      return SymptomAuthResponse.fromJson(response);
    } catch (e) {
      throw Exception('/getSymtptomsApiToken: $e');
    }
  }

  @override
  Future<List<GetBodySymptomsResponse>> getProposedSymptoms(
      String symptoms,
      String gender,
      String year_of_birth,
      String token,
      String language) async {
    try {
      final response = await helper.dioGet(
        R.endpoints.symptomGetProposed,
        queryParameters: <String, dynamic>{
          'symptoms': symptoms,
          'gender': gender,
          'year_of_birth': year_of_birth,
          'token': token,
          'language': language
        },
      );
      if (response is List) {
        return response.map((e) => GetBodySymptomsResponse.fromJson(e)).toList();
      } else {
        throw Exception('/getSymtptomsApiToken : Data is not list!');
      }
    } catch (e) {
      throw Exception('/getSymtptomsApiToken: $e');
    }
  }

  @override
  Future<List<GetSpecialisationsResponse>> getSpeacialisations(
      String symptoms,
      String gender,
      String year_of_birth,
      String token,
      String format,
      String language) async {
    try {
      final response = await helper.dioGet(
        R.endpoints.symptomGetProposed,
        queryParameters: <String, dynamic>{
          'symptoms': symptoms,
          'gender': gender,
          'year_of_birth': year_of_birth,
          'token': token,
          'format': format,
          'language': language
        },
      );
      if (response is List) {
        return response.map((e) => GetSpecialisationsResponse.fromJson(e)).toList();
      } else {
        throw Exception('/getSpeacialisations : Data is not list!');
      }
    } catch (e) {
      throw Exception('/getSpeacialisations : $e');
    }
  }

  @override
  Future<List<GetBodyLocationResponse>> getBodyLocations(
      String token, String language) async {
    try {
      final response = await helper.dioGet(
        R.endpoints.symptomGetBodyLocations,
        queryParameters: <String, dynamic>{
          'token': token,
          'language': language
        },
      );
      if (response is List) {
        return response.map((e) => GetBodyLocationResponse.fromJson(e)).toList();
      } else {
        throw Exception('/getBodyLocations : Data is not list!');
      }
    } catch (e) {
      throw Exception('/getBodyLocations : $e');
    }
  }

  @override
  Future<List<GetBodySublocationResponse>> getBodySubLocations(
      String token, String language, int locationID) async {
    try {
      final response = await helper.dioGet(
        R.endpoints.symptomGetBodySubLocations(locationID),
        queryParameters: <String, dynamic>{
          'token': token,
          'language': language,
        },
      );
      if (response is List) {
        return response.map((e) => GetBodySublocationResponse.fromJson(e)).toList();
      } else {
        throw Exception('/getBodySubLocations : Data is not list!');
      }
    } catch (e) {
      throw Exception('/getBodySubLocations : $e');
    }
  }

  @override
  Future<List<GetBodySymptomsResponse>> getBodySymptoms(
      String token, String language, int locationID, int gender) async {
    try {
      final response = await helper.dioGet(
        R.endpoints.symptomGetBodySymptoms(locationID, gender),
        queryParameters: <String, dynamic>{
          'token': token,
          'language': language,
        },
      );
      if (response is List) {
        return response.map((e) => GetBodySymptomsResponse.fromJson(e)).toList();
      } else {
        throw Exception('/getBodySymptoms : Data is not list!');
      }
    } catch (e) {
      throw Exception('/getBodySymptoms : $e');
    }
  }
}
