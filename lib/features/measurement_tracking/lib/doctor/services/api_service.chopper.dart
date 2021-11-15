// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

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
  Future<Response<dynamic>> getAllAppointment(
      AppointmentFilter appointmentFilter) {
    final $url = '/mobileapi/v1/MobileDoctor/all-appointment';
    final $body = appointmentFilter;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getFile(String userId, String file) {
    final $url =
        '/api/v1/file/download-patient-appointment-single-file/$userId/$file';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getMyPatients(
      GetMyPatientFilter getMyPatientFilter) {
    final $url = '/api/v1/doctorpatient/get-my-patient';
    final $body = getMyPatientFilter;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getMyPatientDetail(int patientId) {
    final $url =
        '/api/v1/doctorpatient/get-my-patient-profile-detail/$patientId';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> updateMyPatientLimit(
      int patientId, UpdateMyPatientLimit updateMyPatientLimit) {
    final $url =
        '/api/v1/doctorpatient/update-my-patient-limit-detail/$patientId';
    final $body = updateMyPatientLimit;
    final $request = Request('PATCH', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getMyPatientBloodGlucose(
      int patientId, GetMyPatientFilter getMyPatientFilter) {
    final $url =
        '/api/v1/doctorpatient/get-my-patient-blood-glucose-with-detail/$patientId';
    final $body = getMyPatientFilter;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> addFirebaseToken(
      AddFirebaseToken addFirebaseToken) {
    final $url = '/api/v1/user/add-user-firebaseId';
    final $body = addFirebaseToken;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
