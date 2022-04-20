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
  Future<RbioLoginResponse> login(String userId, String password) async {
    final response =
        await helper.postGuven(getIt<IAppConfig>().endpoints.doctor.login(userId, password), {});
    if (response.isSuccessful == true) {
      return RbioLoginResponse.fromJson(response.xGetMap);
    } else {
      throw Exception('/login : ${response.isSuccessful}');
    }
  }

  @override
  Future<List<Appointment>> getAllAppointment(
    AppointmentFilter appointmentFilter,
  ) async {
    final response = await helper.postGuven(
      getIt<IAppConfig>().endpoints.doctor.getAllAppointment,
      appointmentFilter.toJson(),
      options: authOptions,
    );
    if (response.isSuccessful == true) {
      return response.xGetMapList
          .map((item) => Appointment.fromJson(item))
          .cast<Appointment>()
          .toList();
    } else {
      throw Exception('/getAllAppointment : ${response.isSuccessful}');
    }
  }

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
}
