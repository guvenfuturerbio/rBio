part of 'chronic_tracking_service.dart';

class ChronicTrackingApiServiceImpl extends ChronicTrackingApiService {
  ChronicTrackingApiServiceImpl(IDioHelper helper) : super(helper);

  String get getChronicTrackingToken {
    final String? val = getIt<ISharedPreferencesManager>()
        .getString(SharedPreferencesKeys.jwtToken);

    if (val != null) {
      return val;
    } else {
      throw Exception('ChronicTrackingApiService Token Null');
    }
  }

  Options get authOptions => Options(
        headers: {
          'Authorization': getChronicTrackingToken,
          'Lang': Intl.getCurrentLocale()
        },
      );

  @override
  Future<GuvenResponseModel> saveAndRetrieveToken(
    SaveAndRetrieveTokenModel saveAndRetrieveToken,
    String token,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.ctSaveAndRetrieveToken,
      saveAndRetrieveToken.toJson(),
      options: Options(
        headers: {'Authorization': token, 'Lang': Intl.getCurrentLocale()},
      ),
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/saveAndRetrieveToken : ${response.isSuccessful}');
    }
  }

  @override
  Future<StripDetailModel> getUserStrip(
    int entegrationId,
    String? deviceUUID,
  ) async {
    if (deviceUUID != null) {
      final response = await helper.getGuven(
        R.endpoints.ctGetUserStrip(entegrationId, deviceUUID),
        options: authOptions,
      );
      if (response.xIsSuccessful) {
        return StripDetailModel.fromJson(response.xGetMap);
      } else {
        throw Exception('/getUserStrip : ${response.isSuccessful}');
      }
    } else {
      throw Exception('Device id must not be null');
    }
  }

  @override
  Future<GuvenResponseModel> insertNewBloodGlucoseValue(
    BloodGlucoseValue bodyPages,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.ctInsertNewBloodGlucoseValue,
      bodyPages.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/insertNewBloodGlucoseValue : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> deleteBloodGlucoseValue(
    DeleteBloodGlucoseMeasurementRequest deleteBloodGlucoseMeasurementRequest,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.ctDeleteBloodGlucoseValue,
      deleteBloodGlucoseMeasurementRequest.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/deleteBloodGlucoseValue : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> updateBloodGlucoseValue(
    UpdateBloodGlucoseMeasurementRequest updateBloodGlucoseMeasurementRequest,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.ctUpdateBloodGlucoseValue,
      updateBloodGlucoseMeasurementRequest.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/updateBloodGlucoseValue : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> uploadMeasurementImage(
    String file,
    int entegrationId,
    int measurementId,
  ) async {
    final $headers = {'Content-Type': 'multipart/formdata'};
    final String fileName = file.split('/').last;
    final FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file, filename: fileName),
    });
    final response = await helper.postGuven(
      R.endpoints.ctUploadMeasurementImage(entegrationId, measurementId),
      formData,
      options: authOptions..headers?.addAll($headers),
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/uploadMeasurementImage : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> getBloodGlucoseReport(
    BloodGlucoseReportBody bloodGlucoseReportBody,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.ctGetBloodGlucoseReport,
      bloodGlucoseReportBody.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/getBloodGlucoseReport : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> getBloodGlucoseDataOfPerson(
    GetBloodGlucoseDataOfPerson data,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.ctGetBloodGlucoseDataOfPerson,
      data.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception(
        '/getBloodGlucoseDataOfPerson : ${response.isSuccessful}',
      );
    }
  }

  @override
  Future<List<Person>> getAllProfiles() async {
    final response = await helper.getGuven(
      R.endpoints.ctGetAllProfiles,
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      try {
        return response.xGetMapList
            .map((e) => Person.fromJson(e))
            .cast<Person>()
            .toList();
      } catch (e, stk) {
        debugPrintStack(stackTrace: stk);
        LoggerUtils.instance.e(e);
        throw Exception('/getAllProfiles : $e');
      }
    } else {
      throw Exception('/getAllProfiles : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> addProfile(Person person) async {
    final response = await helper.postGuven(
      R.endpoints.ctAddProfile,
      person.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/addProfile : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> changeProfile(int userId) async {
    final response = await helper.postGuven(
      R.endpoints.ctChangeProfile(userId),
      {},
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/changeProfile : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> deleteProfile(int userId) async {
    final response = await helper.deleteGuven(
      R.endpoints.ctChangeProfile(userId),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/deleteProfile : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> addFirebaseToken(
    AddFirebaseToken addFirebaseToken,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.ctAddFirebaseToken,
      addFirebaseToken.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/addFirebaseToken : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> updateProfile(Person person, int id) async {
    final response = await helper.patchGuven(
      R.endpoints.ctUpdateProfile(id),
      data: person.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/updateProfile : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> addTreatment(
    Person person,
    String treatment,
  ) async {
    final response = await helper.patchGuven(
      R.endpoints.ctUpdateProfile(person.id),
      data: person.toJson()..addEntries([MapEntry('treatment', treatment)]),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/addTreatment : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> setDefaultProfile(Person person) async {
    final response = await helper.postGuven(
      R.endpoints.ctSetDefaultProfile,
      person.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/setDefaultProfile : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> updateUserStrip(
    StripDetailModel stripDetailModel,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.ctUpdateUserStrip,
      stripDetailModel.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/updateUserStrip : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> deleteUserStrip(int id, int entegrationId) async {
    final response = await helper.deleteGuven(
      R.endpoints.ctDeleteUserStrip(id, entegrationId),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/deleteUserStrip : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> isDeviceIdRegisteredForSomeUser(
    String deviceId,
    int entegrationId,
  ) async {
    final response = await helper.getGuven(
      R.endpoints.ctIsDeviceIdRegisteredForSomeUser(deviceId, entegrationId),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception(
        '/isDeviceIdRegisteredForSomeUser : ${response.isSuccessful}',
      );
    }
  }

  @override
  Future<GuvenResponseModel> addHospitalHba1cMeasurement(
    HospitalHba1cMeasurementModel hospitalHba1cMeasurementModel,
    int entegrationId,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.ctAddHospitalHba1cMeasurement(entegrationId),
      hospitalHba1cMeasurementModel.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception(
        '/addHospitalHba1cMeasurement : ${response.isSuccessful}',
      );
    }
  }

  @override
  Future<GuvenResponseModel> getHba1cMeasurementList(
    GetHba1cMeasurementListModel getHba1cMeasurementListModel,
    int entegrationId,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.ctGetHba1cMeasurementList(entegrationId),
      getHba1cMeasurementListModel.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/getHba1cMeasurementList : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> getMedicineByFilter(String text) async {
    final response = await helper.getGuven(
      R.endpoints.ctGetMedicineByFilter(text),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/getMedicineByFilter : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> insertNewScaleValue(
    AddScaleMasurementBody addScaleMasurementBody,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.ctInsertNewScaleValue,
      addScaleMasurementBody.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/insertNewScaleValue : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> deleteScaleMeasurement(
    DeleteScaleMasurementBody deleteScaleMasurementBody,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.ctDeleteScaleMeasurement,
      deleteScaleMasurementBody.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/deleteScaleMeasurement : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> getScaleMasurement(
    GetScaleMasurementBody getScaleMasurementBody,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.ctGetScaleMeasurement,
      getScaleMasurementBody.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/getScaleMasurement : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> updateScaleMeasurement(
    UpdateScaleMasurementBody updateScaleMasurementBody,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.ctUpdateScaleMeasurement,
      updateScaleMasurementBody.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/updateScaleMeasurement : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> deleteBpMeasurement(
    DeleteBpMeasurements deleteBpMeasurements,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.ctDeleteBpMeasurement,
      deleteBpMeasurements.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/deleteBpMeasurement : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> getBpMasurement(
    GetBpMeasurements getBpMeasurements,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.ctGetBpMeasurement,
      getBpMeasurements.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/getBpMasurement : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> insertNewBpValue(
    AddBpWithDetail addBpWithDetail,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.ctInsertNewBpValue,
      addBpWithDetail.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/insertNewBpValue : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> updateBpMeasurement(
    UpdateBpMeasurements updateBpMeasurements,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.ctUpdateBpMeasurement,
      updateBpMeasurements.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/updateBpMeasurement : ${response.isSuccessful}');
    }
  }
}
