part of '../../abstract/app_config.dart';

class GuvenPusulaEndpoints extends PusulaEndpoints {
  @override
  String findResourceAvailableDays =
      '/Pusula/findResourceAvailableDays'.xBaseUrl;

  @override
  String getPatientDetailPath = '/Pusula/getPatientByToken'.xBaseUrl;

  @override
  String filterTenantsPath = '/Pusula/filterTenants'.xBaseUrl;

  @override
  String filterDepartmentsPath = '/Pusula/filterDepartments'.xBaseUrl;

  @override
  String filterResourcesPath = '/Pusula/filterResources'.xBaseUrl;

  @override
  String findResourceClosestAvailablePlanPath =
      '/Pusula/findResourceClosestAvailablePlan'.xBaseUrl;

  @override
  String getCountriesPath = '/Pusula/getCountries'.xBaseUrl;

  @override
  String getEventsPath = '/Pusula/getevents'.xBaseUrl;

  @override
  String getLaboratoryResultsPath = '/Pusula/getLaboratoryResults'.xBaseUrl;

  @override
  String getVisitsPath = '/Pusula/getVisits'.xBaseUrl;

  @override
  String saveAppointmentPath = '/Pusula/saveAppointment'.xBaseUrl;

  @override
  String get updatePusulaContactInfoPath =>
      throw RbioUndefinedEndpointException("updatePusulaContactInfoPath");

  @override
  String cancelAppointmentPath = '/Pusula/cancelAppointment'.xBaseUrl;

  @override
  String checkOnlineAppointmentPaymentPath =
      '/pusula/checkOnlineAppointmentPayment'.xBaseUrl;

  @override
  String doMobilePaymentPath =
      '/Pusula/do-mobile-payment-without-firebase'.xBaseUrl;

  @override
  String doMobilePaymentWithVoucher =
      '/Pusula/do-mobile-payment-with-voucher'.xBaseUrl;

  @override
  String fetchOnlineDepartmentsPath = '/Pusula/getOnlineDepartments'.xBaseUrl;

  @override
  String getLaboratoryPdfResultPath =
      '/Pusula/getLaboratoryResultsPdf'.xBaseUrl;

  @override
  String getPathologyResultsPath = '/Pusula/getPathologyResults'.xBaseUrl;

  @override
  String getPatientAppointmentsPath = '/Pusula/getPatientAppointments'.xBaseUrl;

  @override
  String getRadiologyPdfResultPath = '/Pusula/getRadiologyResultsPdf'.xBaseUrl;

  @override
  String getRadiologyResultsPath = '/Pusula/getRadiologyResults'.xBaseUrl;

  @override
  String getResourceVideoCallPricePath =
      '/Pusula/getResourceVideoCallPrice'.xBaseUrl;

  @override
  String getResourceVideoCallPriceWithVoucher =
      '/Pusula/getResourceVideoCallPriceWithVoucher'.xBaseUrl;
}
