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
  Future<StripDetailModel> getUserStrip(
    int entegrationId,
    String? deviceUUID,
  ) async {
    if (deviceUUID != null) {
      final response = await helper.getGuven(
        getIt<IAppConfig>()
            .endpoints
            .user
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
      getIt<IAppConfig>().endpoints.measurement.ctInsertNewBloodGlucoseValue,
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
      getIt<IAppConfig>().endpoints.measurement.ctDeleteBloodGlucoseValue,
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
      getIt<IAppConfig>().endpoints.measurement.ctUpdateBloodGlucoseValue,
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
          .measurement
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
  Future<GuvenResponseModel> getBloodGlucoseDataOfPerson(
    GetBloodGlucoseDataOfPerson getBloodGlucoseDataOfPerson,
  ) async {
    final response = await helper.postGuven(
      getIt<IAppConfig>().endpoints.measurement.ctGetBloodGlucoseDataOfPerson,
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
      getIt<IAppConfig>().endpoints.profile.getAllProfiles,
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
      getIt<IAppConfig>().endpoints.profile.addProfile,
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
  Future<GuvenResponseModel> updateProfile(Person person, int id) async {
    final response = await helper.patchGuven(
      getIt<IAppConfig>().endpoints.user.ctUpdateProfile(id),
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
      getIt<IAppConfig>().endpoints.user.ctUpdateProfile(person.id),
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
      getIt<IAppConfig>().endpoints.user.ctSetDefaultProfile,
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
      getIt<IAppConfig>().endpoints.user.ctUpdateUserStrip,
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
      getIt<IAppConfig>().endpoints.user.ctDeleteUserStrip(id, entegrationId),
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
          .single
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
  Future<GuvenResponseModel> deleteBpMeasurement(
    DeleteBpMeasurements deleteBpMeasurements,
  ) async {
    final response = await helper.postGuven(
      getIt<IAppConfig>().endpoints.measurement.ctDeleteBpMeasurement,
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
      getIt<IAppConfig>().endpoints.measurement.ctGetBpMeasurement,
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
      getIt<IAppConfig>().endpoints.measurement.ctInsertNewBpValue,
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
      getIt<IAppConfig>().endpoints.measurement.ctUpdateBpMeasurement,
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
          .treatment
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
          .treatment
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
      getIt<IAppConfig>().endpoints.treatment.addTreatmentNote(entegrationId),
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
