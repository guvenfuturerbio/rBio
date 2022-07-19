part of 'doctor_service.dart';

class DoctorApiServiceImpl extends DoctorApiService {
  DoctorApiServiceImpl(IDioHelper helper) : super(helper);

  String get getToken {
    final String? token = getIt<ISharedPreferencesManager>()
        .getString(SharedPreferencesKeys.jwtToken);
    if (token != null) {
      return token;
    } else {
      throw Exception('DoctorApiService token null');
    }
  }

  Options get emptyOptions => Options(headers: {});
  Options get authOptions => Options(headers: {
        'Authorization': getToken,
        'Lang': Intl.getCurrentLocale(),
        'Connection': 'keep-alive, Keep-Alive'
      });

  @override
  Future<List<DoctorGlucosePatientModel>> getMySugarPatient(
    GetMyPatientFilter getMyPatientFilter,
  ) async {
    final response = await helper.postGuven(
      getIt<IAppConfig>().endpoints.doctor.getMySugarPatient,
      getMyPatientFilter.toJson(),
      options: authOptions,
    );
    if (response.isSuccessful == true) {
      return response.xGetMapList
          .map((item) => DoctorGlucosePatientModel.fromJson(item))
          .cast<DoctorGlucosePatientModel>()
          .toList();
    } else {
      throw Exception('/getMyPatients : ${response.isSuccessful}');
    }
  }

  @override
  Future<List<DoctorGlucosePatientModel>> getMyScalePatient(
    GetMyPatientFilter getMyPatientFilter,
  ) async {
    final response = await helper.postGuven(
      getIt<IAppConfig>().endpoints.doctor.getMyScalePatient,
      getMyPatientFilter.toJson(),
      options: authOptions,
    );
    if (response.isSuccessful == true) {
      return response.xGetMapList
          .map((item) => DoctorGlucosePatientModel.fromJson(item))
          .cast<DoctorGlucosePatientModel>()
          .toList();
    } else {
      throw Exception('/getMyScalePatient : ${response.isSuccessful}');
    }
  }

  @override
  Future<List<DoctorBloodPressurePatientModel>> getMyBpPatient(
    GetMyPatientFilter getMyPatientFilter,
  ) async {
    final response = await helper.postGuven(
      getIt<IAppConfig>().endpoints.doctor.getMyBpPatient,
      getMyPatientFilter.toJson(),
      options: authOptions,
    );
    if (response.isSuccessful == true) {
      return response.xGetMapList
          .map((item) => DoctorBloodPressurePatientModel.fromJson(item))
          .cast<DoctorBloodPressurePatientModel>()
          .toList();
    } else {
      throw Exception('/getMyBpPatient : ${response.isSuccessful}');
    }
  }

  @override
  Future<List<DoctorBMIPatientModel>> getMyBMIPatient(
    GetMyPatientFilter getMyPatientFilter,
  ) async {
    final response = await helper.postGuven(
      getIt<IAppConfig>().endpoints.doctor.getMyBMIPatient,
      getMyPatientFilter.toJson(),
      options: authOptions,
    );
    if (response.isSuccessful == true) {
      LoggerUtils.instance.i(response.datum);
      return response.xGetMapList
          .map((item) => DoctorBMIPatientModel.fromJson(item))
          .cast<DoctorBMIPatientModel>()
          .toList();
    } else {
      throw Exception('/getMyBpPatient : ${response.isSuccessful}');
    }
  }

  @override
  Future<DoctorPatientDetailModel> getMyPatientDetail(int patientId) async {
    final response = await helper.getGuven(
      getIt<IAppConfig>().endpoints.doctor.getMyPatientDetail(patientId),
      options: authOptions,
    );
    if (response.isSuccessful == true) {
      return DoctorPatientDetailModel.fromJson(response.xGetMap);
    } else {
      throw Exception('/getMyPatientDetail : ${response.isSuccessful}');
    }
  }

  @override
  Future<bool> updateMyPatientLimit(
    int patientId,
    UpdateMyPatientLimit updateMyPatientLimit,
  ) async {
    final response = await helper.patchGuven(
      getIt<IAppConfig>().endpoints.doctor.updateMyPatientLimit(patientId),
      data: updateMyPatientLimit.toJson(),
      options: authOptions,
    );
    if (response.isSuccessful == true) {
      return response.xGetBool;
    } else {
      throw Exception('/updateMyPatientLimit : ${response.isSuccessful}');
    }
  }

  @override
  Future<List<BloodGlucose>> getMyPatientBloodGlucose(
    int patientId,
    GetMyPatientFilter getMyPatientFilter,
  ) async {
    final response = await helper.postGuven(
      getIt<IAppConfig>().endpoints.doctor.getMyPatientBloodGlucose(patientId),
      getMyPatientFilter.toJson(),
      options: authOptions,
    );
    if (response.isSuccessful == true) {
      return response.xGetMapList
          .map((item) => BloodGlucose.fromJson(item))
          .cast<BloodGlucose>()
          .toList();
    } else {
      throw Exception('/getMyPatientBloodGlucose : ${response.isSuccessful}');
    }
  }

  @override
  Future<List<PatientScaleMeasurement>> getMyPatientScale(
    int patientId,
    GetMyPatientFilter getMyPatientFilter,
  ) async {
    final response = await helper.postGuven(
      getIt<IAppConfig>().endpoints.doctor.getMyPatientScale(patientId),
      getMyPatientFilter.toJson(),
      options: authOptions,
    );
    if (response.isSuccessful == true) {
      return response.xGetMapList
          .map((item) => PatientScaleMeasurement.fromJson(item))
          .cast<PatientScaleMeasurement>()
          .toList();
    } else {
      throw Exception('/getMyPatientScale : ${response.isSuccessful}');
    }
  }

  @override
  Future<List<BloodPressureModel>> getMyPatientBloodPressure(
    int patientId,
    GetMyPatientFilter getMyPatientFilter,
  ) async {
    final response = await helper.postGuven(
      getIt<IAppConfig>().endpoints.doctor.getMyPatientPressure(patientId),
      getMyPatientFilter.toJson(),
      options: authOptions,
    );
    if (response.isSuccessful == true) {
      return response.xGetMapList
          .map((item) => BloodPressureModel.fromJson(item))
          .cast<BloodPressureModel>()
          .toList();
    } else {
      throw Exception('/getMyPatientBloodGlucose : ${response.isSuccessful}');
    }
  }

  @override
  Future<ScaleTreatmentResponse> getTreatmentNoteWithDietDoctor(
    int patientId,
    ScaleTreatmentRequest request,
  ) async {
    final response = await helper.postGuven(
      getIt<IAppConfig>()
          .endpoints
          .treatment
          .getTreatmentNoteWithDietDoctor(patientId),
      request.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return ScaleTreatmentResponse.fromJson(response.xGetMap);
    } else {
      throw Exception(
          '/getTreatmentNoteWithDietDoctor : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> treatmentGetDetail(
    TreatmentItemType type,
    int id,
  ) async {
    final response = await helper.getGuven(
      getIt<IAppConfig>()
          .endpoints
          .treatment
          .treatmentGetDetail(type.xGetRawValue, id),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/treatmentGetDetail : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> treatmentAddDiet(
    int patientId,
    ScaleDietListAddRequest model,
  ) async {
    final response = await helper.postGuven(
      getIt<IAppConfig>().endpoints.treatment.addDiet(patientId),
      model.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/treatmentAddDiet : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> deleteNoteDiet(
    TreatmentItemType type,
    int id,
  ) async {
    final response = await helper.deleteGuven(
      getIt<IAppConfig>()
          .endpoints
          .treatment
          .deleteNoteDiet(type.xGetRawValue, id),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/deleteNoteDiet : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> addTreatmentNote(
    int patientId,
    PatientTreatmentAddRequest model,
  ) async {
    final response = await helper.postGuven(
      getIt<IAppConfig>().endpoints.treatment.addTreatmentNoteDoctor(patientId),
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
