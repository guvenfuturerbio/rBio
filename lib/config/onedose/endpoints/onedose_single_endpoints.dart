part of '../../abstract/app_config.dart';

class OneDoseSingleEndpoints extends SingleEndpoints {
  @override
  String getDoctorCvDetailsPath(String doctorWebID) =>
      '/api/doctor/$doctorWebID'.xGuvenPath;

  @override
  String getBannerTab(String applicationName, String groupName) =>
      '/Banner/get-banner-tabs/$applicationName/$groupName'.xDevApiTest;

  @override
  String ctIsDeviceIdRegisteredForSomeUser(deviceId, entegrationId) =>
      '/SugarDevice/is-device-id-registered-for-some-user/$deviceId/$entegrationId'
          .xDevApiTest;

  @override
  String get updateUserSystemNamePath =>
      '/Authentication/update-user-system-name-pusula'.xBaseUrl;

  @override
  String get getAppointmentTypeViaWebConsultantIdPath =>
      '/videoCall/get-stream-type-mobile'.xBaseUrl;

  @override
  String setJitsiWebConsultantIdPath(String webConsultantId) =>
      '/CerebrumOnlineAppointment/set-mobile-appointment-entrance-c4dd4e4ac7c34592827f0dbbfc233c56/$webConsultantId'
          .xBaseUrl;

  @override
  String sendOnlineAppointmentNotificationPusula(
          String appointmentId, String fromDate) =>
      "/Notification/send-online-appointment-notification-pusula/$appointmentId/$fromDate"
          .xBaseUrl;
}
