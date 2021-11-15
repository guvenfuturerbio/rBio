import 'package:chopper/chopper.dart';
import 'package:intl/intl.dart';

import '../../helper/build_configurations.dart';
import '../models/add_firebase_body.dart';
import '../models/appointment_filter.dart';
import '../models/get_my_patient_filter.dart';
import '../models/update_my_patient_limit.dart';
import 'model_converter.dart';
import 'network_connection_checker.dart';

part 'api_service.chopper.dart';

@ChopperApi()
abstract class BaseProvider extends ChopperService {
  static BaseProvider create(String authToken) {
    final client = ChopperClient(
        baseUrl: BuildConfigurations.DOCTOR_BASE_URL,
        services: [_$BaseProvider()],
        interceptors: [
          HttpLoggingInterceptor(),
          HeadersInterceptor(
              {'Authorization': authToken, 'Lang': Intl.getCurrentLocale()}),
          NetworkConnectionChecker(),
          (Response response) async {
            if (response.statusCode == 401) {
              chopperLogger.severe("Unauthorized");
            }
            return response;
          }
        ],
        converter: ModelConverter());
    return _$BaseProvider(client);
  }

  @Post(path: "/mobileapi/v1/MobileDoctor/all-appointment")
  Future<Response> getAllAppointment(
      @Body() AppointmentFilter appointmentFilter);

  @Get(
      path:
          "/api/v1/file/download-patient-appointment-single-file/{userId}/{file}")
  Future<Response> getFile(
      @Path("userId") String userId, @Path("file") String file);

  @Post(path: "/api/v1/doctorpatient/get-my-patient")
  Future<Response> getMyPatients(@Body() GetMyPatientFilter getMyPatientFilter);

  @Get(path: "/api/v1/doctorpatient/get-my-patient-profile-detail/{patientId}")
  Future<Response> getMyPatientDetail(@Path("patientId") int patientId);

  @Patch(
      path: "/api/v1/doctorpatient/update-my-patient-limit-detail/{patientId}")
  Future<Response> updateMyPatientLimit(@Path("patientId") int patientId,
      @Body() UpdateMyPatientLimit updateMyPatientLimit);

  @Post(
      path:
          "/api/v1/doctorpatient/get-my-patient-blood-glucose-with-detail/{patientId}")
  Future<Response> getMyPatientBloodGlucose(@Path("patientId") int patientId,
      @Body() GetMyPatientFilter getMyPatientFilter);

  @Post(path: "/api/v1/user/add-user-firebaseId")
  Future<Response> addFirebaseToken(@Body() AddFirebaseToken addFirebaseToken);
}
