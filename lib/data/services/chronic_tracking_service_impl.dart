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
      getIt<IAppConfig>().endpoints.base.ctSaveAndRetrieveToken,
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
        getIt<IAppConfig>()
            .endpoints
            .devApi
            .ctGetUserStrip(entegrationId, deviceUUID),
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
    BloodGlucoseValue bodyPages, {
    CancelToken? cancelToken,
  }) async {
    final response = await helper.postGuven(
      getIt<IAppConfig>().endpoints.devApi.ctInsertNewBloodGlucoseValue,
      bodyPages.toJson(),
      options: authOptions,
      cancelToken: cancelToken,
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
      getIt<IAppConfig>().endpoints.devApi.ctDeleteBloodGlucoseValue,
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
      getIt<IAppConfig>().endpoints.devApi.ctUpdateBloodGlucoseValue,
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
      getIt<IAppConfig>()
          .endpoints
          .devApi
          .ctUploadMeasurementImage(entegrationId, measurementId),
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
      getIt<IAppConfig>().endpoints.devApi.ctGetBloodGlucoseReport,
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
    GetBloodGlucoseDataOfPerson getBloodGlucoseDataOfPerson,
  ) async {
    final response = await helper.postGuven(
      getIt<IAppConfig>().endpoints.devApi.ctGetBloodGlucoseDataOfPerson,
      getBloodGlucoseDataOfPerson.toJson(),
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
      getIt<IAppConfig>().endpoints.devApi.ctGetAllProfiles,
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
        getIt<IAppConfig>()
            .platform
            .sentryManager
            .captureException(e, stackTrace: stk);
        throw Exception('/getAllProfiles : $e');
      }
    } else {
      throw Exception('/getAllProfiles : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> addProfile(Person person) async {
    final response = await helper.postGuven(
      getIt<IAppConfig>().endpoints.devApi.ctAddProfile,
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
      getIt<IAppConfig>().endpoints.devApi.ctChangeProfile(userId),
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
      getIt<IAppConfig>().endpoints.devApi.ctChangeProfile(userId),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/deleteProfile : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> updateProfile(Person person, int id) async {
    final response = await helper.patchGuven(
      getIt<IAppConfig>().endpoints.devApi.ctUpdateProfile(id),
      data: person.getRequestBody(),
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
      getIt<IAppConfig>().endpoints.devApi.ctUpdateProfile(person.id),
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
      getIt<IAppConfig>().endpoints.devApi.ctSetDefaultProfile,
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
      getIt<IAppConfig>().endpoints.devApi.ctUpdateUserStrip,
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
      getIt<IAppConfig>().endpoints.devApi.ctDeleteUserStrip(id, entegrationId),
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
      getIt<IAppConfig>()
          .endpoints
          .devApi
          .ctIsDeviceIdRegisteredForSomeUser(deviceId, entegrationId),
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
      getIt<IAppConfig>()
          .endpoints
          .devApi
          .ctAddHospitalHba1cMeasurement(entegrationId),
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
      getIt<IAppConfig>()
          .endpoints
          .devApi
          .ctGetHba1cMeasurementList(entegrationId),
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
      getIt<IAppConfig>().endpoints.devApi.ctGetMedicineByFilter(text),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/getMedicineByFilter : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> deleteBpMeasurement(
    DeleteBpMeasurements deleteBpMeasurements,
  ) async {
    final response = await helper.postGuven(
      getIt<IAppConfig>().endpoints.devApi.ctDeleteBpMeasurement,
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
      getIt<IAppConfig>().endpoints.devApi.ctGetBpMeasurement,
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
      getIt<IAppConfig>().endpoints.devApi.ctInsertNewBpValue,
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
      getIt<IAppConfig>().endpoints.devApi.ctUpdateBpMeasurement,
      updateBpMeasurements.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/updateBpMeasurement : ${response.isSuccessful}');
    }
  }

  @override
  Future<ScaleTreatmentResponse> getTreatmentNoteWithDiet(
    int? entegrationId,
    ScaleTreatmentRequest request,
  ) async {
    final response = await helper.postGuven(
      getIt<IAppConfig>()
          .endpoints
          .devApi
          .getTreatmentNoteWithDiet(entegrationId),
      request.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return ScaleTreatmentResponse.fromJson(response.xGetMap);
    } else {
      throw Exception('/getTreatmentNoteWithDiet : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> treatmentGetDetail(
    TreatmentItemType itemType,
    int id,
  ) async {
    final response = await helper.getGuven(
      getIt<IAppConfig>()
          .endpoints
          .devApi
          .treatmentGetDetail(itemType.xGetRawValue, id),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/treatmentGetDetail : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> addTreatmentNote(
    int? entegrationId,
    PatientTreatmentAddRequest model,
  ) async {
    final response = await helper.postGuven(
      getIt<IAppConfig>().endpoints.devApi.addTreatmentNote(entegrationId),
      model.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/addTreatmentNote : ${response.isSuccessful}');
    }
  }
}
