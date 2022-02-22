part of 'api_service.dart';

class ApiServiceImpl extends ApiService {
  @override
  final IDioHelper helper;
  ApiServiceImpl(this.helper) : super(helper);

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

  @override
  Future<RbioLoginResponse> login(String username, String password) async {
    final response = await helper.postGuven(
      R.endpoints.loginPath,
      <String, dynamic>{},
      queryParameters: {
        'userName': username,
        'password': password,
      },
    );
    if (response.xIsSuccessful) {
      return RbioLoginResponse.fromJson(response.xGetMap);
    } else {
      throw Exception('/login : ${response.isSuccessful}');
    }
  }

  @override
  Future<List<ForYouCategoryResponse>> getAllPackage(String path) async {
    final response = await helper.getGuven(path, options: authOptions);
    if (response.xIsSuccessful) {
      final result = response.xGetMapList
          .map((item) => ForYouCategoryResponse.fromJson(item))
          .cast<ForYouCategoryResponse>()
          .toList();
      return result;
    } else {
      throw Exception('/getAllPackage : ${response.isSuccessful}');
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
      throw Exception('/getAllSubCategories : ${response.isSuccessful}');
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
      throw Exception('/getSubCategoryDetail/ : ${response.isSuccessful}');
    }
  }

  @override
  Future<List<ForYouSubCategoryItemsResponse>> getSubCategoryItems(
    String id,
  ) async {
    final response = await helper.getGuven(
      R.endpoints.getSubCategoryItemsPath(id),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      final result = response.xGetMapList
          .map((item) => ForYouSubCategoryItemsResponse.fromJson(item))
          .cast<ForYouSubCategoryItemsResponse>()
          .toList();
      return result;
    } else {
      throw Exception('/getSubCategoryItems/$id : ${response.isSuccessful}');
    }
  }

  @override
  Future<String> doPackagePayment(PackagePaymentRequest packagePayment) async {
    //return "\r\n\r\n<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\r\n<head id=\"Head1\"><title>\r\n\tPayment MPI Service\r\n</title></head>\r\n<body>\r\n    <form method=\"post\" action=\"https://goguvenliodeme.bkm.com.tr/troy/approve\" id=\"step1Form\">\r\n<div class=\"aspNetHidden\">\r\n<input type=\"hidden\" name=\"goreq\" id=\"goreq\" value=\"eyJpZCI6IjAxMTEyOWVkYjA2Ni1iMzM1LTQ5ZjMtYTUxOS1hYTNkMzNmMzlmZjYiLCJ0aW1lIjoiMjAyMTAzMDYxMzI2MjUiLCJ2ZXJzaW9uIjoiMC4wMyIsImV4cGlyeSI6IjI0MTAiLCJnb1N0YW1wIjoiZXlKaGJHY2lPaUpJVXpVeE1pSjkuZXlKemRXSWlPaUl3T1RFM01EQXdNREF3TVRVME1EUWlMQ0owYVcxbGIzVjBVMlZqYjI1a2N5STZORE15TURBd01EQXNJbkp2YkdWeklqb2lJaXdpWlhod0lqb3hOalU0TWpJMk16ZzFmUS5FUEJMeXpTclpTaHh2Tkljb0dhdGRGbkVfbTZEUVlhdTVuUWg4T0V6cExMbjA2Vm1JV2FiOTBVa1NnaEo0UTBjZ2JfcFg1ekxkUWkxUks1U1ZTUHpWUSIsIm1hYyI6Inh5WXNQRC81SENxR3pQeEt3VkhhTDFRemc5TTgyYUllRUJlNFk2akV4MlF2U2k1dWVMSWdjRVJibzh3WkZ1V3VwQ2JUUkxHb3NlOGFHZlVSSVhjdHRrWWUrN3pYUkJIendLQXhPNzBnU2J2VDNYd1MydDF3dzRJY0tTbTlWcnVrc0ZxUUFXdWFHWXIwY0h2bzQwWStNa1QrSkRkQ0VXWVErK1hVY1FvSTE0c2tqTENOOVlxZ1lRVFY5Q3V2NzErbkhvVWpPNCsvaFFPeFFHREpUaktTb2xEVG96V3U4L05qb0VFRVN4elRvaEZqdEZrczlCMkZtQ25OWEV6OFphNXlTc1F2V2Z0NXAvUGlQZ0pBalRSdFAwUTg4cG9rWENoZnpHZ1NtcXNmU3ZsSndrRmlRRWNxYlVzMzZXQk1WaGNabHQ4dGxUNjdXcXQvWXJZREtsR1lRQT09In0=\" />\r\n\r\n</div>\r\n\r\n<script type='text/javascript'>var frm = document.getElementById('step1Form');frm.action = 'https://goguvenliodeme.bkm.com.tr/troy/approve' ;frm.method = \"POST\";frm.submit();</script>\r\n    \r\n<div class=\"aspNetHidden\">\r\n\r\n\t<input type=\"hidden\" name=\"__VIEWSTATEGENERATOR\" id=\"__VIEWSTATEGENERATOR\" value=\"BFED9D85\" />\r\n</div></form>\r\n</body>\r\n</html>\r\n";

    final response = await helper.postGuven(
      R.endpoints.doPackagePaymentPath,
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
      throw Exception('/doPackagePayment : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> registerStep2Ui(
    UserRegistrationStep2Model userRegistrationStep2,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.registerStep2UiPath,
      userRegistrationStep2.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/registerStep2Ui : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> registerStep2WithOutTc(
    UserRegistrationStep2Model userRegistrationStep2,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.registerStep2WithOutTcPath,
      userRegistrationStep2.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/registerStep2WithOutTc : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> registerStep3Ui(
    UserRegistrationStep3Model userRegistrationStep3,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.registerStep3UiPath,
      userRegistrationStep3.toJson(),
      options: authOptions,
    );
    return response;
  }

  @override
  Future<GuvenResponseModel> registerStep3WithOutTc(
    UserRegistrationStep3Model userRegistrationStep3,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.registerStep3WithOutTcPath,
      userRegistrationStep3.toJson(),
      options: authOptions,
    );
    return response;
  }

  @override
  Future<GuvenResponseModel> updateUserSystemName(String identityNumber) async {
    final response = await helper.postGuven(
      R.endpoints.updateUserSystemNamePath,
      {'identityNumber': identityNumber},
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/updateUserSystemName : ${response.isSuccessful}');
    }
  }

  @override
  Future<UserAccount> getUserProfile() async {
    final response = await helper.getGuven(
      R.endpoints.getUserProfilePath,
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      final result = UserAccount.fromJson(response.xGetMap);
      return result;
    } else {
      throw Exception('/getUserProfile : ${response.isSuccessful}');
    }
  }

  @override
  Future<Map<String, dynamic>> getActiveStream() async {
    final response = await helper.getGuven(
      R.endpoints.getActiveStreamPath,
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response.xGetMap;
    } else {
      throw Exception('/getActiveStream : ${response.isSuccessful}');
    }
  }

  @override
  Future<String> getProfilePicture() async {
    final response = await helper.getGuven(
      R.endpoints.getProfilePicturePath,
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      final datum = response.datum as String?;
      if (datum != null) {
        return datum;
      }

      throw Exception('/getProfilePicture : ${response.isSuccessful}');
    } else {
      throw Exception('/getProfilePicture : ${response.isSuccessful}');
    }
  }

  @override
  Future<ApplicationVersionResponse> getCurrentApplicationVersion() async {
    final response = await helper.getGuven(
      R.endpoints.getCurrentApplicationVersionPath,
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return ApplicationVersionResponse.fromJson(response.xGetMap);
    } else {
      throw Exception(
        '/getCurrentApplicationVersion : ${response.isSuccessful}',
      );
    }
  }

  @override
  Future<PatientResponse> getPatientDetail(String url) async {
    final response = await helper.postGuven(url, {}, options: authOptions);
    if (response.xIsSuccessful) {
      final patient = PatientResponse.fromJson(response.xGetMap);
      if (patient.id == 0) {
        patient.id = null;
      }
      await getIt<UserNotifier>().setPatient(patient);
      return patient;
    } else {
      throw Exception('/getPatientDetail : ${response.isSuccessful}');
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
      throw Exception('/filterTenants : ${response.isSuccessful}');
    }
  }

  @override
  Future<List<FilterDepartmentsResponse>> filterDepartments(
    FilterDepartmentsRequest filterDepartmentsRequest,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.filterDepartmentsPath,
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
      throw Exception('/filterDepartments : ${response.isSuccessful}');
    }
  }

  @override
  Future<List<FilterResourcesResponse>> filterResources(
    FilterResourcesRequest filterResourcesRequest,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.filterResourcesPath,
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
      throw Exception('/filterResources : ${response.isSuccessful}');
    }
  }

  @override
  Future<DoctorCvResponse> getDoctorCvDetails(String doctorWebID) async {
    final response =
        await helper.dioGet(R.endpoints.getDoctorCvDetailsPath(doctorWebID));
    if (response == null) {
      throw Exception('Doctor CV Empty');
    }

    if (response is Map<String, dynamic>) {
      try {
        final doctorCv = DoctorCvResponse.fromJson(response);
        if ((doctorCv.id ?? -1) != -1) {
          return doctorCv;
        } else {
          throw Exception('Doctor CV Empty');
        }
      } on Exception {
        throw Exception('Doctor CV Empty');
      }
    }

    throw Exception('/getDoctorCvDetails');
  }

  @override
  Future<List<GetEventsResponse>> getEvents(
    GetEventsRequest getEventsRequest,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.getEventsPath,
      getEventsRequest.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      final getEventsResponseList = <GetEventsResponse>[];
      final mapDatum = response.xGetMap;
      final resourceEvents = mapDatum['resourceEvents'] as List<dynamic>?;
      final resourceMapEvents = resourceEvents?.map((e) => e).cast<Map<String, dynamic>>().toList();
      if (resourceMapEvents is List<Map<String, dynamic>>) {
        for (final data in resourceMapEvents) {
          final getEventsResponse = GetEventsResponse.fromJson(data);
          getEventsResponseList.add(getEventsResponse);
        }
        return getEventsResponseList;
      }

      throw Exception('/getEvents : ${response.isSuccessful}');
    } else {
      throw Exception('/getEvents : ${response.isSuccessful}');
    }
  }

  @override
  Future<List<GetEventsResponse>> findResourceClosestAvailablePlan(
    ResourceForAvailablePlanRequest resourceForAvailablePlanRequest,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.findResourceClosestAvailablePlanPath,
      resourceForAvailablePlanRequest.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      final result = response.xGetMapList
          .map((item) => GetEventsResponse.fromJson(item))
          .cast<GetEventsResponse>()
          .toList();
      return result;
    } else {
      throw Exception(
        '/findResourceClosestAvailablePlan : ${response.isSuccessful}',
      );
    }
  }

  @override
  Future<int> saveAppointment(AppointmentRequest appointmentRequest) async {
    final response = await helper.postGuven(
      R.endpoints.saveAppointmentPath,
      appointmentRequest.toJson(),
      options: authOptions,
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
      throw Exception('/saveAppointment : ${response.isSuccessful}');
    }
  }

  @override
  Future<PatientRelativeInfoResponse> getAllRelatives(
    GetAllRelativesRequest bodyPages,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.getAllRelativesPath,
      bodyPages.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return PatientRelativeInfoResponse.fromJson(response.xGetMap);
    } else {
      throw Exception('/getAllRelatives : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> getCountries() async {
    final response = await helper.postGuven(
      R.endpoints.getCountriesPath,
      {},
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/getCountries : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> forgotPasswordUi(
    UserRegistrationStep1Model userRegistrationStep1,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.forgotPasswordUiPath,
      userRegistrationStep1.toJson(),
      options: emptyAuthOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/forgotPasswordUi : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> changePasswordUi(
    ChangePasswordModel changePasswordModel,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.changePasswordUiPath,
      changePasswordModel.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/changePasswordUi : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> updateContactInfo(
    ChangeContactInfoRequest changeContactInfo,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.updateContactInfoPath,
      changeContactInfo.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/updateContactInfo : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> changeUserPasswordUi(
    String oldPassword,
    String password,
  ) async {
    final response = await helper.getGuven(
      R.endpoints.changeUserPasswordUiPath(oldPassword, password),
      options: authOptions,
    );
    return response;
  }

  @override
  Future<GuvenResponseModel> addFirebaseTokenUi(
    AddFirebaseTokenRequest addFirebaseToken,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.addFirebaseTokenUiPath,
      addFirebaseToken.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/addFirebaseTokenUi : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> patientCallMeUi() async {
    final response = await helper.getGuven(
      R.endpoints.patientCallMeUiPath,
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/patientCallMeUi : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> getRoomStatusUi(String roomId) async {
    final response = await helper.getGuven(
      R.endpoints.getRoomStatusUiPath(roomId),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/getRoomStatusUi/$roomId : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> getOnlineAppoFiles(String roomId) async {
    final response = await helper.getGuven(
      R.endpoints.getOnlineAppoFilesPath(roomId),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/getOnlineAppoFiles/$roomId : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> deleteOnlineAppoFile(
    String webAppoId,
    String fileName,
  ) async {
    final response = await helper.deleteGuven(
      R.endpoints.deleteOnlineAppoFilePath(webAppoId, fileName),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception(
        '/deleteOnlineAppoFile/$webAppoId/$fileName : ${response.isSuccessful}',
      );
    }
  }

  @override
  Future<GuvenResponseModel> getAllTranslator() async {
    final response = await helper.getGuven(
      R.endpoints.getAllTranslatorPath,
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/getAllTranslator : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> getUserKvkkInfo() async {
    final response = await helper.getGuven(
      R.endpoints.getUserKvkkInfoPath,
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/getUserKvkkInfo : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> updateUserKvkkInfo() async {
    final response = await helper.getGuven(
      R.endpoints.updateUserKvkkInfoPath,
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/updateUserKvkkInfo : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> addSuggestion(
    SuggestionRequest suggestionRequest,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.addSuggestionPath,
      suggestionRequest.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/addSuggestion : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> setYoutubeSurveyUser(
    YoutubeSurveyUserRequest bodyPages,
  ) async {
    final $headers = {
      'mobileapiauthkey':
          'b776be7e007b40d38f1f4b73bb53481cf946c0d21c5b4ad7a0842bc1be2b70ce',
    };
    final response = await helper.postGuven(
      R.endpoints.setYoutubeSurveyUserPath,
      bodyPages.toJson(),
      options: authOptions..headers?.addAll($headers),
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/setYoutubeSurveyUser : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> getCourseId() async {
    final response = await helper.getGuven(
      R.endpoints.getCourseIdPath,
      options: authOptions..headers?.addAll(getCourseHeader),
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/getCourseId : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> setJitsiWebConsultantId(
    String webConsultantId,
  ) async {
    final response = await helper.getGuven(
      R.endpoints.setJitsiWebConsultantIdPath(webConsultantId),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception(
        '/setJitsiWebConsultantId/$webConsultantId : ${response.isSuccessful}',
      );
    }
  }

  @override
  Future<GuvenResponseModel> deleteProfilePicture() async {
    final response = await helper.deleteGuven(
      R.endpoints.deleteProfilePicturePath,
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/deleteProfilePicture : ${response.isSuccessful}');
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
      R.endpoints.uploadProfilePicturePath,
      formData,
      options: authOptions..headers?.addAll($headers),
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/uploadProfilePicture : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> downloadAppointmentSingleFile(
    String folder,
    String path,
  ) async {
    final response = await helper.getGuven(
      R.endpoints.downloadAppointmentSingleFilePath(folder, path),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception(
        '/downloadAppointmentSingleFile : ${response.isSuccessful}',
      );
    }
  }

  @override
  Future<GuvenResponseModel> getAllFiles() async {
    final response = await helper.getGuven(
      R.endpoints.getAllFilesPath,
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/getAllFiles : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> downloadAppointmentFile(
    String id,
    String name,
  ) async {
    final response = await helper.getGuven(
      R.endpoints.downloadAppointmentFilePath(id, name),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/downloadAppointmentFile : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> removePatientRelative(String id) async {
    final response = await helper.deleteGuven(
      R.endpoints.removePatientRelativePath(id),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/removePatientRelative : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> getRelativeRelationships() async {
    final response = await helper.getGuven(
      R.endpoints.getRelativeRelationshipsPath,
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/getRelativeRelationships : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> changeActiveUserToRelative(String id) async {
    final response = await helper.getGuven(
      R.endpoints.changeActiveUserToRelativePath(id),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception(
        '/changeActiveUserToRelative/$id : ${response.isSuccessful}',
      );
    }
  }

  @override
  Future<GuvenResponseModel> clickPost(int postId) async {
    final response = await helper.getGuven(
      R.endpoints.clickPostPath(postId),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/clickPost/$postId : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> filterSocialPosts(String search) async {
    final response = await helper.getGuven(
      R.endpoints.filterSocialPostsPath(search),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/filterSocialPosts/$search : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> filterSocialPlatform(String search) async {
    final response = await helper.getGuven(
      R.endpoints.filterSocialPostsPlatform(search),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception(
        '/filterSocialPostsPlatform/$search : ${response.isSuccessful}',
      );
    }
  }

  @override
  Future<List<BannerTabsModel>> getBannerTab(
    String applicationName,
    String groupName,
  ) async {
    final response = await helper.getGuven(
      R.endpoints.getBannerTab(applicationName, groupName),
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
      throw Exception(
        '/getBannerTab/$applicationName/$groupName : ${response.isSuccessful}',
      );
    }
  }

  @override
  Future<GuvenResponseModel> socialResource() async {
    final response = await helper.getGuven(
      R.endpoints.socialResourcePath,
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/socialResource : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> getAppointmentTypeViaWebConsultantId() async {
    final response = await helper.getGuven(
      R.endpoints.getAppointmentTypeViaWebConsultantIdPath,
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception(
        '/getAppointmentTypeViaWebConsultantId : ${response.isSuccessful}',
      );
    }
  }

  @override
  Future<GuvenResponseModel> requestTranslator(
    String appoId,
    TranslatorRequest translatorPost,
  ) async {
    final response = await helper.patchGuven(
      R.endpoints.requestTranslatorPath(appoId),
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
      R.endpoints.uploadFileToAppoPath(webAppoId),
      formData,
      options: authOptions..headers?.addAll($headers),
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/uploadFileToAppo : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> registerStep1Ui(
    RegisterStep1PusulaModel userRegistrationStep1,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.registerStep1UiPath,
      userRegistrationStep1.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/registerStep1Ui : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> registerStep1WithOutTc(
    UserRegistrationStep1Model userRegistrationStep1,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.registerStep1WithOutTcPath,
      userRegistrationStep1.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/registerStep1WithOutTc : ${response.isSuccessful}');
    }
  }

  @override
  Future<List<VisitResponse>> getVisits(VisitRequest visitRequestBody) async {
    final response = await helper.postGuven(
      R.endpoints.getVisitsPath,
      visitRequestBody.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response.xGetMapList
          .map((e) => VisitResponse.fromJson(e))
          .cast<VisitResponse>()
          .toList();
    } else {
      throw Exception('/getVisits : ${response.isSuccessful}');
    }
  }

  @override
  Future<List<LaboratoryResponse>> getLaboratoryResults(
    VisitDetailRequest detailRequest,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.getLaboratoryResultsPath,
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
      throw Exception('/getLaboratoryResults : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> rateOnlineCall(
    CallRateRequest callRateRequest,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.rateOnlineCallPath,
      callRateRequest.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/rateOnlineCall : ${response.isSuccessful}');
    }
  }

  @override
  Future<List<RadiologyResponse>> getRadiologyResults(
    VisitDetailRequest detailRequest,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.getRadiologyResultsPath,
      detailRequest.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response.xGetMapList
          .map((e) => RadiologyResponse.fromJson(e))
          .cast<RadiologyResponse>()
          .toList();
    } else {
      throw Exception('/getRadiologyResults : ${response.isSuccessful}');
    }
  }

  @override
  Future<List<PathologyResponse>> getPathologyResults(
      VisitDetailRequest detailRequest) async {
    final response = await helper.postGuven(
      R.endpoints.getPathologyResultsPath,
      detailRequest.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response.xGetMapList
          .map((e) => PathologyResponse.fromJson(e))
          .cast<PathologyResponse>()
          .toList();
    } else {
      throw Exception('/getPathologyResults : ${response.isSuccessful}');
    }
  }

  @override
  Future<String> getLaboratoryPdfResult(
    LaboratoryPdfResultRequest laboratoryPdfResultRequest,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.getLaboratoryPdfResultPath,
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
      throw Exception('/getLaboratoryPdfResult : ${response.isSuccessful}');
    }
  }

  @override
  Future<String> getRadiologyPdfResult(
    RadiologyPdfRequest radiologyPdfResultRequest,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.getRadiologyPdfResultPath,
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
      throw Exception('/getRadiologyPdfResult : ${response.isSuccessful}');
    }
  }

  @override
  Future<List<PatientAppointmentsResponse>> getPatientAppointments(
    PatientAppointmentRequest patientAppointmentRequest,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.getPatientAppointmentsPath,
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
      throw Exception('/getPatientAppointments : ${response.isSuccessful}');
    }
  }

  @override
  Future<bool> cancelAppointment(
    CancelAppointmentRequest cancelAppointmentRequest,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.cancelAppointmentPath,
      cancelAppointmentRequest.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return true;
    } else {
      throw Exception('/cancelAppointment : ${response.isSuccessful}');
    }
  }

  @override
  Future<GetVideoCallPriceResponse> getResourceVideoCallPrice(
    GetVideoCallPriceRequest getVideoCallPriceRequest,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.getResourceVideoCallPricePath,
      getVideoCallPriceRequest.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return GetVideoCallPriceResponse.fromJson(response.xGetMap);
    } else {
      throw Exception('/getResourceVideoCallPrice : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> doMobilePayment(
    DoMobilePaymentRequest doMobilePaymentRequest,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.doMobilePaymentPath,
      doMobilePaymentRequest.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/doMobilePayment : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> doMobilePaymentWithVoucher(
    DoMobilePaymentWithVoucherRequest doMobilePaymentWithVoucherRequest,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.doMobilePaymentWithVoucher,
      doMobilePaymentWithVoucherRequest.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/doMobilePaymentWithVoucher : ${response.isSuccessful}');
    }
  }

  @override
  Future<List<FilterDepartmentsResponse>> fetchOnlineDepartments(
    FilterOnlineDepartmentsRequest filterOnlineDepartmentsRequest,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.fetchOnlineDepartmentsPath,
      filterOnlineDepartmentsRequest.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response.xGetMapList
          .map((e) => FilterDepartmentsResponse.fromJson(e))
          .cast<FilterDepartmentsResponse>()
          .toList();
    } else {
      throw Exception('/fetchOnlineDepartments : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> checkOnlineAppointmentPayment(
    CheckPaymentRequest request,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.checkOnlineAppointmentPaymentPath,
      request.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception(
        '/checkOnlineAppointmentPayment : ${response.isSuccessful}',
      );
    }
  }

  @override
  Future<GetAvailabilityRateResponse> getAvailabilityRate(
    GetAvailabilityRateRequest getAvailabilityRateRequest,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.getAvailabilityRatePath,
      getAvailabilityRateRequest.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return GetAvailabilityRateResponse.fromJson(response.xGetMap);
    } else {
      throw Exception('/getAvailabilityRate : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> addNewPatientRelative(
      AddPatientRelativeRequest addPatientRelative) async {
    final response = await helper.postGuven(
      R.endpoints.addNewPatientRelativePath,
      addPatientRelative.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/addNewPatientRelative : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> uploadPatientDocuments(
    String webAppoId,
    Uint8List file,
  ) async {
    final $headers = {'Content-Type': 'multipart/formdata'};
    final FormData formData = FormData.fromMap({
      "file": MultipartFile.fromBytes(file),
    });
    final response = await helper.postGuven(
      R.endpoints.uploadPatientDocumentsPath(webAppoId),
      formData,
      options: authOptions..headers?.addAll($headers),
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/uploadPatientDocuments : ${response.isSuccessful}');
    }
  }

  @override
  Future<List<AvailableDate>> findResourceAvailableDays(
    FindResourceAvailableDaysRequest findResourceAvailableDaysRequest,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.findResourceAvailableDays,
      findResourceAvailableDaysRequest.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response.xGetMapList
          .map((item) => AvailableDate.fromJson(item))
          .cast<AvailableDate>()
          .toList();
    } else {
      throw Exception('/findResourceAvailableDays : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> getResourceVideoCallPriceVoucher(
    VoucherPriceRequest voucherPriceRequest,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.getResourceVideoCallPriceWithVoucher,
      voucherPriceRequest.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception(
        '/getResourceVideoCallPriceVoucher : ${response.isSuccessful}',
      );
    }
  }

  @override
  Future<GuvenResponseModel> getChatContacts() async {
    final response = await helper.postGuven(
      R.endpoints.getChatContacts,
      {'isActiveChats': 'true'},
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/getChatContacts : ${response.isSuccessful}');
    }
  }

  @override
  Future<GuvenResponseModel> sendNotification(
    ChatNotificationModel model,
  ) async {
    final response = await helper.postGuven(
      R.endpoints.sendNotification,
      model.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/sendNotification : ${response.isSuccessful}');
    }
  }
}
