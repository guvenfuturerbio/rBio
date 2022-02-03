part of '../repository/doctor_repository.dart';

class DoctorApiServiceImpl extends DoctorApiService {
  DoctorApiServiceImpl(IDioHelper helper) : super(helper);

  String get getToken => getIt<ISharedPreferencesManager>()
      .getString(SharedPreferencesKeys.JWT_TOKEN);
  Options get emptyOptions => Options(headers: {});
  Options get authOptions => Options(headers: {
        'Authorization': getToken,
        'Lang': Intl.getCurrentLocale(),
        'Connection': 'keep-alive, Keep-Alive'
      });

  @override
  Future<RbioLoginResponse> login(String userName, String password) async {
    final response =
        await helper.postGuven(R.endpoints.dc_Login(userName, password), {});
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
      R.endpoints.dc_getAllAppointment,
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
      R.endpoints.dc_getMySugarPatient,
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
      R.endpoints.dc_getMyScalePatient,
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
      R.endpoints.dc_getMyBpPatient,
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
      R.endpoints.dc_getMyBMIPatient,
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
      R.endpoints.dc_getMyPatientDetail(patientId),
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
      R.endpoints.dc_updateMyPatientLimit(patientId),
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
      R.endpoints.dc_getMyPatientBloodGlucose(patientId),
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
  Future<List<ScaleModel>> getMyPatientScale(
    int patientId,
    GetMyPatientFilter getMyPatientFilter,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.dc_getMyPatientScale(patientId),
      getMyPatientFilter.toJson(),
      options: authOptions,
    );
    if (response.isSuccessful == true) {
      return response.xGetMapList
          .map((item) => ScaleModel.fromMap(item))
          .cast<ScaleModel>()
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
      R.endpoints.dc_getMyPatientPressure(patientId),
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
