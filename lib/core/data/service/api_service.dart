import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import 'package:onedosehealth/features/dashboard/home/model/banner_model.dart';
import '../../../features/auth/auth.dart';
import '../../../features/auth/model/consent_form_model.dart';
import '../../../features/chat/model/chat_notification.dart';
import '../../../features/take_appointment/create_appointment/model/available_dates.dart';
import '../../../features/take_appointment/create_appointment/model/find_resource_available_days_request.dart';
import '../../../features/take_appointment/create_appointment/model/voucher_price_request.dart';
import '../../../model/home/take_appointment/do_mobil_payment_voucher.dart';
import '../../../model/model.dart';
import '../../../model/user/synchronize_onedose_user_req.dart';
import '../../core.dart';

part 'api_service_impl.dart';

abstract class ApiService {
  final IDioHelper helper;
  ApiService(this.helper);

  Future<GuvenResponseModel> loginStarter(String username, String password);
  Future<GuvenResponseModel> verifyConfirmation2fa(String smsCode, int userId);
  Future<GuvenResponseModel> login(String username, String password);

  // for_you_services.dart
  Future<List<ForYouCategoryResponse>> getAllPackage(String path);
  Future<List<ForYouCategoryResponse>> getAllSubCategories(String path);
  Future<List<ForYouSubCategoryDetailResponse>> getSubCategoryDetail(
      String path);
  Future<List<ForYouSubCategoryItemsResponse>> getSubCategoryItems(String id);
  Future<String> doPackagePayment(PackagePaymentRequest packagePayment);

  Future<GuvenResponseModel> addStep1(AddStep1Model addStep1Model);
  Future<GuvenResponseModel> addStep2(
      UserRegistrationStep2Model userRegistrationStep2);
  Future<GuvenResponseModel> addStep3(
      UserRegistrationStep3Model userRegistrationStep3);

  Future<GuvenResponseModel> updateUserSystemName(String identityNumber);
  Future<UserAccount> getUserProfile();
  Future<Map<String, dynamic>> getActiveStream();
  Future<String> getProfilePicture();
  Future<ConsentForm> getConsentForm();
  Future<ApplicationVersionResponse> getCurrentApplicationVersion();
  Future<PatientResponse?> getPatientDetail(String url);
  Future<List<BannerTabsModel>> getBannerTab(
      String applicationName, String groupName);
  //
  Future<List<FilterTenantsResponse>> filterTenants(
    String path,
    FilterTenantsRequest filterTenantsRequest,
  );
  Future<List<FilterDepartmentsResponse>> filterDepartments(
    FilterDepartmentsRequest filterDepartmentsRequest,
  );
  Future<List<FilterResourcesResponse>> filterResources(
    FilterResourcesRequest filterResourcesRequest,
  );
  Future<DoctorCvResponse> getDoctorCvDetails(String doctorWebID);
  Future<List<GetEventsResponse>> getEvents(GetEventsRequest getEventsRequest);
  Future<List<GetEventsResponse>> findResourceClosestAvailablePlan(
    ResourceForAvailablePlanRequest resourceForAvailablePlanRequest,
  );
  Future<int> saveAppointment(AppointmentRequest appointmentRequest);
  Future<List<AvailableDate>> findResourceAvailableDays(
    FindResourceAvailableDaysRequest findResourceAvailableDaysRequest,
  );
  //
  Future<PatientRelativeInfoResponse> getAllRelatives(
    GetAllRelativesRequest bodyPages,
  );
  Future<GuvenResponseModel> getCountries();
  Future<GuvenResponseModel> forgotPassword(
    UserRegistrationStep1Model userRegistrationStep1,
  );
  Future<GuvenResponseModel> synchronizeOneDoseUser(
      SynchronizeOneDoseUserRequest synchronizeOnedoseUserRequest);
  Future<GuvenResponseModel> changePassword(
      ChangePasswordModel changePasswordModel);
  Future<GuvenResponseModel> updateContactInfo(
      ChangeContactInfoRequest changeContactInfo);
  Future<GuvenResponseModel> updatePusulaContactInfo(
      ChangeContactInfoRequest changeContactInfo);
  Future<GuvenResponseModel> changeUserPasswordUi(
      String oldPassword, String password);
  Future<GuvenResponseModel> addFirebaseTokenUi(
      AddFirebaseTokenRequest addFirebaseToken);
  Future<GuvenResponseModel> sendNotification(ChatNotificationModel model);

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
  Future<GuvenResponseModel> getChatContacts();

  Future<GuvenResponseModel> downloadAppointmentFile(String id, String name);
  Future<GuvenResponseModel> removePatientRelative(String id);
  Future<GuvenResponseModel> getRelativeRelationships();
  Future<GuvenResponseModel> changeActiveUserToRelative(String id);
  Future<GuvenResponseModel> clickPost(int postId);
  Future<GuvenResponseModel> socialResource();
  Future<GuvenResponseModel> getAppointmentTypeViaWebConsultantId();
  Future<GuvenResponseModel> requestTranslator(
      String appoId, TranslatorRequest translatorPost);
  Future<GuvenResponseModel> uploadFileToAppo(String webAppoId, File file);

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
  Future<GuvenResponseModel> doMobilePaymentWithVoucher(
      DoMobilePaymentWithVoucherRequest doMobilePaymentWithVoucherRequest);
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

  Future<GuvenResponseModel> getResourceVideoCallPriceVoucher(
      VoucherPriceRequest voucherPriceRequest);

  Future<GuvenResponseModel> getPostWithTagsByText(String search);
  Future<GuvenResponseModel> getPostWithTagsByPlatform(String search);
}
