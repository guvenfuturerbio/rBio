import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:onedosehealth/features/chat/model/chat_notification.dart';
import 'package:onedosehealth/features/chat/model/get_chat_contacts_response.dart';

import '../../../features/auth/auth.dart';
import '../../../features/home/model/banner_model.dart';
import '../../../features/take_appointment/create_appointment/model/available_dates.dart';
import '../../../features/take_appointment/create_appointment/model/find_resource_available_days_request.dart';
import '../../../features/take_appointment/create_appointment/model/voucher_price_request.dart';
import '../../../model/home/take_appointment/do_mobil_payment_voucher.dart';
import '../../../model/model.dart';
import '../../core.dart';

class Repository {
  final ApiService apiService;
  final LocalCacheService localCacheService;

  Repository({
    @required this.apiService,
    @required this.localCacheService,
  });

  Future<RbioLoginResponse> login(String username, String password) =>
      apiService.login(username, password);

  Future<List<ForYouCategoryResponse>> getAllPackage() async {
    final url = R.endpoints.getAllPackagePath;
    return await Utils.instance.getCacheApiCallList(
      url,
      () => apiService.getAllPackage(url),
      Duration(days: 1),
      ForYouCategoryResponse(),
      localCacheService,
    );
  }

  Future<List<ForYouCategoryResponse>> getAllSubCategories(int id) async {
    final url = R.endpoints.getAllSubCategoriesPath(id);
    return await Utils.instance.getCacheApiCallList(
      url,
      () => apiService.getAllSubCategories(url),
      Duration(days: 1),
      ForYouCategoryResponse(),
      localCacheService,
    );
  }

  Future<List<GetChatContactsResponse>> getChatContacts() async {
    final response = await apiService.getChatContacts();
    return response.datum
        .map((item) => GetChatContactsResponse.fromJson(item))
        .cast<GetChatContactsResponse>()
        .toList();
  }

  Future<List<ForYouSubCategoryDetailResponse>> getSubCategoryDetail(
      int id) async {
    final url = R.endpoints.getSubCategoryDetailPath(id);
    return await Utils.instance.getCacheApiCallList(
      url,
      () => apiService.getSubCategoryDetail(url),
      Duration(days: 1),
      ForYouSubCategoryDetailResponse(),
      localCacheService,
    );
  }

  Future<List<ForYouSubCategoryItemsResponse>> getSubCategoryItems(String id) =>
      apiService.getSubCategoryItems(id);

  Future<String> doPackagePayment(PackagePaymentRequest packagePayment) =>
      apiService.doPackagePayment(packagePayment);

  Future<GuvenResponseModel> registerStep2Ui(
          UserRegistrationStep2Model userRegistrationStep2) =>
      apiService.registerStep2Ui(userRegistrationStep2);

  Future<GuvenResponseModel> registerStep2WithOutTc(
          UserRegistrationStep2Model userRegistrationStep2) =>
      apiService.registerStep2WithOutTc(userRegistrationStep2);

  Future<GuvenResponseModel> registerStep3Ui(
          UserRegistrationStep3Model userRegistrationStep3) =>
      apiService.registerStep3Ui(userRegistrationStep3);

  Future<GuvenResponseModel> registerStep3WithOutTc(
          UserRegistrationStep3Model userRegistrationStep3) =>
      apiService.registerStep3WithOutTc(userRegistrationStep3);

  Future<GuvenResponseModel> updateUserSystemName(String identityNumber) =>
      apiService.updateUserSystemName(identityNumber);

  Future<UserAccount> getUserProfile() => apiService.getUserProfile();

  Future<GuvenResponseModel> getResourceVideoCallPriceWithVoucher(
          VoucherPriceRequest voucherPriceRequest) =>
      apiService.getResourceVideoCallPriceVoucher(voucherPriceRequest);

  Future<Map<String, dynamic>> getActiveStream() =>
      apiService.getActiveStream();

  Future<String> getProfilePicture() => apiService.getProfilePicture();

  Future<ApplicationVersionResponse> getCurrentApplicationVersion() =>
      apiService.getCurrentApplicationVersion();

  Future<PatientResponse> getPatientDetail() async {
    final url = R.endpoints.getPatientDetailPath;
    final response = await apiService.getPatientDetail(url);
    return response;
  }

  Future<GuvenResponseModel> sendNotification(
      ChatNotificationModel model) async {
    final response = await apiService.sendNotification(model);
    return response;
  }

  Future<List<FilterTenantsResponse>> filterTenants(
      FilterTenantsRequest filterTenantsRequest) async {
    final url = R.endpoints.filterTenantsPath;
    return await Utils.instance.getCacheApiCallList<FilterTenantsResponse>(
      url,
      () => apiService.filterTenants(url, filterTenantsRequest),
      Duration(days: 10),
      FilterTenantsResponse(),
      localCacheService,
    );
  }

  Future<List<FilterDepartmentsResponse>> filterDepartments(
      FilterDepartmentsRequest filterDepartmentsRequest) async {
    final url = R.endpoints.filterDepartmentsPath;
    final bodyString = json.encode(filterDepartmentsRequest.toJson());
    return await Utils.instance.getCacheApiCallList<FilterDepartmentsResponse>(
      url + bodyString,
      () => apiService.filterDepartments(filterDepartmentsRequest),
      Duration(days: 1),
      FilterDepartmentsResponse(),
      localCacheService,
      localeHandle: true,
    );
  }

  Future<List<FilterResourcesResponse>> filterResources(
      FilterResourcesRequest filterResourcesRequest) async {
    final url = R.endpoints.filterResourcesPath;
    final bodyString = json.encode(filterResourcesRequest.toJson());
    return await Utils.instance.getCacheApiCallList<FilterResourcesResponse>(
      url + bodyString,
      () => apiService.filterResources(filterResourcesRequest),
      Duration(days: 1),
      FilterResourcesResponse(),
      localCacheService,
    );
  }

  Future<DoctorCvResponse> getDoctorCvDetails(String doctorWebID) async {
    final url = R.endpoints.getDoctorCvDetailsPath(doctorWebID);
    return await Utils.instance.getCacheApiCallModel<DoctorCvResponse>(
      url,
      () => apiService.getDoctorCvDetails(doctorWebID),
      Duration(days: 1),
      DoctorCvResponse(),
      localCacheService,
    );
  }

  Future<List<GetEventsResponse>> getEvents(
          GetEventsRequest getEventsRequest) =>
      apiService.getEvents(getEventsRequest);

  Future<List<GetEventsResponse>> findResourceClosestAvailablePlan(
          ResourceForAvailablePlanRequest resourceForAvailablePlanRequest) =>
      apiService
          .findResourceClosestAvailablePlan(resourceForAvailablePlanRequest);

  Future<int> saveAppointment(AppointmentRequest appointmentRequest) =>
      apiService.saveAppointment(appointmentRequest);

  Future<PatientRelativeInfoResponse> getAllRelatives(
          GetAllRelativesRequest bodyPages) =>
      apiService.getAllRelatives(bodyPages);
  Future<List<BannerTabsModel>> getBannerTab(
          String applicationName, String groupName) =>
      apiService.getBannerTab(applicationName, groupName);
  Future<GuvenResponseModel> getCountries() => apiService.getCountries();

  Future<GuvenResponseModel> forgotPasswordUi(
          UserRegistrationStep1Model userRegistrationStep1) =>
      apiService.forgotPasswordUi(userRegistrationStep1);

  Future<GuvenResponseModel> changePasswordUi(
          ChangePasswordModel changePasswordModel) =>
      apiService.changePasswordUi(changePasswordModel);

  Future<GuvenResponseModel> updateContactInfo(
          ChangeContactInfoRequest changeContactInfo) =>
      apiService.updateContactInfo(changeContactInfo);

  Future<GuvenResponseModel> changeUserPasswordUi(
          String oldPassword, String password) =>
      apiService.changeUserPasswordUi(oldPassword, password);

  Future<GuvenResponseModel> addFirebaseTokenUi(
          AddFirebaseTokenRequest addFirebaseToken) =>
      apiService.addFirebaseTokenUi(addFirebaseToken);

  Future<GuvenResponseModel> patientCallMeUi() => apiService.patientCallMeUi();

  Future<GuvenResponseModel> getRoomStatusUi(String roomId) =>
      apiService.getRoomStatusUi(roomId);

  Future<GuvenResponseModel> getOnlineAppoFiles(String roomId) =>
      apiService.getOnlineAppoFiles(roomId);

  Future<GuvenResponseModel> deleteOnlineAppoFile(
          String webAppoId, String fileName) =>
      apiService.deleteOnlineAppoFile(webAppoId, fileName);

  Future<GuvenResponseModel> getAllTranslator() =>
      apiService.getAllTranslator();

  Future<GuvenResponseModel> getUserKvkkInfo() => apiService.getUserKvkkInfo();

  Future<GuvenResponseModel> updateUserKvkkInfo() =>
      apiService.updateUserKvkkInfo();

  Future<GuvenResponseModel> addSuggestion(
          SuggestionRequest suggestionRequest) =>
      apiService.addSuggestion(suggestionRequest);

  Future<GuvenResponseModel> setYoutubeSurveyUser(
          YoutubeSurveyUserRequest bodyPages) =>
      apiService.setYoutubeSurveyUser(bodyPages);

  Future<GuvenResponseModel> getCourseId() => apiService.getCourseId();

  Future<GuvenResponseModel> setJitsiWebConsultantId(String id) =>
      apiService.setJitsiWebConsultantId(id);

  Future<GuvenResponseModel> deleteProfilePicture() =>
      apiService.deleteProfilePicture();

  Future<GuvenResponseModel> uploadProfilePicture(File file) =>
      apiService.uploadProfilePicture(file);

  Future<GuvenResponseModel> downloadAppointmentSingleFile(
          String folder, String path) =>
      apiService.downloadAppointmentSingleFile(folder, path);

  Future<GuvenResponseModel> getAllFiles() => apiService.getAllFiles();

  Future<GuvenResponseModel> downloadAppointmentFile(String id, String name) =>
      apiService.downloadAppointmentFile(id, name);

  Future<GuvenResponseModel> removePatientRelative(String id) =>
      apiService.removePatientRelative(id);

  Future<GuvenResponseModel> getRelativeRelationships() =>
      apiService.getRelativeRelationships();

  Future<GuvenResponseModel> changeActiveUserToRelative(String id) =>
      apiService.changeActiveUserToRelative(id);

  Future<GuvenResponseModel> clickPost(int postId) =>
      apiService.clickPost(postId);

  Future<GuvenResponseModel> filterSocialPosts(String search) =>
      apiService.filterSocialPosts(search);

  Future<GuvenResponseModel> socialResource() async {
    final url = R.endpoints.socialResourcePath;
    return await Utils.instance.getCacheApiCallModel<GuvenResponseModel>(
      url,
      () => apiService.socialResource(),
      Duration(days: 1),
      GuvenResponseModel(),
      localCacheService,
    );
  }

  Future<List<AvailableDate>> findResourceAvailableDays(
          FindResourceAvailableDaysRequest request) =>
      apiService.findResourceAvailableDays(request);
  Future<GuvenResponseModel> getAppointmentTypeViaWebConsultantId() =>
      apiService.getAppointmentTypeViaWebConsultantId();

  Future<GuvenResponseModel> requestTranslator(
          String appoId, TranslatorRequest translatorPost) =>
      apiService.requestTranslator(appoId, translatorPost);

  Future<GuvenResponseModel> uploadFileToAppo(String webAppoId, File file) =>
      apiService.uploadFileToAppo(webAppoId, file);

  Future<GuvenResponseModel> registerStep1Ui(
          RegisterStep1PusulaModel userRegistrationStep1) =>
      apiService.registerStep1Ui(userRegistrationStep1);

  Future<GuvenResponseModel> registerStep1WithOutTc(
          UserRegistrationStep1Model userRegistrationStep1) =>
      apiService.registerStep1WithOutTc(userRegistrationStep1);

  Future<List<VisitResponse>> getVisits(VisitRequest visitRequestBody) =>
      apiService.getVisits(visitRequestBody);

  Future<List<LaboratoryResponse>> getLaboratoryResults(
          VisitDetailRequest detailRequest) =>
      apiService.getLaboratoryResults(detailRequest);

  Future<GuvenResponseModel> rateOnlineCall(CallRateRequest callRateRequest) =>
      apiService.rateOnlineCall(callRateRequest);

  Future<List<RadiologyResponse>> getRadiologyResults(
          VisitDetailRequest detailRequest) =>
      apiService.getRadiologyResults(detailRequest);

  Future<List<PathologyResponse>> getPathologyResults(
          VisitDetailRequest detailRequest) =>
      apiService.getPathologyResults(detailRequest);

  Future<String> getLaboratoryPdfResult(
          LaboratoryPdfResultRequest laboratoryPdfResultRequest) =>
      apiService.getLaboratoryPdfResult(laboratoryPdfResultRequest);

  Future<String> getRadiologyPdfResult(
          RadiologyPdfRequest radiologyPdfResultRequest) =>
      apiService.getRadiologyPdfResult(radiologyPdfResultRequest);

  Future<List<PatientAppointmentsResponse>> getPatientAppointments(
          PatientAppointmentRequest patientAppointmentRequest) =>
      apiService.getPatientAppointments(patientAppointmentRequest);

  Future<bool> cancelAppointment(
          CancelAppointmentRequest cancelAppointmentRequest) =>
      apiService.cancelAppointment(cancelAppointmentRequest);

  Future<GetVideoCallPriceResponse> getResourceVideoCallPrice(
          GetVideoCallPriceRequest getVideoCallPriceRequest) =>
      apiService.getResourceVideoCallPrice(getVideoCallPriceRequest);

  Future<GuvenResponseModel> doMobilePayment(
          DoMobilePaymentRequest doMobilePaymentRequest) =>
      apiService.doMobilePayment(doMobilePaymentRequest);

  Future<GuvenResponseModel> doMobilePaymentWithVoucher(
          DoMobilePaymentWithVoucherRequest
              doMobilePaymentWithVoucherRequest) =>
      apiService.doMobilePaymentWithVoucher(doMobilePaymentWithVoucherRequest);

  Future<List<FilterDepartmentsResponse>> fetchOnlineDepartments(
      FilterOnlineDepartmentsRequest filterOnlineDepartmentsRequest) async {
    final url = R.endpoints.fetchOnlineDepartmentsPath;
    return await Utils.instance.getCacheApiCallList<FilterDepartmentsResponse>(
      url,
      () => apiService.fetchOnlineDepartments(filterOnlineDepartmentsRequest),
      Duration(days: 1),
      FilterDepartmentsResponse(),
      localCacheService,
      localeHandle: true,
    );
  }

  Future<GuvenResponseModel> checkOnlineAppointmentPayment(
          CheckPaymentRequest request) =>
      apiService.checkOnlineAppointmentPayment(request);

  Future<GetAvailabilityRateResponse> getAvailabilityRate(
          GetAvailabilityRateRequest getAvailabilityRateRequest) =>
      apiService.getAvailabilityRate(getAvailabilityRateRequest);

  Future<GuvenResponseModel> addNewPatientRelative(
          AddPatientRelativeRequest addPatientRelative) =>
      apiService.addNewPatientRelative(addPatientRelative);

  Future<GuvenResponseModel> uploadPatientDocuments(
          String webAppoId, Uint8List file) =>
      apiService.uploadPatientDocuments(webAppoId, file);
}
