import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

import '../../features/shared/consent_form/consent_form_dialog.dart';
import '../../features/shared/rate_dialog/rate_dialog.dart';
import '../../model/model.dart';
import '../core.dart';

abstract class UserManager {
  Future<RbioLoginResponse> login(String userName, String password);
  Future<void> saveLoginInfo(
      String userName, String password, bool rememberMeChecked, String token);
  Future<UserLoginInfo> getSavedLoginInfo();
  Future updateIdentityNumber(String identityNumber);
  Future changeLoginUserParameter(String identityNumber);
  Future refreshToken();
  Future getUserProfile();
  Future updateIdentityOps(String identityNumber);
  Future getAllTranslator();
  Future requestTranslator(
      String appointmentId, TranslatorRequest translatorPost);
  Future<String> getAppointmentType(String roomId);
  Future checkOnlineMeetingAccessible(String roomId);
  Future startMeeting(
      BuildContext context, String webConsultantId, int availabilityId);
  Future setOnlineAppointmentMobileEntrance(String webConsultantId);
  Future setApplicationConsentFormState(bool isChecked);
  bool getApplicationConsentFormState();
  Future setKvkkFormState(bool isChecked);
  Future getKvkkFormState();
  Future<List<SocialPostsResponse>> getSocialPostWithTagsByText(String text);
  Future<List<SocialPostsResponse>> getAllSocialResources();
  Future<GuvenResponseModel> clickPost(int postId);
}

class UserManagerImpl extends UserManager {
  @override
  Future<RbioLoginResponse> login(String userName, String password) async {
    final response = await getIt<Repository>().login(userName, password);
    await getIt<ISharedPreferencesManager>()
        .setString(SharedPreferencesKeys.JWT_TOKEN, response.token.accessToken);
    getIt<UserNotifier>().firebaseEmail = response.firebase_user_email;
    getIt<UserNotifier>().firebasePassword = response.firebase_user_salt;
    getIt<FirestoreManager>().loginFirebase();
    //Update user notifier depending on roles
    getIt<UserNotifier>().userTypeFetcher(response);
    return response;
  }

  @override
  Future<void> saveLoginInfo(String userName, String password,
      bool rememberMeChecked, String token) async {
    if (rememberMeChecked) {
      await getIt<ISharedPreferencesManager>()
          .setString(SharedPreferencesKeys.LOGIN_USERNAME, userName);
      await getIt<ISharedPreferencesManager>()
          .setString(SharedPreferencesKeys.LOGIN_PASSWORD, password);
    } else {
      await getIt<ISharedPreferencesManager>()
          .setString(SharedPreferencesKeys.LOGIN_USERNAME, userName);
      await getIt<ISharedPreferencesManager>()
          .setString(SharedPreferencesKeys.LOGIN_PASSWORD, "");
    }

    await getIt<ISharedPreferencesManager>()
        .setString(SharedPreferencesKeys.JWT_TOKEN, token);
  }

  @override
  Future<UserLoginInfo> getSavedLoginInfo() async {
    UserLoginInfo userLoginInfo = UserLoginInfo();
    String username = getIt<ISharedPreferencesManager>()
        .getString(SharedPreferencesKeys.LOGIN_USERNAME);
    userLoginInfo.username = username;
    String password = getIt<ISharedPreferencesManager>()
        .getString(SharedPreferencesKeys.LOGIN_PASSWORD);
    userLoginInfo.password = password;
    return userLoginInfo;
  }

  @override
  Future updateIdentityNumber(String identityNumber) async {
    var response =
        await getIt<Repository>().updateUserSystemName(identityNumber);
    if (response.datum == 10) {
      return response.datum;
    } else if (response.datum == 5) {
      throw 5;
    } else {
      throw response.datum ?? "";
    }
  }

  @override
  Future changeLoginUserParameter(String identityNumber) async {
    final token =
        getIt<ISharedPreferencesManager>().get(SharedPreferencesKeys.JWT_TOKEN);
    UserLoginInfo userLoginInfo = await getSavedLoginInfo();
    saveLoginInfo(identityNumber, userLoginInfo.password,
        userLoginInfo.password.isEmpty ? false : true, token);
  }

  @override
  Future refreshToken() async {
    final token =
        getIt<ISharedPreferencesManager>().get(SharedPreferencesKeys.JWT_TOKEN);
    UserLoginInfo userLoginInfo = await getSavedLoginInfo();
    await login(
        userLoginInfo.username,
        getIt<ISharedPreferencesManager>()
            .getString(SharedPreferencesKeys.LOGIN_PASSWORD));
    await saveLoginInfo(userLoginInfo.username, userLoginInfo.password,
        userLoginInfo.password.isEmpty ? false : true, token);
  }

  @override
  Future getUserProfile() async {
    final response = await getIt<Repository>().getUserProfile();
    await getIt<UserNotifier>().setUserAccount(response);
  }

  @override
  Future updateIdentityOps(String identityNumber) async {
    await updateIdentityNumber(identityNumber);
    await changeLoginUserParameter(identityNumber);
    await refreshToken();
    await getUserProfile();
  }

  @override
  Future getAllTranslator() async {
    var response = await getIt<Repository>().getAllTranslator();
    List<TranslatorResponse> translators = <TranslatorResponse>[];
    var data = response.datum;
    for (var data1 in data) {
      translators.add(TranslatorResponse.fromJson(data1));
    }
    return translators;
  }

  @override
  Future requestTranslator(
      String appointmentId, TranslatorRequest translatorPost) async {
    await getIt<Repository>().requestTranslator(appointmentId, translatorPost);
    return true;
  }

  @override
  Future<String> getAppointmentType(String roomId) async {
    String streamType = "Jitsi";
    try {
      final responseForType =
          await getIt<Repository>().getAppointmentTypeViaWebConsultantId();
      var datum = responseForType.datum;
      StreamType streamTypeResponse = new StreamType.fromJson(datum);
      streamType = streamTypeResponse.provider;
      return streamType;
    } catch (_) {
      return streamType;
    }
  }

  @override
  Future checkOnlineMeetingAccessible(String roomId) async {
    final streamType = await getAppointmentType(roomId);
    var response = await getIt<Repository>().getRoomStatusUi(roomId);
    final datum = response.datum;
    if (streamType == "Zoom" && datum != -1) {
      return true;
    } else if (datum == 5) {
      return true;
    } else if (datum == -1) {
      //ödemesi yapılmamış girilemez.
      throw Exception("show" + LocaleProvider.current.online_appo_error_eksi1);
    } else if (datum == 0) {
      //daha önce bitmiş girilemez
      throw Exception("show" + LocaleProvider.current.online_appo_error_0);
    } else if (datum == 1) {
      //erken geldi açılmaz
      throw Exception("show" + LocaleProvider.current.online_appo_error_1);
    } else if (datum == 2) {
      //oda açılır doktor beklenir
      return true;
    } else if (datum == 3) {
      //geç geldi oda açılır
      return true;
    } else if (datum == 4) {
      //geç geldi oda açılmaz.
      throw Exception("show" + LocaleProvider.current.online_appo_error_4);
    }
  }

  @override
  Future startMeeting(
    BuildContext context,
    String webConsultantId,
    int availabilityId,
  ) async {
    final token =
        getIt<ISharedPreferencesManager>().get(SharedPreferencesKeys.JWT_TOKEN);
    String streamType = "Jitsi";

    if (streamType == "Zoom") {
      // ZoomOptions zoomOptions = new ZoomOptions(
      //   domain: "zoom.us",
      //   appKey: R.strings.zoom_app_key,
      //   appSecret: R.strings.zoom_app_secret,
      // );

      // // Setting Zoom meeting options (default to false if not set)
      // ZoomMeetingOptions meetingOptions = new ZoomMeetingOptions(
      //     userId: parseJwtPayLoad(token)['name'] != null
      //         ? parseJwtPayLoad(token)['name']
      //         : parseJwtPayLoad(token)['fullname'],
      //     meetingId: webConsultantId,
      //     meetingPassword: R.strings.zoomMeetingRoomPass,
      //     disableDialIn: "true",
      //     disableDrive: "true",
      //     disableInvite: "true",
      //     disableShare: "true",
      //     noAudio: "false",
      //     noDisconnectAudio: "false");
      // Get.rootDelegate
      //     .toNamed('MeetingPage', arguments: {meetingOptions, zoomOptions});
    } else {
      String name = parseJwtPayLoad(token)['name'] != null
          ? parseJwtPayLoad(token)['name']
          : parseJwtPayLoad(token)['fullname'];
      print("toplantı başlıyooor " + webConsultantId);
      var options = JitsiMeetingOptions(room: webConsultantId)
// Required, spaces will be trimmed
        ..serverURL = "https://stream.guven.com.tr/"
        ..subject = " "
        ..userDisplayName = name
        ..userEmail = " "
        ..audioOnly = false
        ..audioMuted = false
        ..webOptions = {
          "roomName": "${webConsultantId}",
          "width": "100%",
          "height": "100%",
          "enableWelcomePage": false,
          "chromeExtensionBanner": null,
          "interfaceConfigOverwrite": {
            "DEFAULT_BACKGROUND": '#000000',
          },
          "userInfo": {"displayName": "${name}"}
        }
        ..videoMuted = false;
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return ConsentFormDialog(
              title: LocaleProvider.current.approve_consent_form,
              text: LocaleProvider.current.application_consent_form_text,
              alwaysAsk: true,
            );
          }).then((value) async {
        if (value != null && value) {
          await JitsiMeet.joinMeeting(
            options,
            listener: JitsiMeetingListener(
              onConferenceWillJoin: (message) {
                debugPrint("${options.room} will join with message: $message");
              },
              onConferenceJoined: (message) {
                debugPrint("${options.room} joined with message: $message");
              },
              onConferenceTerminated: (message) async {
                await showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return RateDialog(
                        availabilityId: availabilityId,
                      );
                    });
                debugPrint("${options.room} terminated with message: $message");
              },
            ),
          );

          setOnlineAppointmentMobileEntrance(webConsultantId);
        } else if (value != null && !value) {}
      });
    }
  }

  @override
  Future setOnlineAppointmentMobileEntrance(String webConsultantId) async {
    await getIt<Repository>().setJitsiWebConsultantId(webConsultantId);
  }

  @override
  Future setApplicationConsentFormState(bool isChecked) async {
    if (isChecked) {
      await getIt<ISharedPreferencesManager>()
          .setBool(SharedPreferencesKeys.APPLICATION_CONSENT_FORM, true);
    } else {
      await getIt<ISharedPreferencesManager>()
          .setBool(SharedPreferencesKeys.APPLICATION_CONSENT_FORM, false);
    }
  }

  @override
  bool getApplicationConsentFormState() {
    if (getIt<ISharedPreferencesManager>()
            .getBool(SharedPreferencesKeys.APPLICATION_CONSENT_FORM) !=
        null) {
      return getIt<ISharedPreferencesManager>()
          .getBool(SharedPreferencesKeys.APPLICATION_CONSENT_FORM);
    } else {
      return false;
    }
  }

  @override
  Future setKvkkFormState(bool isChecked) async {
    if (isChecked) {
      try {
        await getIt<Repository>().updateUserKvkkInfo();
        // if the user didn't get the token then try until they get the token
        await Future.delayed(Duration(seconds: 5));
        setKvkkFormState(isChecked);
      } on Exception {
        //
      }
    } else {
      // Need api for user discard for kvkk approve
    }
  }

  @override
  Future getKvkkFormState() async {
    try {
      var response = await getIt<Repository>().getUserKvkkInfo();
      var datum = response.datum;
      KvkkApproveResponse kvkkApproveResponse = KvkkApproveResponse();
      kvkkApproveResponse = KvkkApproveResponse.fromJson(datum);
      return kvkkApproveResponse.isKVKKAprovved;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<List<SocialPostsResponse>> getSocialPostWithTagsByText(
      String text) async {
    var response = await getIt<Repository>().filterSocialPosts(text);
    List<SocialPostsResponse> filteredSocialResources = <SocialPostsResponse>[];
    var datum = response.datum;
    for (var data in datum) {
      final filteredSocialResponse = SocialPostsResponse.fromJson(data);
      filteredSocialResources.add(filteredSocialResponse);
    }
    return filteredSocialResources;
  }

  @override
  Future<List<SocialPostsResponse>> getAllSocialResources() async {
    var response = await getIt<Repository>().socialResource();
    List<SocialPostsResponse> allSocialResources = <SocialPostsResponse>[];
    var datum = response.datum;
    for (var data in datum) {
      final allSocialPostsResponse = SocialPostsResponse.fromJson(data);
      allSocialResources.add(allSocialPostsResponse);
    }
    return allSocialResources;
  }

  @override
  Future<GuvenResponseModel> clickPost(int postId) =>
      getIt<Repository>().clickPost(postId);
}
