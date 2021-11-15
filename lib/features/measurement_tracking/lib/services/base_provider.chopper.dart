// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_provider.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$BaseProvider extends BaseProvider {
  _$BaseProvider([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = BaseProvider;

  @override
  Future<Response<dynamic>> getMedicineByFilter(String text) {
    final $url = '/Medicine/get-by-filter/$text';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getDoctorList(dynamic entegrationId) {
    final $url = '/Measurement/get-patient-doctors';
    final $params = <String, dynamic>{'entegration_id': entegrationId};
    final $request = Request('POST', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> insertNewBloodGlucoseValue(
      BloodGlucoseValue bodyPages) {
    final $url = '/Measurement/add-blood-glucose-with-detail';
    final $body = bodyPages;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteBloodGlucoseValue(
      DeleteBloodGlucoseMeasurementRequest
          deleteBloodGlucoseMeasurementRequest) {
    final $url = '/Measurement/delete-blood-glucose-with-detail';
    final $body = deleteBloodGlucoseMeasurementRequest;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> updateBloodGlucoseValue(
      UpdateBloodGlucoseMeasurementRequest
          updateBloodGlucoseMeasurementRequest) {
    final $url = '/Measurement/update-blood-glucose-with-detail';
    final $body = updateBloodGlucoseMeasurementRequest;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> uploadMeasurementImage(
      String file, dynamic entegrationId, dynamic measurementId) {
    final $url =
        '/Measurement/upload-measurement-image/$entegrationId/$measurementId';
    final $headers = {'Content-Type': 'multipart/formdata'};
    final $parts = <PartValue>[PartValueFile<String>('file', file)];
    final $request = Request('POST', $url, client.baseUrl,
        parts: $parts, multipart: true, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> addHospitalHba1cMeasurement(
      HospitalHba1cMeasurementModel hospitalHba1cMeasurementModel,
      dynamic entegrationId) {
    final $url = '/Measurement/add-hospital-hba1c-measurement/$entegrationId';
    final $body = hospitalHba1cMeasurementModel;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getHba1cMeasurementList(
      GetHba1cMeasurementListModel getHba1cMeasurementListModel,
      dynamic entegrationId) {
    final $url =
        '/Measurement/get-list-hospital-hba1c-measurement/$entegrationId';
    final $body = getHba1cMeasurementListModel;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getBloodGlucoseReport(
      BloodGlucoseReportBody bloodGlucoseReportBody) {
    final $url = '/Measurement/get-my-blood-glucose-report';
    final $body = bloodGlucoseReportBody;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getBloodGlucoseDataOfPerson(
      GetBloodGlucoseDataOfPerson getBloodGlucoseDataOfPerson) {
    final $url =
        '/Measurement/get-my-blood-glucose-with-detail-and-limit-value';
    final $body = getBloodGlucoseDataOfPerson;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getOnlineDoctorDepartments() {
    final $url = '/department/get-online-appointment-departments';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getOnlineDoctorByDepartments(String id) {
    final $url = '/filter/get-online-doctor-by-department/$id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getAllPatientAppointment(
      dynamic entegrationId, int count, BodyPages bodyPages) {
    final $url = 'appointment/get-all-table-by-patient/$count/$entegrationId';
    final $body = bodyPages;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getAllDoctorAppointment(
      String doctorId, String date, List<Filter> filters) {
    final $url = '/mobileappointment/get-by-doctor-and-date/$doctorId/$date';
    final $body = filters;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getClosestAppointment(String id) {
    final $url = '/MobileAppointment/get-close-by-doctor-and-date/$id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getAllProfiles() {
    final $url = '/profile/get-all';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> addProfile(Person person) {
    final $url = '/profile/add';
    final $body = person;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> changeProfile(dynamic userId) {
    final $url = '/profile/set-profile/$userId';
    final $request = Request('POST', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteProfile(dynamic userId) {
    final $url = '/profile/delete/$userId';
    final $request = Request('DELETE', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> doPayment(Payment payment) {
    final $url = '/payment/do-mobile-payment';
    final $body = payment;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> addFirebaseToken(
      AddFirebaseToken addFirebaseToken) {
    final $url = '/user/add-user-firebaseId';
    final $body = addFirebaseToken;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> updateProfile(Person person, dynamic id) {
    final $url = '/user/user-profile-update/$id';
    final $body = person;
    final $request = Request('PATCH', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> setDefaultProfile(Person person) {
    final $url = '/user/set-user-profile-default-value';
    final $body = person;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> userHasIdentificationNumber(int entegrationId) {
    final $url = '/user/has-identification-number/$entegrationId';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> addAdditionalInformation(
      AdditionalInfoModel additionalInfoModel, int entegrationId) {
    final $url = '/user/add-identification-number/$entegrationId';
    final $body = additionalInfoModel;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> updateUserStrip(StripDetailModel stripDetailModel) {
    final $url = '/user/add-update-user-strip';
    final $body = stripDetailModel;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getUserStrip(
      dynamic entegrationId, dynamic deviceUUID) {
    final $url = '/user/get-user-strip/$entegrationId/$deviceUUID';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteUserStrip(dynamic id, dynamic entegrationId) {
    final $url = '/user/delete-user-strip/$id/$entegrationId';
    final $request = Request('DELETE', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> saveAndRetrieveToken(
      SaveAndRetrieveTokenModel saveAndRetrieveToken) {
    final $url = '/UserRegister/save-and-retrive-token';
    final $body = saveAndRetrieveToken;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> isDeviceIdRegisteredForSomeUser(
      dynamic deviceId, dynamic entegrationId) {
    final $url =
        '/SugarDevice/is-device-id-registered-for-some-user/$deviceId/$entegrationId';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> fetchAllCountry() {
    final $url = '/country/get-all';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> uploadProfilePicture(
      String file, dynamic entegrationId) {
    final $url = '/file/profil-image-upload/$entegrationId';
    final $headers = {'Content-Type': 'multipart/formdata'};
    final $parts = <PartValue>[PartValueFile<String>('file', file)];
    final $request = Request('POST', $url, client.baseUrl,
        parts: $parts, multipart: true, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getProfilePicture(dynamic entegrationId) {
    final $url = '/file/retrieve-user-profile-image/$entegrationId';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteProfilePicture(dynamic entegrationId) {
    final $url = '/file/delete-profile-photo/$entegrationId';
    final $request = Request('DELETE', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getPatientAppointmentDoctor(
      dynamic dep_id, dynamic entegration_id) {
    final $url =
        'appointment/get-appointment-doctor-info/$dep_id/$entegration_id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getAppointmentFiles(
      dynamic entegration_id, String roomId) {
    final $url =
        '/file/get-patient-appointments-file-names/$entegration_id/$roomId';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteAppointmentFile(
      dynamic entegration_id, String webAppoId, String fileName) {
    final $url =
        '/file/report-file-delete/$entegration_id/$webAppoId/$fileName';
    final $request = Request('DELETE', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> uploadFileToAppointment(
      dynamic entegration_id, String webAppoId, String file) {
    final $url =
        '/file/upload-patient-document-for-appoinment/$entegration_id/$webAppoId';
    final $headers = {'Content-Type': 'multipart/formdata'};
    final $parts = <PartValue>[PartValueFile<String>('file', file)];
    final $request = Request('POST', $url, client.baseUrl,
        parts: $parts, multipart: true, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> downloadAppointmentFile(
      dynamic entegration_id, String id, String name) {
    final $url = '/file/report-file-download/$entegration_id/$id/$name';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getAllFiles(dynamic entegration_id) {
    final $url =
        '/file/get-patient-all-appointments-file-names/$entegration_id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> downloadAppointmentSingleFile(
      dynamic entegration_id, String folder, String path) {
    final $url =
        '/file/download-patient-appointment-single-file/$entegration_id/$folder/$path';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
