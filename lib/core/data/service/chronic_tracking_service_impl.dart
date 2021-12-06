part of '../imports/cronic_tracking.dart';

class ChronicTrackingApiServiceImpl extends ChronicTrackingApiService {
  ChronicTrackingApiServiceImpl(IDioHelper helper) : super(helper);

  String get getChronicTrackingToken => getIt<ISharedPreferencesManager>()
      .getString(SharedPreferencesKeys.CT_AUTH_TOKEN);
  Options get authOptions => Options(headers: {
        'Authorization': getChronicTrackingToken,
        'Lang': Intl.getCurrentLocale()
      });

  @override
  Future<LoginResponse> login(
      {String clientId,
      String grantType,
      String clientSecret,
      String scope,
      String username,
      String password}) async {
    final response = await helper.dioPost(
      R.endpoints.ct_login,
      <String, dynamic>{
        'client_id': clientId,
        'grant_type': grantType,
        'client_secret': clientSecret,
        'scope': scope,
        'username': username,
        'password': password
      },
    );
    return LoginResponse.fromJson(response);
  }

  @override
  Future<GuvenResponseModel> saveAndRetrieveToken(
      SaveAndRetrieveTokenModel saveAndRetrieveToken, String token) async {
    final response = await helper.postGuven(
        R.endpoints.ct_saveAndRetrieveToken, saveAndRetrieveToken.toJson(),
        options: Options(headers: {
          'Authorization': token,
          'Lang': Intl.getCurrentLocale()
        }));
    if (response.isSuccessful) {
      return response;
    } else {
      throw Exception('/saveAndRetrieveToken : ${response.isSuccessful}');
    }
  }

  @override
  Future<StripDetailModel> getUserStrip(entegrationId, deviceUUID) async {
    final response = await helper.getGuven(
        R.endpoints.ct_getUserStrip(entegrationId, deviceUUID),
        options: authOptions);
    if (response.isSuccessful) {
      return StripDetailModel.fromJson(response.datum);
    } else {
      throw Exception('/getUserStrip : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> insertNewBloodGlucoseValue(
      BloodGlucoseValue bodyPages) async {
    final response = await helper.postGuven(
      R.endpoints.ct_insertNewBloodGlucoseValue,
      bodyPages.toJson(),
      options: authOptions,
    );
    if (response.isSuccessful) {
      return response;
    } else {
      throw Exception('/insertNewBloodGlucoseValue : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> deleteBloodGlucoseValue(
      DeleteBloodGlucoseMeasurementRequest
          deleteBloodGlucoseMeasurementRequest) async {
    final response = await helper.postGuven(
        R.endpoints.ct_deleteBloodGlucoseValue,
        deleteBloodGlucoseMeasurementRequest.toJson(),
        options: authOptions);
    if (response.isSuccessful) {
      return response;
    } else {
      throw Exception('/deleteBloodGlucoseValue : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> updateBloodGlucoseValue(
      UpdateBloodGlucoseMeasurementRequest
          updateBloodGlucoseMeasurementRequest) async {
    final response = await helper.postGuven(
        R.endpoints.ct_updateBloodGlucoseValue,
        updateBloodGlucoseMeasurementRequest.toJson(),
        options: authOptions);
    if (response.isSuccessful) {
      return response;
    } else {
      throw Exception('/updateBloodGlucoseValue : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> uploadMeasurementImage(
      String file, int entegrationId, int measurementId) async {
    final $headers = {'Content-Type': 'multipart/formdata'};
    String fileName = file.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file, filename: fileName),
    });
    final response = await helper.postGuven(
        R.endpoints.ct_uploadMeasurementImage(entegrationId, measurementId),
        formData,
        options: authOptions..headers.addAll($headers));
    if (response.isSuccessful) {
      return response;
    } else {
      throw Exception('/uploadMeasurementImage : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> getBloodGlucoseReport(
      BloodGlucoseReportBody bloodGlucoseReportBody) async {
    final response = await helper.postGuven(
      R.endpoints.ct_getBloodGlucoseReport,
      bloodGlucoseReportBody.toJson(),
      options: authOptions,
    );
    if (response.isSuccessful) {
      return response;
    } else {
      throw Exception('/getBloodGlucoseReport : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> getBloodGlucoseDataOfPerson(
      GetBloodGlucoseDataOfPerson getBloodGlucoseDataOfPersonData) async {
    final response = await helper.postGuven(
        R.endpoints.ct_getBloodGlucoseDataOfPerson,
        getBloodGlucoseDataOfPersonData.toJson(),
        options: authOptions);
    if (response.isSuccessful) {
      return response;
    } else {
      throw Exception(
          '/getBloodGlucoseDataOfPerson : ${response.isSuccessful}');
    }
  }

  @override
  Future<List<Person>> getAllProfiles() async {
    final response = await helper.getGuven(R.endpoints.ct_getAllProfiles,
        options: authOptions);
    if (response.isSuccessful) {
      return response.datum
          .map((e) => Person.fromJson(e))
          .cast<Person>()
          .toList();
    } else {
      throw Exception('/getAllProfiles : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> addProfile(Person person) async {
    final response = await helper.postGuven(
      R.endpoints.ct_addProfile,
      person.toJson(),
      options: authOptions,
    );
    if (response.isSuccessful) {
      return response;
    } else {
      throw Exception('/addProfile : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> changeProfile(userId) async {
    final response = await helper.postGuven(
        R.endpoints.ct_changeProfile(userId), {},
        options: authOptions);
    if (response.isSuccessful) {
      return response;
    } else {
      throw Exception('/changeProfile : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> deleteProfile(var userId) async {
    final response = await helper.deleteGuven(
        R.endpoints.ct_changeProfile(userId),
        options: authOptions);
    if (response.isSuccessful) {
      return response;
    } else {
      throw Exception('/deleteProfile : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> addFirebaseToken(
      AddFirebaseToken addFirebaseToken) async {
    final response = await helper.postGuven(
        R.endpoints.ct_addFirebaseToken, addFirebaseToken.toJson(),
        options: authOptions);
    if (response.isSuccessful) {
      return response;
    } else {
      throw Exception('/addFirebaseToken : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> updateProfile(Person person, var id) async {
    final response = await helper.patchGuven(
      R.endpoints.ct_updateProfile(id),
      data: person.toJson(),
      options: authOptions,
    );
    if (response.isSuccessful) {
      return response;
    } else {
      throw Exception('/updateProfile : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> setDefaultProfile(Person person) async {
    final response = await helper.postGuven(
      R.endpoints.ct_setDefaultProfile,
      person.toJson(),
      options: authOptions,
    );
    if (response.isSuccessful) {
      return response;
    } else {
      throw Exception('/setDefaultProfile : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> updateUserStrip(
      StripDetailModel stripDetailModel) async {
    final response = await helper.postGuven(
      R.endpoints.ct_updateUserStrip,
      stripDetailModel.toJson(),
      options: authOptions,
    );
    if (response.isSuccessful) {
      return response;
    } else {
      throw Exception('/updateUserStrip : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> deleteUserStrip(var id, var entegrationId) async {
    final response = await helper.deleteGuven(
      R.endpoints.ct_deleteUserStrip(id, entegrationId),
      options: authOptions,
    );
    if (response.isSuccessful) {
      return response;
    } else {
      throw Exception('/deleteUserStrip : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> isDeviceIdRegisteredForSomeUser(
      var deviceId, var entegrationId) async {
    final response = await helper.getGuven(
      R.endpoints.ct_isDeviceIdRegisteredForSomeUser(deviceId, entegrationId),
      options: authOptions,
    );
    if (response.isSuccessful) {
      return response;
    } else {
      throw Exception(
          '/isDeviceIdRegisteredForSomeUser : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> addHospitalHba1cMeasurement(
      HospitalHba1cMeasurementModel hospitalHba1cMeasurementModel,
      entegrationId) async {
    final response = await helper.postGuven(
      R.endpoints.ct_addHospitalHba1cMeasurement(entegrationId),
      hospitalHba1cMeasurementModel.toJson(),
      options: authOptions,
    );
    if (response.isSuccessful) {
      return response;
    } else {
      throw Exception(
          '/addHospitalHba1cMeasurement : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> getHba1cMeasurementList(
      GetHba1cMeasurementListModel getHba1cMeasurementListModel,
      entegrationId) async {
    final response = await helper.postGuven(
      R.endpoints.ct_getHba1cMeasurementList(entegrationId),
      getHba1cMeasurementListModel.toJson(),
      options: authOptions,
    );
    if (response.isSuccessful) {
      return response;
    } else {
      throw Exception('/getHba1cMeasurementList : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> getMedicineByFilter(String text) async {
    final response = await helper.getGuven(
      R.endpoints.ct_getMedicineByFilter(text),
      options: authOptions,
    );
    if (response.isSuccessful) {
      return response;
    } else {
      throw Exception('/getMedicineByFilter : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> insertNewScaleValue(
      AddScaleMasurementBody addScaleMasurementBody) async {
    final response = await helper.postGuven(
      R.endpoints.ct_insertNewScaleValue,
      addScaleMasurementBody.toJson(),
      options: authOptions,
    );
    if (response.isSuccessful) {
      return response;
    } else {
      throw Exception('/insertNewScaleValue : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> deleteScaleMeasurement(
      DeleteScaleMasurementBody deleteScaleMasurementBody) async {
    final response = await helper.postGuven(
        R.endpoints.ct_deleteScaleMeasurement,
        deleteScaleMasurementBody.toJson(),
        options: authOptions);
    if (response.isSuccessful) {
      return response;
    } else {
      throw Exception('/deleteScaleMeasurement : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> getScaleMasurement(
      GetScaleMasurementBody getScaleMasurementBody) async {
    final response = await helper.postGuven(
        R.endpoints.ct_getScaleMeasurement, getScaleMasurementBody.toJson(),
        options: authOptions);
    if (response.isSuccessful) {
      return response;
    } else {
      throw Exception('/getScaleMasurement : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> updateScaleMeasurement(
      UpdateScaleMasurementBody updateScaleMasurementBody) async {
    final response = await helper.postGuven(
        R.endpoints.ct_updateScaleMeasurement,
        updateScaleMasurementBody.toJson(),
        options: authOptions);
    if (response.isSuccessful) {
      return response;
    } else {
      throw Exception('/updateScaleMeasurement : ${response.isSuccessful}');
    }
  }
}
