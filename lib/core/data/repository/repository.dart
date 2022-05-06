import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:onedosehealth/features/dashboard/home/model/banner_model.dart';

import '../../../features/auth/auth.dart';
import '../../../features/auth/model/change_password_exception.dart';
import '../../../features/auth/model/consent_form_model.dart';
import '../../../features/auth/model/forgot_password_exception.dart';
import '../../../features/auth/model/login_exception.dart';
import '../../../features/chat/model/chat_notification.dart';
import '../../../features/chat/model/get_chat_contacts_response.dart';
import '../../../features/take_appointment/create_appointment/model/available_dates.dart';
import '../../../features/take_appointment/create_appointment/model/find_resource_available_days_request.dart';
import '../../../features/take_appointment/create_appointment/model/voucher_price_request.dart';
import '../../../model/home/take_appointment/do_mobil_payment_voucher.dart';
import '../../../model/model.dart';
import '../../../model/user/synchronize_onedose_user_req.dart';
import '../../core.dart';

class Repository {
  final ApiService apiService;
  final LocalCacheService localCacheService;

  Repository({
    required this.apiService,
    required this.localCacheService,
  });

  Future<GuvenResponseModel> loginStarter(String username, String password) =>
      apiService.loginStarter(username, password);

  Future<GuvenResponseModel> verifyConfirmation2fa(
          String smsCode, int userId) =>
      apiService.verifyConfirmation2fa(smsCode, userId);

  Future<Either<GuvenResponseModel, LoginExceptions>> login(
    String username,
    String password,
  ) async {
    try {
      final response = await apiService.login(username, password);
      return left(response);
    } on RbioClientException catch (e) {
      final errorData = e.xGetModel<RbioLoginResponse>(RbioLoginResponse());
      if (errorData != null) {
        final httpStatusCode = errorData.ssoResponse?.httpStatusCode ?? 200;
        final errorDescription = errorData.ssoResponse?.errorDescription;
        if (httpStatusCode == 400 &&
            errorDescription == "Account is not fully set up") {
          return right(const LoginExceptions.accountNotFullySetUp());
        } else if (httpStatusCode == 400 &&
            errorDescription == "Account disabled") {
          return right(const LoginExceptions.accountDisabled());
        } else if (httpStatusCode == 401) {
          return right(const LoginExceptions.invalidUser());
        }
      }
    } on RbioServerException {
      return right(const LoginExceptions.serverError());
    } on RbioNetworkException {
      return right(const LoginExceptions.networkError());
    } catch (_) {
      return right(const LoginExceptions.undefined());
    }

    return right(const LoginExceptions.undefined());
  }

  Future<List<ForYouCategoryResponse>> getAllPackage() async {
    final url = getIt<IAppConfig>().endpoints.base.getAllPackagePath;
    return Utils.instance.getCacheApiCallList(
      url,
      () => apiService.getAllPackage(url),
      const Duration(days: 1),
      ForYouCategoryResponse(),
      localCacheService,
    );
  }

  Future<List<ForYouCategoryResponse>> getAllSubCategories(int id) async {
    final url = getIt<IAppConfig>().endpoints.base.getAllSubCategoriesPath(id);
    return Utils.instance.getCacheApiCallList(
      url,
      () => apiService.getAllSubCategories(url),
      const Duration(days: 1),
      ForYouCategoryResponse(),
      localCacheService,
    );
  }

  Future<List<GetChatContactsResponse>> getChatContacts() async {
    final response = await apiService.getChatContacts();
    if (response.xIsSuccessful) {
      if (response.datum == false) {
        return [];
      }

      return response.datum
          .map((item) => GetChatContactsResponse.fromJson(item))
          .cast<GetChatContactsResponse>()
          .toList();
    } else {
      return [];
    }
  }

  Future<List<ForYouSubCategoryDetailResponse>> getSubCategoryDetail(
      int id) async {
    final url = getIt<IAppConfig>().endpoints.base.getSubCategoryDetailPath(id);
    return await Utils.instance.getCacheApiCallList(
      url,
      () => apiService.getSubCategoryDetail(url),
      const Duration(days: 1),
      ForYouSubCategoryDetailResponse(),
      localCacheService,
    );
  }

  Future<GuvenResponseModel> addStep1(AddStep1Model addStep1Model) =>
      apiService.addStep1(addStep1Model);

  Future<GuvenResponseModel> addStep2(
          UserRegistrationStep2Model userRegistrationStep2) =>
      apiService.addStep2(userRegistrationStep2);

  Future<GuvenResponseModel> addStep3(
          UserRegistrationStep3Model userRegistrationStep3) =>
      apiService.addStep3(userRegistrationStep3);

  Future<List<ForYouSubCategoryItemsResponse>> getSubCategoryItems(String id) =>
      apiService.getSubCategoryItems(id);

  Future<String> doPackagePayment(PackagePaymentRequest packagePayment) =>
      apiService.doPackagePayment(packagePayment);

  Future<GuvenResponseModel> updateUserSystemName(String identityNumber) =>
      apiService.updateUserSystemName(identityNumber);

  Future<UserAccount> getUserProfile() => apiService.getUserProfile();

  Future<GuvenResponseModel> getResourceVideoCallPriceWithVoucher(
          VoucherPriceRequest voucherPriceRequest) =>
      apiService.getResourceVideoCallPriceVoucher(voucherPriceRequest);

  Future<Map<String, dynamic>> getActiveStream() =>
      apiService.getActiveStream();

  Future<String> getProfilePicture() => apiService.getProfilePicture();

  Future<ConsentForm> getConsentForm() => apiService.getConsentForm();

  Future<ApplicationVersionResponse> getCurrentApplicationVersion() =>
      apiService.getCurrentApplicationVersion();

  Future<PatientResponse?> getPatientDetail() async {
    final url = getIt<IAppConfig>().endpoints.base.getPatientDetailPath;
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
    final url = getIt<IAppConfig>().endpoints.base.filterTenantsPath;
    return await Utils.instance.getCacheApiCallList<FilterTenantsResponse>(
      url,
      () => apiService.filterTenants(url, filterTenantsRequest),
      const Duration(days: 10),
      FilterTenantsResponse(),
      localCacheService,
    );
  }

  Future<List<FilterDepartmentsResponse>> filterDepartments(
      FilterDepartmentsRequest filterDepartmentsRequest) async {
    final url = getIt<IAppConfig>().endpoints.base.filterDepartmentsPath;
    final bodyString = json.encode(filterDepartmentsRequest.toJson());
    return await Utils.instance.getCacheApiCallList<FilterDepartmentsResponse>(
      url + bodyString,
      () => apiService.filterDepartments(filterDepartmentsRequest),
      const Duration(days: 1),
      FilterDepartmentsResponse(),
      localCacheService,
      localeHandle: true,
    );
  }

  Future<List<FilterResourcesResponse>> filterResources(
      FilterResourcesRequest filterResourcesRequest) async {
    final url = getIt<IAppConfig>().endpoints.base.filterResourcesPath;
    final bodyString = json.encode(filterResourcesRequest.toJson());
    return await Utils.instance.getCacheApiCallList<FilterResourcesResponse>(
      url + bodyString,
      () => apiService.filterResources(filterResourcesRequest),
      const Duration(days: 1),
      FilterResourcesResponse(),
      localCacheService,
    );
  }

  Future<DoctorCvResponse> getDoctorCvDetails(String doctorWebID) async {
    final url = getIt<IAppConfig>()
        .endpoints
        .common
        .getDoctorCvDetailsPath(doctorWebID);
    return await Utils.instance.getCacheApiCallModel<DoctorCvResponse>(
      url,
      () => apiService.getDoctorCvDetails(doctorWebID),
      const Duration(days: 1),
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

  Future<Either<GuvenResponseModel, ForgotPasswordExceptions>> forgotPassword(
    UserRegistrationStep1Model userRegistrationStep1,
  ) async {
    try {
      final response = await apiService.forgotPassword(userRegistrationStep1);
      if (response.datum == true) {
        return left(response);
      } else {
        final responseError = response.xGetMap;
        if (responseError["error"] == R.apiEnums.forgotPassword.userNotFound) {
          return right(const ForgotPasswordExceptions.userNotFound());
        } else if (responseError["error"] ==
            R.apiEnums.forgotPassword.phoneNumberNotMatch) {
          return right(const ForgotPasswordExceptions.phoneNumberNotMatch());
        }
      }
    } catch (e) {
      return right(const ForgotPasswordExceptions.undefined());
    }

    return right(const ForgotPasswordExceptions.undefined());
  }

  Future<Either<GuvenResponseModel, ChangePasswordExceptions>> changePassword(
    ChangePasswordModel changePasswordModel,
  ) async {
    try {
      final response = await apiService.changePassword(changePasswordModel);
      if (response.datum == R.apiEnums.changePassword.success) {
        return left(response);
      } else if (response.datum == R.apiEnums.changePassword.oldError) {
        return right(const ChangePasswordExceptions.oldError());
      } else if (response.datum == R.apiEnums.changePassword.confirmError) {
        return right(const ChangePasswordExceptions.confirmError());
      } else if (response.datum == R.apiEnums.changePassword.systemError) {
        return right(const ChangePasswordExceptions.systemError());
      }
    } catch (e) {
      return right(const ChangePasswordExceptions.undefined());
    }

    return right(const ChangePasswordExceptions.undefined());
  }

  Future<GuvenResponseModel> updateContactInfo(
          ChangeContactInfoRequest changeContactInfo) =>
      apiService.updateContactInfo(changeContactInfo);
  Future<GuvenResponseModel> updatePusulaContactInfo(
          ChangeContactInfoRequest changeContactInfo) =>
      apiService.updatePusulaContactInfo(changeContactInfo);
  Future<GuvenResponseModel> changeUserPasswordUi(
          String oldPassword, String password) =>
      apiService.changeUserPasswordUi(oldPassword, password);

  Future<GuvenResponseModel> addFirebaseTokenUi(
          AddFirebaseTokenRequest addFirebaseToken) =>
      apiService.addFirebaseTokenUi(addFirebaseToken);

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

  Future<GuvenResponseModel> synchronizeOneDoseUser(
          SynchronizeOneDoseUserRequest synchronizeOneDoseUserRequest) =>
      apiService.synchronizeOneDoseUser(synchronizeOneDoseUserRequest);

  Future<GuvenResponseModel> doMobilePayment(
          DoMobilePaymentRequest doMobilePaymentRequest) =>
      apiService.doMobilePayment(doMobilePaymentRequest);

  Future<GuvenResponseModel> doMobilePaymentWithVoucher(
          DoMobilePaymentWithVoucherRequest
              doMobilePaymentWithVoucherRequest) =>
      apiService.doMobilePaymentWithVoucher(doMobilePaymentWithVoucherRequest);

  Future<List<FilterDepartmentsResponse>> fetchOnlineDepartments(
      FilterOnlineDepartmentsRequest filterOnlineDepartmentsRequest) async {
    final url = getIt<IAppConfig>().endpoints.base.fetchOnlineDepartmentsPath;
    return await Utils.instance.getCacheApiCallList<FilterDepartmentsResponse>(
      url,
      () => apiService.fetchOnlineDepartments(filterOnlineDepartmentsRequest),
      const Duration(days: 1),
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

  // #region Search
  Future<List<SocialPostsResponse>> getAllSocialResources() async {
    final url = getIt<IAppConfig>().endpoints.search.getAllPosts;
    final response =
        await Utils.instance.getCacheApiCallModel<GuvenResponseModel>(
      url,
      () => apiService.socialResource(),
      const Duration(days: 1),
      GuvenResponseModel(),
      localCacheService,
    );
    final allSocialResources = <SocialPostsResponse>[];
    final datum = response.datum;
    for (final data in datum) {
      final allSocialPostsResponse =
          SocialPostsResponse.fromJson(data as Map<String, dynamic>);
      allSocialResources.add(allSocialPostsResponse);
    }
    return allSocialResources;
  }

  Future<List<SocialPostsResponse>> getPostWithTagsByPlatform(
    String text,
  ) async {
    final response = await apiService.getPostWithTagsByPlatform(text);
    final filteredSocialResources = <SocialPostsResponse>[];
    final datum = response.datum;
    for (final data in datum) {
      final filteredSocialResponse =
          SocialPostsResponse.fromJson(data as Map<String, dynamic>);
      filteredSocialResources.add(filteredSocialResponse);
    }
    filteredSocialResources.sort(
        (a, b) => a.title!.toLowerCase().compareTo(b.title!.toLowerCase()));
    return filteredSocialResources;
  }

  Future<List<SocialPostsResponse>> getSocialPostWithTagsByText(
    String text,
  ) async {
    final response = await apiService.getPostWithTagsByText(text);
    final filteredSocialResources = <SocialPostsResponse>[];
    final datum = response.datum;
    for (final data in datum) {
      final filteredSocialResponse =
          SocialPostsResponse.fromJson(data as Map<String, dynamic>);
      filteredSocialResources.add(filteredSocialResponse);
    }
    return filteredSocialResources;
  }
  // #endregion
}
