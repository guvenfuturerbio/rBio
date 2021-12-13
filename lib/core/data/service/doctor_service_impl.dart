part of '../repository/doctor_repository.dart';

class DoctorApiServiceImpl extends DoctorApiService {
  DoctorApiServiceImpl(IDioHelper helper) : super(helper);

  String get getToken => getIt<ISharedPreferencesManager>()
      .getString(SharedPreferencesKeys.DOCTOR_TOKEN);
  Options get emptyOptions => Options(headers: {});
  Options get authOptions => Options(headers: {
        'Authorization': getToken,
        'Lang': Intl.getCurrentLocale(),
        'Connection': 'keep-alive, Keep-Alive'
      });

  @override
  Future<DoctorLoginResponse> login(String userId, String password) async {
    final $headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    final response = await helper.dioPost(
      R.endpoints.dc_Login,
      <String, dynamic>{
        'client_id': SecretUtils.instance.get(SecretKeys.DOCTOR_CLIENT_ID),
        'grant_type': "password",
        'client_secret':
            SecretUtils.instance.get(SecretKeys.DOCTOR_CLIENT_SECRET),
        'scope': "openid",
        'username': userId,
        'password': password
      },
      options: emptyOptions..headers.addAll($headers),
    );
    return DoctorLoginResponse.fromJson(response);
  }

  @override
  Future<List<Appointment>> getAllAppointment(
      AppointmentFilter appointmentFilter) async {
    final response = await helper.postGuven(
        R.endpoints.dc_getAllAppointment, appointmentFilter.toJson(),
        options: authOptions);
    if (response.isSuccessful == true) {
      return response.datum
          .map((item) => Appointment.fromJson(item))
          .cast<Appointment>()
          .toList();
    } else {
      throw Exception('/getAllAppointment : ${response.isSuccessful}');
    }
  }

  @override
  Future<List<DoctorPatientModel>> getMyPatients(
      GetMyPatientFilter getMyPatientFilter) async {
    final response = await helper.postGuven(
        R.endpoints.dc_getMyPatients, getMyPatientFilter.toJson(),
        options: authOptions);
    if (response.isSuccessful == true) {
      return response.datum
          .map((item) => DoctorPatientModel.fromJson(item))
          .cast<DoctorPatientModel>()
          .toList();
    } else {
      throw Exception('/getMyPatients : ${response.isSuccessful}');
    }
  }

  @override
  Future<DoctorPatientDetailModel> getMyPatientDetail(int patientId) async {
    final response = await helper.getGuven(
        R.endpoints.dc_getMyPatientDetail(patientId),
        options: authOptions);
    if (response.isSuccessful == true) {
      return DoctorPatientDetailModel.fromJson(response.datum);
    } else {
      throw Exception('/getMyPatientDetail : ${response.isSuccessful}');
    }
  }

  @override
  Future<bool> updateMyPatientLimit(
      int patientId, UpdateMyPatientLimit updateMyPatientLimit) async {
    final response = await helper.getGuven(
        R.endpoints.dc_updateMyPatientLimit(patientId),
        options: authOptions);
    if (response.isSuccessful == true) {
      return response.datum;
    } else {
      throw Exception('/updateMyPatientLimit : ${response.isSuccessful}');
    }
  }

  @override
  Future<List<BloodGlucose>> getMyPatientBloodGlucose(
      int patientId, GetMyPatientFilter getMyPatientFilter) async {
    final response = await helper.postGuven(
        R.endpoints.dc_getMyPatientBloodGlucose(patientId),
        getMyPatientFilter.toJson(),
        options: authOptions);
    if (response.isSuccessful == true) {
      return response.datum
          .map((item) => BloodGlucose.fromJson(item))
          .cast<BloodGlucose>()
          .toList();
    } else {
      throw Exception('/getMyPatientBloodGlucose : ${response.isSuccessful}');
    }
  }
}
