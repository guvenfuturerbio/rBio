part of 'api_service.dart';

class ApiServiceImpl extends ApiService {
  @override
  final IDioHelper helper;
  final IAppEndpoints endpoints;
  ApiServiceImpl(this.helper, this.endpoints) : super(helper);

  String? get getToken => getIt<ISharedPreferencesManager>()
      .getString(SharedPreferencesKeys.jwtToken);
  Options get authOptions => Options(
        headers: {'Authorization': getToken, 'Lang': Intl.getCurrentLocale()},
      );
  Options get emptyAuthOptions =>
      Options(headers: {'Authorization': "", 'Lang': Intl.getCurrentLocale()});
  Map<String, dynamic> get getCourseHeader => {
        'mobileapiauthkey':
            'b776be7e007b40d38f1f4b73bb53481cf946c0d21c5b4ad7a0842bc1be2b70ce'
      };
  Map<String, dynamic> get utcHeader => <String, dynamic>{
        'utc': DateTime.now().toLocal().timeZoneOffset,
      };

  @override
  Future<GuvenResponseModel> addStep1(AddStep1Model addStep1Model) async {
    final response = await helper.postGuven(
      endpoints.devApi.addStep1,
      addStep1Model.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.devApi.addStep1,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> addStep2(
    UserRegistrationStep2Model userRegistrationStep2,
  ) async {
    final response = await helper.postGuven(
      endpoints.devApi.addStep2,
      userRegistrationStep2.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.devApi.addStep2,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> addStep3(
    UserRegistrationStep3Model userRegistrationStep3,
  ) async {
    final response = await helper.postGuven(
      endpoints.devApi.addStep3,
      userRegistrationStep3.toJson(),
      options: authOptions,
    );
    return response;
  }

  @override
  Future<GuvenResponseModel> loginStarter(
    String username,
    String password,
  ) async {
    final response = await helper.dioPost(
      endpoints.base.userLoginStarter,
      [],
      queryParameters: <String, dynamic>{
        'userName': username,
        'password': password
      },
      options: emptyAuthOptions,
    );
    return GuvenResponseModel.fromJson(response);
  }

  @override
  Future<GuvenResponseModel> verifyConfirmation2fa(
    String smsCode,
    int userId,
  ) async {
    final response = await helper.dioPost(
      endpoints.base.verifyConfirmation2fa,
      [],
      queryParameters: <String, dynamic>{
        'pSmsCode': smsCode,
        'pUserId': userId
      },
      options: emptyAuthOptions,
    );
    return GuvenResponseModel.fromJson(response);
  }

  @override
  Future<GuvenResponseModel> login(
      String username, String password, String consentId) async {
    final response = await helper.postGuven(
      endpoints.devApi.loginPath,
      <String, dynamic>{},
      queryParameters: {
        'userName': username,
        'password': password,
        'ConsentId': consentId,
      },
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.devApi.loginPath,
        response,
      );
    }
  }

  @override
  Future<List<ForYouCategoryResponse>> getAllPackage(String path) async {
    final response = await helper.getGuven(
      path,
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      final result = response.xGetMapList
          .map((item) => ForYouCategoryResponse.fromJson(item))
          .cast<ForYouCategoryResponse>()
          .toList();
      return result;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        path,
        response,
      );
    }
  }

  @override
  Future<List<ForYouCategoryResponse>> getAllSubCategories(String path) async {
    final response = await helper.getGuven(path, options: authOptions);
    if (response.xIsSuccessful) {
      final result = response.xGetMapList
          .map((item) => ForYouCategoryResponse.fromJson(item))
          .cast<ForYouCategoryResponse>()
          .toList();
      return result;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        path,
        response,
      );
    }
  }

  @override
  Future<List<ForYouSubCategoryDetailResponse>> getSubCategoryDetail(
    String path,
  ) async {
    final response = await helper.getGuven(path, options: authOptions);
    if (response.xIsSuccessful) {
      final result = response.xGetMapList
          .map((item) => ForYouSubCategoryDetailResponse.fromJson(item))
          .cast<ForYouSubCategoryDetailResponse>()
          .toList();
      return result;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        path,
        response,
      );
    }
  }

  @override
  Future<List<ForYouSubCategoryItemsResponse>> getSubCategoryItems(
    String id,
  ) async {
    final response = await helper.getGuven(
      endpoints.base.getSubCategoryItemsPath(id),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      final result = response.xGetMapList
          .map((item) => ForYouSubCategoryItemsResponse.fromJson(item))
          .cast<ForYouSubCategoryItemsResponse>()
          .toList();
      return result;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.getSubCategoryItemsPath(id),
        response,
      );
    }
  }

  @override
  Future<String> doPackagePayment(PackagePaymentRequest packagePayment) async {
    //return "\r\n\r\n<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\r\n<head id=\"Head1\"><title>\r\n\tPayment MPI Service\r\n</title></head>\r\n<body>\r\n    <form method=\"post\" action=\"https://goguvenliodeme.bkm.com.tr/troy/approve\" id=\"step1Form\">\r\n<div class=\"aspNetHidden\">\r\n<input type=\"hidden\" name=\"goreq\" id=\"goreq\" value=\"eyJpZCI6IjAxMTEyOWVkYjA2Ni1iMzM1LTQ5ZjMtYTUxOS1hYTNkMzNmMzlmZjYiLCJ0aW1lIjoiMjAyMTAzMDYxMzI2MjUiLCJ2ZXJzaW9uIjoiMC4wMyIsImV4cGlyeSI6IjI0MTAiLCJnb1N0YW1wIjoiZXlKaGJHY2lPaUpJVXpVeE1pSjkuZXlKemRXSWlPaUl3T1RFM01EQXdNREF3TVRVME1EUWlMQ0owYVcxbGIzVjBVMlZqYjI1a2N5STZORE15TURBd01EQXNJbkp2YkdWeklqb2lJaXdpWlhod0lqb3hOalU0TWpJMk16ZzFmUS5FUEJMeXpTclpTaHh2Tkljb0dhdGRGbkVfbTZEUVlhdTVuUWg4T0V6cExMbjA2Vm1JV2FiOTBVa1NnaEo0UTBjZ2JfcFg1ekxkUWkxUks1U1ZTUHpWUSIsIm1hYyI6Inh5WXNQRC81SENxR3pQeEt3VkhhTDFRemc5TTgyYUllRUJlNFk2akV4MlF2U2k1dWVMSWdjRVJibzh3WkZ1V3VwQ2JUUkxHb3NlOGFHZlVSSVhjdHRrWWUrN3pYUkJIendLQXhPNzBnU2J2VDNYd1MydDF3dzRJY0tTbTlWcnVrc0ZxUUFXdWFHWXIwY0h2bzQwWStNa1QrSkRkQ0VXWVErK1hVY1FvSTE0c2tqTENOOVlxZ1lRVFY5Q3V2NzErbkhvVWpPNCsvaFFPeFFHREpUaktTb2xEVG96V3U4L05qb0VFRVN4elRvaEZqdEZrczlCMkZtQ25OWEV6OFphNXlTc1F2V2Z0NXAvUGlQZ0pBalRSdFAwUTg4cG9rWENoZnpHZ1NtcXNmU3ZsSndrRmlRRWNxYlVzMzZXQk1WaGNabHQ4dGxUNjdXcXQvWXJZREtsR1lRQT09In0=\" />\r\n\r\n</div>\r\n\r\n<script type='text/javascript'>var frm = document.getElementById('step1Form');frm.action = 'https://goguvenliodeme.bkm.com.tr/troy/approve' ;frm.method = \"POST\";frm.submit();</script>\r\n    \r\n<div class=\"aspNetHidden\">\r\n\r\n\t<input type=\"hidden\" name=\"__VIEWSTATEGENERATOR\" id=\"__VIEWSTATEGENERATOR\" value=\"BFED9D85\" />\r\n</div></form>\r\n</body>\r\n</html>\r\n";

    final response = await helper.postGuven(
      endpoints.base.doPackagePaymentPath,
      packagePayment.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      final doResult = response.xGetMap['do_result'] as String?;
      if (doResult != null) {
        return doResult;
      }

      throw Exception('/doPackagePayment : ${response.isSuccessful}');
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.doPackagePaymentPath,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> updateUserSystemName(String identityNumber) async {
    final response = await helper.postGuven(
      endpoints.base.updateUserSystemNamePath,
      {'identityNumber': identityNumber},
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.updateUserSystemNamePath,
        response,
      );
    }
  }

  @override
  Future<UserAccount> getUserProfile() async {
    final response = await helper.getGuven(
      endpoints.devApi.getUserProfilePath,
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      final result = UserAccount.fromJson(response.xGetMap);
      return result;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.devApi.getUserProfilePath,
        response,
      );
    }
  }

  @override
  Future<Map<String, dynamic>> getActiveStream() async {
    final response = await helper.getGuven(
      endpoints.base.getActiveStreamPath,
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response.xGetMap;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.getActiveStreamPath,
        response,
      );
    }
  }

  @override
  Future<String> getProfilePicture() async {
    try {
      final response = await helper.getGuven(
        endpoints.base.getProfilePicturePath,
        options: authOptions,
      );
      if (response.xIsSuccessful) {
        final datum = response.datum as String?;
        if (datum != null) {
          return datum;
        }

        throw Exception('/getProfilePicture : ${response.isSuccessful}');
      } else {
        throw RbioNotSuccessfulException<GuvenResponseModel>(
          endpoints.base.getProfilePicturePath,
          response,
        );
      }
    } catch (e) {
      if (e.toString() ==
          "type 'String' is not a subtype of type 'GuvenResponseModel' in type cast") {
        return '';
      }
      rethrow;
    }
  }

  @override
  Future<ConsentForm> getConsentForm() async {
    final response = await helper.getGuven(
      endpoints.common
          .consentFormPath(Intl.getCurrentLocale().xCurrentTrimLocale),
    );

    if (response.xIsSuccessful) {
      final datum = ConsentForm.fromJson(response.datum);
      return datum;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.common
            .consentFormPath(Intl.getCurrentLocale().xCurrentTrimLocale),
        response,
      );
    }
  }

  @override
  Future<ApplicationVersionResponse> getCurrentApplicationVersion() async {
    final response = await helper.getGuven(
      endpoints.doctor.getCurrentApplicationVersionPath,
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return ApplicationVersionResponse.fromJson(response.xGetMap);
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.doctor.getCurrentApplicationVersionPath,
        response,
      );
    }
  }

  @override
  Future<PatientResponse?> getPatientDetail(String url) async {
    final response = await helper.postGuven(url, {}, options: authOptions);
    if (response.xIsSuccessful) {
      final patient = PatientResponse.fromJson(response.xGetMap);
      if (patient.id == 0) {
        patient.id = null;
      }
      await getIt<UserFacade>().setPatient(patient);
      return patient;
    } else {
      return null;
    }
  }

  @override
  Future<List<FilterTenantsResponse>> filterTenants(
    String path,
    FilterTenantsRequest filterTenantsRequest,
  ) async {
    final response = await helper.postGuven(
      path,
      filterTenantsRequest.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      final result = response.xGetMapList
          .map((item) => FilterTenantsResponse.fromJson(item))
          .cast<FilterTenantsResponse>()
          .toList();
      return result;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        path,
        response,
      );
    }
  }

  @override
  Future<List<FilterDepartmentsResponse>> filterDepartments(
    FilterDepartmentsRequest filterDepartmentsRequest,
  ) async {
    final response = await helper.postGuven(
      endpoints.base.filterDepartmentsPath,
      filterDepartmentsRequest.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      final result = response.xGetMapList
          .map((item) => FilterDepartmentsResponse.fromJson(item))
          .cast<FilterDepartmentsResponse>()
          .toList();
      return result;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.filterDepartmentsPath,
        response,
      );
    }
  }

  @override
  Future<List<FilterResourcesResponse>> filterResources(
    FilterResourcesRequest filterResourcesRequest,
  ) async {
    final response = await helper.postGuven(
      endpoints.base.filterResourcesPath,
      filterResourcesRequest.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      final filterResources = <FilterResourcesResponse>[];
      for (final data in response.xGetMapList) {
        final filterResourcesResponse = FilterResourcesResponse.fromJson(data);
        final isOnlineForWeb = filterResourcesResponse.isOnlineForWeb ?? false;
        final isOnline = filterResourcesResponse.isOnline ?? false;
        if (isOnlineForWeb && isOnline) {
          filterResources.add(filterResourcesResponse);
        }
      }
      return filterResources;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.filterResourcesPath,
        response,
      );
    }
  }

  @override
  Future<DoctorCvResponse> getDoctorCvDetails(String doctorWebID) async {
    final response = await helper
        .dioGet(endpoints.common.getDoctorCvDetailsPath(doctorWebID));
    if (response == null) {
      return DoctorCvResponse.empty();
    }

    if (response is Map<String, dynamic>) {
      try {
        final doctorCv = DoctorCvResponse.fromJson(response);
        if ((doctorCv.id ?? -1) != -1) {
          return doctorCv;
        } else {
          return DoctorCvResponse.empty();
        }
      } on Exception {
        return DoctorCvResponse.empty();
      }
    }

    throw Exception('/getDoctorCvDetails');
  }

  @override
  Future<List<GetEventsResponse>> getEvents(
    GetEventsRequest getEventsRequest,
  ) async {
    final response = await helper.postGuven(
      endpoints.base.getEventsPath,
      getEventsRequest.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      final getEventsResponseList = <GetEventsResponse>[];
      final mapDatum = response.xGetMap;
      final resourceEvents = mapDatum['resourceEvents'] as List<dynamic>?;
      final resourceMapEvents =
          resourceEvents?.map((e) => e).cast<Map<String, dynamic>>().toList();
      if (resourceMapEvents is List<Map<String, dynamic>>) {
        for (final data in resourceMapEvents) {
          final getEventsResponse = GetEventsResponse.fromJson(data);
          getEventsResponseList.add(getEventsResponse);
        }
        return getEventsResponseList;
      }

      throw Exception('/getEvents : ${response.isSuccessful}');
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.getEventsPath,
        response,
      );
    }
  }

  @override
  Future<int> saveAppointment(AppointmentRequest appointmentRequest) async {
    final response = await helper.postGuven(
      endpoints.base.saveAppointmentPath,
      appointmentRequest.toJson(),
      options: authOptions..headers?.addAll(utcHeader),
    );
    if (response.xIsSuccessful) {
      //1 ise hem pusula hem güven online, 2 ise pusulaya kayıt başarılı ancak güvene başarısız (Redmine 382)
      final datum = response.datum as int?;
      if (datum == null) {
        throw Exception('/saveAppointment : $datum');
      }

      if (datum == 1 || datum == 2) {
        return datum;
      } else {
        throw Exception('/saveAppointment : $datum');
      }
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.saveAppointmentPath,
        response,
      );
    }
  }

  @override
  Future<PatientRelativeInfoResponse> getAllRelatives(
    GetAllRelativesRequest bodyPages,
  ) async {
    final response = await helper.postGuven(
      endpoints.relative.getAllRelativesPath,
      bodyPages.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return PatientRelativeInfoResponse.fromJson(response.xGetMap);
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.relative.getAllRelativesPath,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> getCountries() async {
    final response = await helper.postGuven(
      endpoints.base.getCountriesPath,
      {},
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.getCountriesPath,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> forgotPassword(
    UserRegistrationStep1Model userRegistrationStep1,
  ) async {
    final response = await helper.postGuven(
      endpoints.devApi.forgotPassword,
      userRegistrationStep1.toJson(),
      options: emptyAuthOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.devApi.forgotPassword,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> changePassword(
    ChangePasswordModel changePasswordModel,
  ) async {
    final response = await helper.postGuven(
      endpoints.devApi.changePassword,
      changePasswordModel.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.devApi.changePassword,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> updateContactInfo(
    ChangeContactInfoRequest changeContactInfo,
  ) async {
    final response = await helper.postGuven(
      endpoints.devApi.updateContactInfoPath,
      changeContactInfo.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.devApi.updateContactInfoPath,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> updatePusulaContactInfo(
    ChangeContactInfoRequest changeContactInfo,
  ) async {
    final response = await helper.postGuven(
      endpoints.base.updatePusulaContactInfoPath,
      changeContactInfo.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.updatePusulaContactInfoPath,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> changeUserPasswordUi(
    String oldPassword,
    String password,
  ) async {
    final response = await helper.getGuven(
      endpoints.base.changeUserPasswordUiPath(oldPassword, password),
      options: authOptions,
    );
    return response;
  }

  @override
  Future<GuvenResponseModel> addFirebaseTokenUi(
    AddFirebaseTokenRequest addFirebaseToken,
  ) async {
    final response = await helper.postGuven(
      endpoints.devApi.addFirebaseTokenUiPath,
      addFirebaseToken.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.devApi.addFirebaseTokenUiPath,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> getRoomStatusUi(String roomId) async {
    final response = await helper.getGuven(
      endpoints.base.getRoomStatusUiPath(roomId),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.getRoomStatusUiPath(roomId),
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> getOnlineAppoFiles(String roomId) async {
    final response = await helper.getGuven(
      endpoints.base.getOnlineAppoFilesPath(roomId),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.getOnlineAppoFilesPath(roomId),
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> deleteOnlineAppoFile(
    String webAppoId,
    String fileName,
  ) async {
    final response = await helper.deleteGuven(
      endpoints.base.deleteOnlineAppoFilePath(webAppoId, fileName),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.deleteOnlineAppoFilePath(webAppoId, fileName),
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> getAllTranslator() async {
    final response = await helper.getGuven(
      endpoints.base.getAllTranslatorPath,
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.getAllTranslatorPath,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> getUserKvkkInfo() async {
    final response = await helper.getGuven(
      endpoints.base.getUserKvkkInfoPath,
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.getUserKvkkInfoPath,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> updateUserKvkkInfo() async {
    final response = await helper.getGuven(
      endpoints.base.updateUserKvkkInfoPath,
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.updateUserKvkkInfoPath,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> addSuggestion(
    SuggestionRequest suggestionRequest,
  ) async {
    final response = await helper.postGuven(
      endpoints.base.addSuggestionPath,
      suggestionRequest.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.addSuggestionPath,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> getCourseId() async {
    final response = await helper.getGuven(
      endpoints.base.getCourseIdPath,
      options: authOptions..headers?.addAll(getCourseHeader),
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.getCourseIdPath,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> setJitsiWebConsultantId(
    String webConsultantId,
  ) async {
    final response = await helper.getGuven(
      endpoints.base.setJitsiWebConsultantIdPath(webConsultantId),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.setJitsiWebConsultantIdPath(webConsultantId),
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> deleteProfilePicture() async {
    final response = await helper.deleteGuven(
      endpoints.base.deleteProfilePicturePath,
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.deleteProfilePicturePath,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> uploadProfilePicture(File file) async {
    final $headers = {'Content-Type': 'multipart/formdata'};
    final String fileName = file.path.split('/').last;
    final FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path, filename: fileName),
    });

    final response = await helper.postGuven(
      endpoints.base.uploadProfilePicturePath,
      formData,
      options: authOptions..headers?.addAll($headers),
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.uploadProfilePicturePath,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> downloadAppointmentSingleFile(
    String folder,
    String path,
  ) async {
    final response = await helper.getGuven(
      endpoints.base.downloadAppointmentSingleFilePath(folder, path),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.downloadAppointmentSingleFilePath(folder, path),
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> getAllFiles() async {
    final response = await helper.getGuven(
      endpoints.base.getAllFilesPath,
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.getAllFilesPath,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> downloadAppointmentFile(
    String id,
    String name,
  ) async {
    final response = await helper.getGuven(
      endpoints.base.downloadAppointmentFilePath(id, name),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.downloadAppointmentFilePath(id, name),
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> getRelativeRelationships() async {
    final response = await helper.getGuven(
      endpoints.relative.getRelativeRelationshipsPath,
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.relative.getRelativeRelationshipsPath,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> changeActiveUserToRelative(String id) async {
    final response = await helper.getGuven(
      endpoints.relative.changeActiveUserToRelativePath(id),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.relative.changeActiveUserToRelativePath(id),
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> clickPost(int postId) async {
    final response = await helper.getGuven(
      endpoints.base.clickPostPath(postId),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.clickPostPath(postId),
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> getPostWithTagsByText(String search) async {
    final response = await helper.getGuven(
      endpoints.search.getPostWithTagsByText(search),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.search.getPostWithTagsByText(search),
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> getPostWithTagsByPlatform(String search) async {
    final response = await helper.getGuven(
      endpoints.search.getPostWithTagsByPlatform(search),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.search.getPostWithTagsByPlatform(search),
        response,
      );
    }
  }

  @override
  Future<List<BannerTabsModel>> getBannerTab(
    String applicationName,
    String groupName,
  ) async {
    final response = await helper.getGuven(
      endpoints.devApi.getBannerTab(applicationName, groupName),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      final bannerTabs = <BannerTabsModel>[];
      final datum = response.xGetMapList;
      for (final data in datum) {
        bannerTabs.add(BannerTabsModel.fromJson(data));
      }
      return bannerTabs;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.devApi.getBannerTab(applicationName, groupName),
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> socialResource() async {
    final response = await helper.getGuven(
      endpoints.search.getAllPosts,
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.search.getAllPosts,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> getAppointmentTypeViaWebConsultantId() async {
    final response = await helper.getGuven(
      endpoints.base.getAppointmentTypeViaWebConsultantIdPath,
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.getAppointmentTypeViaWebConsultantIdPath,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> requestTranslator(
    String appoId,
    TranslatorRequest translatorPost,
  ) async {
    final response = await helper.patchGuven(
      endpoints.base.requestTranslatorPath(appoId),
      data: translatorPost.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      if (response.message == "1") {
        throw RbioDisplayException(
          LocaleProvider.current.expired_interpreter_request,
        );
      }

      throw Exception('/requestTranslator : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> uploadFileToAppo(
    String webAppoId,
    File file,
  ) async {
    final $headers = {'Content-Type': 'multipart/formdata'};
    final String fileName = file.path.split('/').last;
    final FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path, filename: fileName),
    });
    final response = await helper.postGuven(
      endpoints.base.uploadFileToAppoPath(webAppoId),
      formData,
      options: authOptions..headers?.addAll($headers),
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.uploadFileToAppoPath(webAppoId),
        response,
      );
    }
  }

  @override
  Future<List<VisitResponse>> getVisits(VisitRequest visitRequestBody) async {
    final response = await helper.postGuven(
      endpoints.base.getVisitsPath,
      visitRequestBody.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response.xGetMapList
          .map((e) => VisitResponse.fromJson(e))
          .cast<VisitResponse>()
          .toList();
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.getVisitsPath,
        response,
      );
    }
  }

  @override
  Future<List<LaboratoryResponse>> getLaboratoryResults(
    VisitDetailRequest detailRequest,
  ) async {
    final response = await helper.postGuven(
      endpoints.base.getLaboratoryResultsPath,
      detailRequest.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      final laboratoryResults = <LaboratoryResponse>[];
      final datum = response.xGetMapList;
      for (final data in datum) {
        laboratoryResults.add(LaboratoryResponse.fromJson(data));
        final children =
            laboratoryResults[laboratoryResults.length - 1].children;
        if (children != null) {
          for (final dataChild in children) {
            laboratoryResults.add(dataChild);
          }
        }
      }
      return laboratoryResults;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.getLaboratoryResultsPath,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> rateOnlineCall(
    CallRateRequest callRateRequest,
  ) async {
    final response = await helper.postGuven(
      endpoints.base.rateOnlineCallPath,
      callRateRequest.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.rateOnlineCallPath,
        response,
      );
    }
  }

  @override
  Future<List<RadiologyResponse>> getRadiologyResults(
    VisitDetailRequest detailRequest,
  ) async {
    final response = await helper.postGuven(
      endpoints.base.getRadiologyResultsPath,
      detailRequest.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response.xGetMapList
          .map((e) => RadiologyResponse.fromJson(e))
          .cast<RadiologyResponse>()
          .toList();
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.getRadiologyResultsPath,
        response,
      );
    }
  }

  @override
  Future<List<PathologyResponse>> getPathologyResults(
      VisitDetailRequest detailRequest) async {
    final response = await helper.postGuven(
      endpoints.base.getPathologyResultsPath,
      detailRequest.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response.xGetMapList
          .map((e) => PathologyResponse.fromJson(e))
          .cast<PathologyResponse>()
          .toList();
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.getPathologyResultsPath,
        response,
      );
    }
  }

  @override
  Future<String> getLaboratoryPdfResult(
    LaboratoryPdfResultRequest laboratoryPdfResultRequest,
  ) async {
    final response = await helper.postGuven(
      endpoints.base.getLaboratoryPdfResultPath,
      laboratoryPdfResultRequest.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      final datum = response.datum;
      if (datum is String?) {
        if (datum != null) {
          return datum;
        }
      }

      throw Exception('/getLaboratoryPdfResult : ${response.isSuccessful}');
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.getLaboratoryPdfResultPath,
        response,
      );
    }
  }

  @override
  Future<String> getRadiologyPdfResult(
    RadiologyPdfRequest radiologyPdfResultRequest,
  ) async {
    final response = await helper.postGuven(
      endpoints.base.getRadiologyPdfResultPath,
      radiologyPdfResultRequest.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      final datum = response.datum;
      if (datum is String?) {
        if (datum != null) {
          return datum;
        }
      }

      throw Exception('/getRadiologyPdfResult : ${response.isSuccessful}');
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.getRadiologyPdfResultPath,
        response,
      );
    }
  }

  @override
  Future<List<PatientAppointmentsResponse>> getPatientAppointments(
    PatientAppointmentRequest patientAppointmentRequest,
  ) async {
    final response = await helper.postGuven(
      endpoints.base.getPatientAppointmentsPath,
      patientAppointmentRequest.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      final getPatientAppointmentsResponse = <PatientAppointmentsResponse>[];
      final datum = response.xGetMapList;
      for (final data in datum) {
        final patientAppointmentsResponse =
            PatientAppointmentsResponse.fromJson(data);
        // İptal Edilmemiş ise
        if (patientAppointmentsResponse.status != 0) {
          getPatientAppointmentsResponse.add(patientAppointmentsResponse);
        }
      }

      return getPatientAppointmentsResponse;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.getPatientAppointmentsPath,
        response,
      );
    }
  }

  @override
  Future<bool> cancelAppointment(
    CancelAppointmentRequest cancelAppointmentRequest,
  ) async {
    final response = await helper.postGuven(
      endpoints.base.cancelAppointmentPath,
      cancelAppointmentRequest.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return true;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.cancelAppointmentPath,
        response,
      );
    }
  }

  @override
  Future<GetVideoCallPriceResponse> getResourceVideoCallPrice(
    GetVideoCallPriceRequest getVideoCallPriceRequest,
  ) async {
    final response = await helper.postGuven(
      endpoints.base.getResourceVideoCallPricePath,
      getVideoCallPriceRequest.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return GetVideoCallPriceResponse.fromJson(response.xGetMap);
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.getResourceVideoCallPricePath,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> doMobilePaymentWithVoucher(
    DoMobilePaymentWithVoucherRequest doMobilePaymentWithVoucherRequest,
  ) async {
    final response = await helper.postGuven(
      endpoints.base.doMobilePaymentWithVoucher,
      doMobilePaymentWithVoucherRequest.toJson(),
      options: authOptions..headers?.addAll(utcHeader),
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.doMobilePaymentWithVoucher,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> doMobilePayment(
    DoMobilePaymentWithVoucherRequest doMobilePaymentWithVoucherRequest,
  ) async {
    final response = await helper.postGuven(
      endpoints.base.doMobilePaymentPath,
      doMobilePaymentWithVoucherRequest.toJson(),
      options: authOptions..headers?.addAll(utcHeader),
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.doMobilePaymentPath,
        response,
      );
    }
  }

  @override
  Future<List<FilterDepartmentsResponse>> fetchOnlineDepartments(
    FilterOnlineDepartmentsRequest filterOnlineDepartmentsRequest,
  ) async {
    final response = await helper.postGuven(
      endpoints.base.fetchOnlineDepartmentsPath,
      filterOnlineDepartmentsRequest.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response.xGetMapList
          .map((e) => FilterDepartmentsResponse.fromJson(e))
          .cast<FilterDepartmentsResponse>()
          .toList();
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.fetchOnlineDepartmentsPath,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> checkOnlineAppointmentPayment(
    CheckPaymentRequest request,
  ) async {
    final response = await helper.postGuven(
      endpoints.base.checkOnlineAppointmentPaymentPath,
      request.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.checkOnlineAppointmentPaymentPath,
        response,
      );
    }
  }

  @override
  Future<GetAvailabilityRateResponse> getAvailabilityRate(
    GetAvailabilityRateRequest getAvailabilityRateRequest,
  ) async {
    final response = await helper.postGuven(
      endpoints.base.getAvailabilityRatePath,
      getAvailabilityRateRequest.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return GetAvailabilityRateResponse.fromJson(response.xGetMap);
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.getAvailabilityRatePath,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> addNewPatientRelative(
      UserRelativePatientModel addPatientRelative) async {
    final response = await helper.postGuven(
      endpoints.relative.addNewPatientRelativePath,
      addPatientRelative.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.relative.addNewPatientRelativePath,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> uploadPatientDocuments(
    String webAppoId,
    Uint8List file,
  ) async {
    final $headers = {'Content-Type': 'multipart/formdata'};
    final FormData formData = FormData.fromMap({
      "file": MultipartFile.fromBytes(file,
          filename: DateTime.now().xFormatTime6()),
    });
    final response = await helper.postGuven(
      endpoints.base.uploadPatientDocumentsPath(webAppoId),
      formData,
      options: authOptions..headers?.addAll($headers),
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.uploadPatientDocumentsPath(webAppoId),
        response,
      );
    }
  }

  @override
  Future<List<AvailableDate>> findResourceAvailableDays(
    FindResourceAvailableDaysRequest findResourceAvailableDaysRequest,
  ) async {
    final response = await helper.postGuven(
      endpoints.base.findResourceAvailableDays,
      findResourceAvailableDaysRequest.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response.xGetMapList
          .map((item) => AvailableDate.fromJson(item))
          .cast<AvailableDate>()
          .toList();
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.findResourceAvailableDays,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> getResourceVideoCallPriceVoucher(
    VoucherPriceRequest voucherPriceRequest,
  ) async {
    final response = await helper.postGuven(
      endpoints.base.getResourceVideoCallPriceWithVoucher,
      voucherPriceRequest.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.getResourceVideoCallPriceWithVoucher,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> getChatContacts() async {
    final response = await helper.postGuven(
      endpoints.devApi.getChatContacts,
      {'isActiveChats': 'true'},
      options: authOptions,
    );
    return response;
  }

  @override
  Future<GuvenResponseModel> sendNotification(
    ChatNotificationModel model,
  ) async {
    final response = await helper.postGuven(
      endpoints.devApi.sendNotification,
      model.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.devApi.sendNotification,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> synchronizeOneDoseUser(
      SynchronizeOneDoseUserRequest synchronizeOnedoseUserRequest) async {
    final response = await helper.postGuven(
      endpoints.base.syncronizeOneDoseUser,
      synchronizeOnedoseUserRequest.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.base.syncronizeOneDoseUser,
        response,
      );
    }
  }

  @override
  Future<void> sendOnlineAppointmentNotificationPusula(
    String appointmentId,
    String fromDate,
  ) async {
    try {
      await helper.postGuven(
        endpoints.base
            .sendOnlineAppointmentNotificationPusula(appointmentId, fromDate),
        {},
        options: authOptions,
      );
    } catch (e) {
      LoggerUtils.instance.e(
        "apiServiceImpl - sendOnlineAppointmentNotificationPusula($appointmentId, $fromDate)",
      );
    }
  }
}
