import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../../../model/model.dart';
import '../../core.dart';

part 'api_service_impl.dart';

abstract class ApiService {
  final IDioHelper helper;
  ApiService(this.helper);

  Future<GuvenLogin> login(String clientId, String grantType,
      String clientSecret, String scope, String username, String password);

  // for_you_services.dart
  Future<List<ForYouCategoryResponse>> getAllPackage(String path);
  Future<List<ForYouCategoryResponse>> getAllSubCategories(var id);
  Future<List<ForYouSubCategoryDetailResponse>> getSubCategoryDetail(var id);
  Future<List<ForYouSubCategoryItemsResponse>> getSubCategoryItems(var id);
  Future<String> doPackagePayment(PackagePaymentRequest packagePayment);

  Future<GuvenResponseModel> registerStep2Ui(
      UserRegistrationStep2Model userRegistrationStep2);
  Future<GuvenResponseModel> registerStep2WithOutTc(
      UserRegistrationStep2Model userRegistrationStep2);
  Future<GuvenResponseModel> registerStep3Ui(
      UserRegistrationStep3Model userRegistrationStep3);
  Future<GuvenResponseModel> registerStep3WithOutTc(
      UserRegistrationStep3Model userRegistrationStep3);
  Future<GuvenResponseModel> updateUserSystemName(String identityNumber);
  Future<UserAccount> getUserProfile();
  Future<Map<String, dynamic>> getActiveStream();
  Future<String> getProfilePicture();
  Future<ApplicationVersionResponse> getCurrentApplicationVersion();
  Future<PatientResponse> getPatientDetail(String url);

  //
  Future<List<FilterTenantsResponse>> filterTenants(
      FilterTenantsRequest filterTenantsRequest);
  Future<List<FilterDepartmentsResponse>> filterDepartments(
      FilterDepartmentsRequest filterDepartmentsRequest);
  Future<List<FilterResourcesResponse>> filterResources(
      FilterResourcesRequest filterResourcesRequest);
  Future<DoctorCvResponse> getDoctorCvDetails(String doctorWebID);
  Future<List<GetEventsResponse>> getEvents(GetEventsRequest getEventsRequest);
  Future<List<GetEventsResponse>> findResourceClosestAvailablePlan(
      ResourceForAvailablePlanRequest resourceForAvailablePlanRequest);
  Future<int> saveAppointment(AppointmentRequest appointmentRequest);

  //
  Future<PatientRelativeInfoResponse> getAllRelatives(GetAllRelativesRequest bodyPages);
  Future<GuvenResponseModel> getCountries();
  Future<GuvenResponseModel> forgotPasswordUi(
      UserRegistrationStep1Model userRegistrationStep1);
  Future<GuvenResponseModel> changePasswordUi(
      ChangePasswordModel changePasswordModel);
  Future<GuvenResponseModel> updateContactInfo(
      ChangeContactInfoRequest changeContactInfo);
  Future<GuvenResponseModel> changeUserPasswordUi(
      String oldPassword, String password);
  Future<GuvenResponseModel> addFirebaseTokenUi(
      AddFirebaseTokenRequest addFirebaseToken);
  Future<GuvenResponseModel> patientCallMeUi();
  Future<GuvenResponseModel> getRoomStatusUi(String roomId);
  Future<GuvenResponseModel> getOnlineAppoFiles(String roomId);
  Future<GuvenResponseModel> deleteOnlineAppoFile(
      String webAppoId, String fileName);
  Future<GuvenResponseModel> getAllTranslator();
  Future<GuvenResponseModel> getUserKvkkInfo();
  Future<GuvenResponseModel> updateUserKvkkInfo();
  Future<GuvenResponseModel> addSuggestion(SuggestionRequest suggestionRequest);
  Future<GuvenResponseModel> setYoutubeSurveyUser(
      YoutubeSurveyUserRequest bodyPages);
  Future<GuvenResponseModel> getCourseId();
  Future<GuvenResponseModel> setJitsiWebConsultantId(String webConsultantId);
  Future<GuvenResponseModel> deleteProfilePicture();
  Future<GuvenResponseModel> uploadProfilePicture(File file);
  Future<GuvenResponseModel> downloadAppointmentSingleFile(
      String folder, String path);
  Future<GuvenResponseModel> getAllFiles();
  Future<GuvenResponseModel> downloadAppointmentFile(String id, String name);
  Future<GuvenResponseModel> removePatientRelative(String id);
  Future<GuvenResponseModel> getRelativeRelationships();
  Future<GuvenResponseModel> changeActiveUserToRelative(String id);
  Future<GuvenResponseModel> clickPost(int postId);
  Future<GuvenResponseModel> filterSocialPosts(String search);
  Future<GuvenResponseModel> socialResource();
  Future<GuvenResponseModel> getAppointmentTypeViaWebConsultantId();
  Future<GuvenResponseModel> requestTranslator(
      String appoId, TranslatorRequest translatorPost);
  Future<GuvenResponseModel> uploadFileToAppo(String webAppoId, File file);

  Future<GuvenResponseModel> registerStep1Ui(
      RegisterStep1PusulaModel userRegistrationStep1);
  Future<GuvenResponseModel> registerStep1WithOutTc(
      UserRegistrationStep1Model userRegistrationStep1);
  Future<List<VisitResponse>> getVisits(VisitRequest visitRequestBody);
  Future<List<LaboratoryResponse>> getLaboratoryResults(
      VisitDetailRequest detailRequest);
  Future<GuvenResponseModel> rateOnlineCall(CallRateRequest callRateRequest);
  Future<List<RadiologyResponse>> getRadiologyResults(
      VisitDetailRequest detailRequest);
  Future<List<PathologyResponse>> getPathologyResults(
      VisitDetailRequest detailRequest);
  Future<String> getLaboratoryPdfResult(
      LaboratoryPdfResultRequest laboratoryPdfResultRequest);
  Future<String> getRadiologyPdfResult(
      RadiologyPdfRequest radiologyPdfResultRequest);
  Future<List<PatientAppointmentsResponse>> getPatientAppointments(
      PatientAppointmentRequest patientAppointmentRequest);
  Future<bool> cancelAppointment(
      CancelAppointmentRequest cancelAppointmentRequest);
  Future<GetVideoCallPriceResponse> getResourceVideoCallPrice(
      GetVideoCallPriceRequest getVideoCallPriceRequest);
  Future<GuvenResponseModel> doMobilePayment(
      DoMobilePaymentRequest doMobilePaymentRequest);
  Future<List<FilterDepartmentsResponse>> fetchOnlineDepartments(
      FilterOnlineDepartmentsRequest filterOnlineDepartmentsRequest);
  Future<GuvenResponseModel> checkOnlineAppointmentPayment(
      CheckPaymentRequest request);
  Future<GetAvailabilityRateResponse> getAvailabilityRate(
      GetAvailabilityRateRequest getAvailabilityRateRequest);
  Future<GuvenResponseModel> addNewPatientRelative(
      AddPatientRelativeRequest addPatientRelative);
  Future<GuvenResponseModel> uploadPatientDocuments(
      String webAppoId, Uint8List file);
}
