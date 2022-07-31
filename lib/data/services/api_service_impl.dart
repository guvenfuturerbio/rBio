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
      endpoints.userRegister.addStep1,
      addStep1Model.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.userRegister.addStep1,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> addStep2(
    UserRegistrationStep2Model userRegistrationStep2,
  ) async {
    final response = await helper.postGuven(
      endpoints.userRegister.addStep2,
      userRegistrationStep2.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.userRegister.addStep2,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> addStep3(
    UserRegistrationStep3Model userRegistrationStep3,
  ) async {
    final response = await helper.postGuven(
      endpoints.userRegister.addStep3,
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
      endpoints.accessToken.userLoginStarter,
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
      endpoints.accessToken.verifyConfirmation2fa,
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
    String username,
    String password,
    String consentId,
  ) async {
    final response = await helper.postGuven(
      endpoints.accessToken.loginPath,
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
        endpoints.accessToken.loginPath,
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
      endpoints.package.getSubCategoryItemsPath(id),
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
        endpoints.package.getSubCategoryItemsPath(id),
        response,
      );
    }
  }

  @override
  Future<String> doPackagePayment(PackagePaymentRequest packagePayment) async {
    //return "\r\n\r\n<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\r\n<head id=\"Head1\"><title>\r\n\tPayment MPI Service\r\n</title></head>\r\n<body>\r\n    <form method=\"post\" action=\"https://goguvenliodeme.bkm.com.tr/troy/approve\" id=\"step1Form\">\r\n<div class=\"aspNetHidden\">\r\n<input type=\"hidden\" name=\"goreq\" id=\"goreq\" value=\"eyJpZCI6IjAxMTEyOWVkYjA2Ni1iMzM1LTQ5ZjMtYTUxOS1hYTNkMzNmMzlmZjYiLCJ0aW1lIjoiMjAyMTAzMDYxMzI2MjUiLCJ2ZXJzaW9uIjoiMC4wMyIsImV4cGlyeSI6IjI0MTAiLCJnb1N0YW1wIjoiZXlKaGJHY2lPaUpJVXpVeE1pSjkuZXlKemRXSWlPaUl3T1RFM01EQXdNREF3TVRVME1EUWlMQ0owYVcxbGIzVjBVMlZqYjI1a2N5STZORE15TURBd01EQXNJbkp2YkdWeklqb2lJaXdpWlhod0lqb3hOalU0TWpJMk16ZzFmUS5FUEJMeXpTclpTaHh2Tkljb0dhdGRGbkVfbTZEUVlhdTVuUWg4T0V6cExMbjA2Vm1JV2FiOTBVa1NnaEo0UTBjZ2JfcFg1ekxkUWkxUks1U1ZTUHpWUSIsIm1hYyI6Inh5WXNQRC81SENxR3pQeEt3VkhhTDFRemc5TTgyYUllRUJlNFk2akV4MlF2U2k1dWVMSWdjRVJibzh3WkZ1V3VwQ2JUUkxHb3NlOGFHZlVSSVhjdHRrWWUrN3pYUkJIendLQXhPNzBnU2J2VDNYd1MydDF3dzRJY0tTbTlWcnVrc0ZxUUFXdWFHWXIwY0h2bzQwWStNa1QrSkRkQ0VXWVErK1hVY1FvSTE0c2tqTENOOVlxZ1lRVFY5Q3V2NzErbkhvVWpPNCsvaFFPeFFHREpUaktTb2xEVG96V3U4L05qb0VFRVN4elRvaEZqdEZrczlCMkZtQ25OWEV6OFphNXlTc1F2V2Z0NXAvUGlQZ0pBalRSdFAwUTg4cG9rWENoZnpHZ1NtcXNmU3ZsSndrRmlRRWNxYlVzMzZXQk1WaGNabHQ4dGxUNjdXcXQvWXJZREtsR1lRQT09In0=\" />\r\n\r\n</div>\r\n\r\n<script type='text/javascript'>var frm = document.getElementById('step1Form');frm.action = 'https://goguvenliodeme.bkm.com.tr/troy/approve' ;frm.method = \"POST\";frm.submit();</script>\r\n    \r\n<div class=\"aspNetHidden\">\r\n\r\n\t<input type=\"hidden\" name=\"__VIEWSTATEGENERATOR\" id=\"__VIEWSTATEGENERATOR\" value=\"BFED9D85\" />\r\n</div></form>\r\n</body>\r\n</html>\r\n";

    final response = await helper.postGuven(
      endpoints.package.doPackagePaymentPath,
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
        endpoints.package.doPackagePaymentPath,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> updateUserSystemName(String identityNumber) async {
    final response = await helper.postGuven(
      endpoints.single.updateUserSystemNamePath,
      {'identityNumber': identityNumber},
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.single.updateUserSystemNamePath,
        response,
      );
    }
  }

  @override
  Future<UserAccount> getUserProfile() async {
    final response = await helper.getGuven(
      endpoints.user.getUserProfilePath,
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      final result = UserAccount.fromJson(response.xGetMap);
      return result;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.user.getUserProfilePath,
        response,
      );
    }
  }

  @override
  Future<Map<String, dynamic>> getActiveStream() async {
    final response = await helper.getGuven(
      endpoints.profile.getActiveStreamPath,
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response.xGetMap;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.profile.getActiveStreamPath,
        response,
      );
    }
  }

  @override
  Future<String> getProfilePicture() async {
    try {
      final response = await helper.getGuven(
        endpoints.file.getProfilePicturePath,
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
          endpoints.file.getProfilePicturePath,
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
      endpoints.userRegister
          .consentFormPath(Intl.getCurrentLocale().xCurrentTrimLocale),
    );
    if (response.xIsSuccessful) {
      final datum = ConsentForm.fromJson(response.datum);
      return datum;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.userRegister
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
      final responseData = List.from(response.datum['data']);
      final result = responseData
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
      endpoints.pusula.filterDepartmentsPath,
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
        endpoints.pusula.filterDepartmentsPath,
        response,
      );
    }
  }

  @override
  Future<List<FilterResourcesResponse>> filterResources(
    FilterResourcesRequest filterResourcesRequest,
  ) async {
    final response = await helper.postGuven(
      endpoints.pusula.filterResourcesPath,
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
        endpoints.pusula.filterResourcesPath,
        response,
      );
    }
  }

  @override
  Future<DoctorCvResponse> getDoctorCvDetails(String doctorWebID) async {
    final response = await helper
        .dioGet(endpoints.single.getDoctorCvDetailsPath(doctorWebID));
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
      endpoints.pusula.getEventsPath,
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
        endpoints.pusula.getEventsPath,
        response,
      );
    }
  }

  @override
  Future<int> saveAppointment(AppointmentRequest appointmentRequest) async {
    final response = await helper.postGuven(
      endpoints.pusula.saveAppointmentPath,
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
        endpoints.pusula.saveAppointmentPath,
        response,
      );
    }
  }

  @override
  Future<PatientRelativeInfoResponse> getAllRelatives(
    GetAllRelativesRequest bodyPages,
  ) async {
    final response = await helper.postGuven(
      endpoints.profile.getAllRelativesPath,
      bodyPages.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return PatientRelativeInfoResponse.fromJson(response.xGetMap);
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.profile.getAllRelativesPath,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> getCountries() async {
    final response = await helper.postGuven(
      endpoints.pusula.getCountriesPath,
      {},
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.pusula.getCountriesPath,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> forgotPassword(
    UserRegistrationStep1Model userRegistrationStep1,
  ) async {
    final response = await helper.postGuven(
      endpoints.userRegister.forgotPassword,
      userRegistrationStep1.toJson(),
      options: emptyAuthOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.userRegister.forgotPassword,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> changePassword(
    ChangePasswordModel changePasswordModel,
  ) async {
    final response = await helper.postGuven(
      endpoints.userRegister.changePassword,
      changePasswordModel.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.userRegister.changePassword,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> updateContactInfo(
    ChangeContactInfoRequest changeContactInfo,
  ) async {
    final response = await helper.postGuven(
      endpoints.user.updateContactInfoPath,
      changeContactInfo.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.user.updateContactInfoPath,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> updatePusulaContactInfo(
    ChangeContactInfoRequest changeContactInfo,
  ) async {
    final response = await helper.postGuven(
      endpoints.pusula.updatePusulaContactInfoPath,
      changeContactInfo.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.pusula.updatePusulaContactInfoPath,
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
      endpoints.user.changeUserPasswordUiPath(oldPassword, password),
      options: authOptions,
    );
    return response;
  }

  @override
  Future<GuvenResponseModel> addFirebaseTokenUi(
    AddFirebaseTokenRequest addFirebaseToken,
  ) async {
    final response = await helper.postGuven(
      endpoints.user.addFirebaseTokenUiPath,
      addFirebaseToken.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.user.addFirebaseTokenUiPath,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> getOnlineAppoFiles(String roomId) async {
    final response = await helper.getGuven(
      endpoints.file.getOnlineAppoFilesPath(roomId),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.file.getOnlineAppoFilesPath(roomId),
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
      endpoints.file.deleteOnlineAppoFilePath(webAppoId, fileName),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.file.deleteOnlineAppoFilePath(webAppoId, fileName),
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> getAllTranslator() async {
    final response = await helper.getGuven(
      endpoints.appointmentInterpreter.getAllTranslatorPath,
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.appointmentInterpreter.getAllTranslatorPath,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> getUserKvkkInfo() async {
    final response = await helper.getGuven(
      endpoints.user.getUserKvkkInfoPath,
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.user.getUserKvkkInfoPath,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> updateUserKvkkInfo() async {
    final response = await helper.getGuven(
      endpoints.user.updateUserKvkkInfoPath,
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.user.updateUserKvkkInfoPath,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> addSuggestion(
    SuggestionRequest suggestionRequest,
  ) async {
    final response = await helper.postGuven(
      endpoints.suggestionRate.addSuggestionPath,
      suggestionRequest.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.suggestionRate.addSuggestionPath,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> setJitsiWebConsultantId(
    String webConsultantId,
  ) async {
    final response = await helper.getGuven(
      endpoints.single.setJitsiWebConsultantIdPath(webConsultantId),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.single.setJitsiWebConsultantIdPath(webConsultantId),
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> deleteProfilePicture() async {
    final response = await helper.deleteGuven(
      endpoints.file.deleteProfilePicturePath,
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.file.deleteProfilePicturePath,
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
      endpoints.file.uploadProfilePicturePath,
      formData,
      options: authOptions..headers?.addAll($headers),
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.file.uploadProfilePicturePath,
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
      endpoints.file.downloadAppointmentSingleFilePath(folder, path),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.file.downloadAppointmentSingleFilePath(folder, path),
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> getAllFiles() async {
    final response = await helper.getGuven(
      endpoints.file.getAllFilesPath,
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.file.getAllFilesPath,
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
      endpoints.file.downloadAppointmentFilePath(id, name),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.file.downloadAppointmentFilePath(id, name),
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> getRelativeRelationships() async {
    final response = await helper.getGuven(
      endpoints.user.getRelativeRelationshipsPath,
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.user.getRelativeRelationshipsPath,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> changeActiveUserToRelative(String id) async {
    final response = await helper.getGuven(
      endpoints.profile.changeActiveUserToRelativePath(id),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.profile.changeActiveUserToRelativePath(id),
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> clickPost(int postId) async {
    final response = await helper.getGuven(
      endpoints.socialPost.clickPostPath(postId),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.socialPost.clickPostPath(postId),
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> getPostWithTagsByText(String search) async {
    final response = await helper.getGuven(
      endpoints.socialPost.getPostWithTagsByText(search),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.socialPost.getPostWithTagsByText(search),
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> getPostWithTagsByPlatform(String search) async {
    final response = await helper.getGuven(
      endpoints.socialPost.getPostWithTagsByPlatform(search),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.socialPost.getPostWithTagsByPlatform(search),
        response,
      );
    }
  }

  @override
  Future<List<BannerTabsModel>> getBannerTab(
    String applicationName,
    String groupName,
  ) async {
    final bannerTabs = <BannerTabsModel>[];
    bannerTabs.add(
      BannerTabsModel(
        name: "COVID-19 Sonrası Uygulanacak Nefes Egzersizleri",
        index: 2,
        imageUrl:
            "https://static.wixstatic.com/media/bac967_14c8af47da914a59aeb31bd35665a795~mv2.png",
        destinationUrl:
            "https://www.youtube.com/watch?v=nYhkfy3shGM&list=PLNjCXmjuq3oR9BYpq_StRyJJ1vaaerqGS&index=6",
        applicationName: "rBio",
        groupName: "anaSayfa",
        id: 1,
      ),
    );
    bannerTabs.add(
      BannerTabsModel(
        name: "Zerdeçalın Sağlığa 5 Faydası",
        index: 3,
        imageUrl:
            "https://static.wixstatic.com/media/bac967_4d212bd310a14edf962302e9461d1c77~mv2.png",
        destinationUrl:
            "https://www.guven.com.tr/saglik-rehberi/zerdecalin-sagliga-5-faydasi",
        applicationName: "rBio",
        groupName: "anaSayfa",
        id: 2,
      ),
    );
    bannerTabs.add(
      BannerTabsModel(
        name: "Metabolik Sendrom Nedir?",
        index: 1,
        imageUrl:
            "https://static.wixstatic.com/media/bac967_6c1d7ce0780d4d1498375b7f7a5deeb7~mv2.png",
        destinationUrl:
            "https://www.youtube.com/watch?v=3wIbUfBcTBU&list=PLNjCXmjuq3oR9BYpq_StRyJJ1vaaerqGS&index=24",
        applicationName: "rBio",
        groupName: "anaSayfa",
        id: 3,
      ),
    );
    bannerTabs.add(
      BannerTabsModel(
        name: "Uyku Apnesi Nedir?",
        index: 4,
        imageUrl:
            "https://static.wixstatic.com/media/bac967_18046d595f7c4c3489ae7b8490a4087f~mv2.png",
        destinationUrl:
            "https://www.guven.com.tr/saglik-rehberi/uyku-apnesi-nedir",
        applicationName: "rBio",
        groupName: "anaSayfa",
        id: 4,
      ),
    );
    bannerTabs.add(
      BannerTabsModel(
        name: "Çölyak Hastalığı Nedir?",
        index: 5,
        imageUrl:
            "https://static.wixstatic.com/media/bac967_f38d232927cb44eb807830a1011d9e97~mv2.png",
        destinationUrl:
            "https://www.guven.com.tr/saglik-rehberi/colyak-hastaligi-nedir",
        applicationName: "rBio",
        groupName: "anaSayfa",
        id: 7,
      ),
    );
    return bannerTabs;
  }

  @override
  Future<GuvenResponseModel> socialResource() async {
    final response = await helper.getGuven(
      endpoints.socialPost.getAllPosts,
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.socialPost.getAllPosts,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> getAppointmentTypeViaWebConsultantId() async {
    final response = await helper.getGuven(
      endpoints.single.getAppointmentTypeViaWebConsultantIdPath,
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.single.getAppointmentTypeViaWebConsultantIdPath,
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
      endpoints.appointmentInterpreter.requestTranslatorPath(appoId),
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
      endpoints.file.uploadFileToAppoPath(webAppoId),
      formData,
      options: authOptions..headers?.addAll($headers),
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.file.uploadFileToAppoPath(webAppoId),
        response,
      );
    }
  }

  @override
  Future<List<VisitResponse>> getVisits(VisitRequest visitRequestBody) async {
    final response = await helper.postGuven(
      endpoints.pusula.getVisitsPath,
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
        endpoints.pusula.getVisitsPath,
        response,
      );
    }
  }

  @override
  Future<List<LaboratoryResponse>> getLaboratoryResults(
    VisitDetailRequest detailRequest,
  ) async {
    final response = await helper.postGuven(
      endpoints.pusula.getLaboratoryResultsPath,
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
        endpoints.pusula.getLaboratoryResultsPath,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> rateOnlineCall(
    CallRateRequest callRateRequest,
  ) async {
    final response = await helper.postGuven(
      endpoints.suggestionRate.rateOnlineCallPath,
      callRateRequest.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.suggestionRate.rateOnlineCallPath,
        response,
      );
    }
  }

  @override
  Future<List<RadiologyResponse>> getRadiologyResults(
    VisitDetailRequest detailRequest,
  ) async {
    final response = await helper.postGuven(
      endpoints.pusula.getRadiologyResultsPath,
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
        endpoints.pusula.getRadiologyResultsPath,
        response,
      );
    }
  }

  @override
  Future<List<PathologyResponse>> getPathologyResults(
      VisitDetailRequest detailRequest) async {
    final response = await helper.postGuven(
      endpoints.pusula.getPathologyResultsPath,
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
        endpoints.pusula.getPathologyResultsPath,
        response,
      );
    }
  }

  @override
  Future<String> getLaboratoryPdfResult(
    LaboratoryPdfResultRequest laboratoryPdfResultRequest,
  ) async {
    final response = await helper.postGuven(
      endpoints.pusula.getLaboratoryPdfResultPath,
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
        endpoints.pusula.getLaboratoryPdfResultPath,
        response,
      );
    }
  }

  @override
  Future<String> getRadiologyPdfResult(
    RadiologyPdfRequest radiologyPdfResultRequest,
  ) async {
    final response = await helper.postGuven(
      endpoints.pusula.getRadiologyPdfResultPath,
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
        endpoints.pusula.getRadiologyPdfResultPath,
        response,
      );
    }
  }

  @override
  Future<List<PatientAppointmentsResponse>> getPatientAppointments(
    PatientAppointmentRequest patientAppointmentRequest,
  ) async {
    final response = await helper.postGuven(
      endpoints.pusula.getPatientAppointmentsPath,
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
        endpoints.pusula.getPatientAppointmentsPath,
        response,
      );
    }
  }

  @override
  Future<bool> cancelAppointment(
    CancelAppointmentRequest cancelAppointmentRequest,
  ) async {
    final response = await helper.postGuven(
      endpoints.pusula.cancelAppointmentPath,
      cancelAppointmentRequest.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return true;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.pusula.cancelAppointmentPath,
        response,
      );
    }
  }

  @override
  Future<GetVideoCallPriceResponse> getResourceVideoCallPrice(
    GetVideoCallPriceRequest getVideoCallPriceRequest,
  ) async {
    final response = await helper.postGuven(
      endpoints.pusula.getResourceVideoCallPricePath,
      getVideoCallPriceRequest.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return GetVideoCallPriceResponse.fromJson(response.xGetMap);
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.pusula.getResourceVideoCallPricePath,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> doMobilePaymentWithVoucher(
    DoMobilePaymentWithVoucherRequest doMobilePaymentWithVoucherRequest,
  ) async {
    final response = await helper.postGuven(
      endpoints.pusula.doMobilePaymentWithVoucher,
      doMobilePaymentWithVoucherRequest.toJson(),
      options: authOptions..headers?.addAll(utcHeader),
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.pusula.doMobilePaymentWithVoucher,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> doMobilePayment(
    DoMobilePaymentWithVoucherRequest doMobilePaymentWithVoucherRequest,
  ) async {
    final response = await helper.postGuven(
      endpoints.pusula.doMobilePaymentPath,
      doMobilePaymentWithVoucherRequest.toJson(),
      options: authOptions..headers?.addAll(utcHeader),
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.pusula.doMobilePaymentPath,
        response,
      );
    }
  }

  @override
  Future<List<FilterDepartmentsResponse>> fetchOnlineDepartments(
    FilterOnlineDepartmentsRequest filterOnlineDepartmentsRequest,
  ) async {
    final response = await helper.postGuven(
      endpoints.pusula.fetchOnlineDepartmentsPath,
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
        endpoints.pusula.fetchOnlineDepartmentsPath,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> checkOnlineAppointmentPayment(
    CheckPaymentRequest request,
  ) async {
    final response = await helper.postGuven(
      endpoints.pusula.checkOnlineAppointmentPaymentPath,
      request.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.pusula.checkOnlineAppointmentPaymentPath,
        response,
      );
    }
  }

  @override
  Future<GetAvailabilityRateResponse> getAvailabilityRate(
    GetAvailabilityRateRequest getAvailabilityRateRequest,
  ) async {
    final response = await helper.postGuven(
      endpoints.suggestionRate.getAvailabilityRatePath,
      getAvailabilityRateRequest.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return GetAvailabilityRateResponse.fromJson(response.xGetMap);
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.suggestionRate.getAvailabilityRatePath,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> addNewPatientRelative(
      UserRelativePatientModel addPatientRelative) async {
    final response = await helper.postGuven(
      endpoints.profile.addNewPatientRelativePath,
      addPatientRelative.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.profile.addNewPatientRelativePath,
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
      endpoints.file.uploadPatientDocumentsPath(webAppoId),
      formData,
      options: authOptions..headers?.addAll($headers),
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.file.uploadPatientDocumentsPath(webAppoId),
        response,
      );
    }
  }

  @override
  Future<List<AvailableDate>> findResourceAvailableDays(
    FindResourceAvailableDaysRequest findResourceAvailableDaysRequest,
  ) async {
    final response = await helper.postGuven(
      endpoints.pusula.findResourceAvailableDays,
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
        endpoints.pusula.findResourceAvailableDays,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> getResourceVideoCallPriceVoucher(
    VoucherPriceRequest voucherPriceRequest,
  ) async {
    final response = await helper.postGuven(
      endpoints.pusula.getResourceVideoCallPriceWithVoucher,
      voucherPriceRequest.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.pusula.getResourceVideoCallPriceWithVoucher,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> getChatContacts() async {
    final response = await helper.postGuven(
      endpoints.user.getChatContacts,
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
      endpoints.user.sendNotification,
      model.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.user.sendNotification,
        response,
      );
    }
  }

  @override
  Future<GuvenResponseModel> synchronizeOneDoseUser(
      SynchronizeOneDoseUserRequest synchronizeOnedoseUserRequest) async {
    final response = await helper.postGuven(
      endpoints.userRegister.syncronizeOneDoseUser,
      synchronizeOnedoseUserRequest.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw RbioNotSuccessfulException<GuvenResponseModel>(
        endpoints.userRegister.syncronizeOneDoseUser,
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
        endpoints.single
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
