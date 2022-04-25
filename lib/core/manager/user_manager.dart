import 'package:flutter/material.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';

import '../../features/auth/model/login_exception.dart';
import '../../features/shared/consent_form/consent_form_dialog.dart';
import '../../features/shared/rate_dialog/rate_dialog.dart';
import '../../model/model.dart';
import '../core.dart';

abstract class UserManager {
  Future<RbioLoginResponse> login(String userName, String password);
  Future<void> saveLoginInfo(
    String userName,
    String password,
    bool rememberMeChecked,
    String token,
  );
  UserLoginInfo getSavedLoginInfo();
  Future updateIdentityNumber(String identityNumber);
  Future changeLoginUserParameter(String identityNumber);
  Future refreshToken();
  Future getUserProfile();
  Future updateIdentityOps(String identityNumber);
  Future getAllTranslator();
  Future requestTranslator(
    String appointmentId,
    TranslatorRequest translatorPost,
  );
  Future<String> getAppointmentType(String roomId);
  Future checkOnlineMeetingAccessible(String roomId);
  Future startMeeting(
    BuildContext context,
    String webConsultantId,
    int availabilityId,
  );
  Future setOnlineAppointmentMobileEntrance(String webConsultantId);
  Future setApplicationConsentFormState(bool isChecked);
  bool getApplicationConsentFormState();
  Future setKvkkFormState(bool isChecked);
  Future<bool> getKvkkFormState();
  Future<List<SocialPostsResponse>> getSocialPostWithTagsByText(String text);
  Future<List<SocialPostsResponse>> getAllSocialResources();
  Future<List<SocialPostsResponse>> getPostsWithByTagsByPlatform(String text);
  Future<GuvenResponseModel> clickPost(int postId);
}

class UserManagerImpl extends UserManager {
  @override
  Future<RbioLoginResponse> login(String userName, String password) async {
    var either = await getIt<Repository>().login(userName, password);
    return either.fold(
      (response) async {
        final loginResponse =
            response.xGetModel<RbioLoginResponse, RbioLoginResponse>(
                RbioLoginResponse());
        if (loginResponse != null) {
          if (loginResponse.ssoResponse?.accessToken != null) {
            await getIt<ISharedPreferencesManager>().setString(
              SharedPreferencesKeys.jwtToken,
              loginResponse.ssoResponse!.accessToken!,
            );

            loginToFirebase(loginResponse);
            //Update user notifier depending on roles
            getIt<UserNotifier>().userTypeFetcher(loginResponse);
            return loginResponse;
          }
        }

        throw const LoginExceptions.undefined();
      },
      (error) {
        throw error;
      },
    );
  }

  Future<void> loginToFirebase(RbioLoginResponse? response) async {
    getIt<UserNotifier>().firebaseEmail = response?.firebaseUserEmail;
    getIt<UserNotifier>().firebasePassword = response?.firebaseUserSalt;
    await getIt<FirestoreManager>().loginFirebase();
  }

  @override
  Future<void> saveLoginInfo(
    String userName,
    String password,
    bool rememberMeChecked,
    String token,
  ) async {
    await getIt<ISharedPreferencesManager>()
        .setString(SharedPreferencesKeys.loginUserName, userName);
    if (rememberMeChecked) {
      await getIt<ISharedPreferencesManager>()
          .setString(SharedPreferencesKeys.loginPassword, password);
    } else {
      await getIt<ISharedPreferencesManager>()
          .setString(SharedPreferencesKeys.loginPassword, "");
    }

    await getIt<ISharedPreferencesManager>()
        .setString(SharedPreferencesKeys.jwtToken, token);
  }

  @override
  UserLoginInfo getSavedLoginInfo() {
    final UserLoginInfo userLoginInfo = UserLoginInfo();
    final String? username = getIt<ISharedPreferencesManager>()
        .getString(SharedPreferencesKeys.loginUserName);
    userLoginInfo.username = username;
    final String? password = getIt<ISharedPreferencesManager>()
        .getString(SharedPreferencesKeys.loginPassword);
    userLoginInfo.password = password;
    return userLoginInfo;
  }

  @override
  Future updateIdentityNumber(String identityNumber) async {
    final response =
        await getIt<Repository>().updateUserSystemName(identityNumber);
    if (response.datum == 10) {
      return response.datum;
    } else if (response.datum == 5) {
      throw 5;
    } else {
      throw response.datum as Object;
    }
  }

  @override
  Future changeLoginUserParameter(String identityNumber) async {
    final token =
        getIt<ISharedPreferencesManager>().get(SharedPreferencesKeys.jwtToken);
    final UserLoginInfo userLoginInfo = getSavedLoginInfo();
    if (userLoginInfo.password != null && token != null) {
      saveLoginInfo(
        identityNumber,
        userLoginInfo.password!,
        userLoginInfo.password!.isEmpty ? false : true,
        token as String,
      );
    } else {
      throw "There are null data in the saveLoginInfo section!";
    }
  }

  @override
  Future refreshToken() async {
    final token =
        getIt<ISharedPreferencesManager>().get(SharedPreferencesKeys.jwtToken);
    final UserLoginInfo userLoginInfo = getSavedLoginInfo();
    await login(
      userLoginInfo.username as String,
      getIt<ISharedPreferencesManager>()
          .getString(SharedPreferencesKeys.loginPassword) as String,
    );
    if (userLoginInfo.username != null &&
        userLoginInfo.password != null &&
        token != null) {
      await saveLoginInfo(
        userLoginInfo.username!,
        userLoginInfo.password!,
        userLoginInfo.password!.isEmpty ? false : true,
        token as String,
      );
    } else {
      throw "There are null data in the refreshToken section!";
    }
  }

  @override
  Future getUserProfile() async {
    final response = await getIt<Repository>().getUserProfile();
    await getIt<UserNotifier>().setUserAccount(response);
    return response;
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
    final response = await getIt<Repository>().getAllTranslator();
    final List<TranslatorResponse> translators = <TranslatorResponse>[];
    final data = response.datum;
    for (final data1 in data) {
      translators
          .add(TranslatorResponse.fromJson(data1 as Map<String, dynamic>));
    }
    return translators;
  }

  @override
  Future requestTranslator(
    String appointmentId,
    TranslatorRequest translatorPost,
  ) async {
    await getIt<Repository>().requestTranslator(appointmentId, translatorPost);
    return true;
  }

  @override
  Future<String> getAppointmentType(String roomId) async {
    String streamType = "Jitsi";
    try {
      final responseForType =
          await getIt<Repository>().getAppointmentTypeViaWebConsultantId();
      final datum = responseForType.datum;
      final StreamType streamTypeResponse =
          StreamType.fromJson(datum as Map<String, dynamic>);
      if (streamTypeResponse.provider != null) {
        streamType = streamTypeResponse.provider!;
      } else {
        throw "streamTypeResponse.provider is null!";
      }
      return streamType;
    } catch (_) {
      return streamType;
    }
  }

  @override
  Future checkOnlineMeetingAccessible(String roomId) async {
    final streamType = await getAppointmentType(roomId);
    final response = await getIt<Repository>().getRoomStatusUi(roomId);
    final datum = response.datum;
    if (streamType == "Zoom" && datum != -1) {
      return true;
    } else if (datum == 5) {
      return true;
    } else if (datum == -1) {
      //ödemesi yapılmamış girilemez.
      throw Exception("show${LocaleProvider.current.online_appo_error_eksi1}");
    } else if (datum == 0) {
      //daha önce bitmiş girilemez
      throw Exception("show${LocaleProvider.current.online_appo_error_0}");
    } else if (datum == 1) {
      //erken geldi açılmaz
      throw Exception("show${LocaleProvider.current.online_appo_error_1}");
    } else if (datum == 2) {
      //oda açılır doktor beklenir
      return true;
    } else if (datum == 3) {
      //geç geldi oda açılır
      return true;
    } else if (datum == 4) {
      //geç geldi oda açılmaz.
      throw Exception("show${LocaleProvider.current.online_appo_error_4}");
    }
  }

  @override
  Future startMeeting(
    BuildContext context,
    String webConsultantId,
    int availabilityId,
  ) async {
    final token =
        getIt<ISharedPreferencesManager>().get(SharedPreferencesKeys.jwtToken);
    const String streamType = "Jitsi";

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
      final String name =
          Utils.instance.parseJwtPayLoad(token as String)['name'] != null
              ? Utils.instance.parseJwtPayLoad(token)['name'] as String
              : Utils.instance.parseJwtPayLoad(token)['fullname'] as String;

      LoggerUtils.instance.i("Toplantı Başlıyor : $webConsultantId");

      final options = JitsiMeetingOptions(
        roomNameOrUrl: webConsultantId,
        serverUrl: "https://stream.guven.com.tr/",
        subject: " ",
        userDisplayName: name,
        userEmail: " ",
        isAudioOnly: false,
        isAudioMuted: false,
        isVideoMuted: false,
      );

      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return ConsentFormDialog(
            title: LocaleProvider.current.approve_consent_form,
            text: LocaleProvider.current.application_consent_form_text,
            alwaysAsk: true,
          );
        },
      ).then((value) async {
        if (value != null && value as bool) {
          await JitsiMeetWrapper.joinMeeting(
            options: options,
            listener: JitsiMeetingListener(
              onConferenceWillJoin: (message) {
                debugPrint(
                  "${options.roomNameOrUrl} will join with message: $message",
                );
              },
              onConferenceJoined: (message) {
                debugPrint(
                  "${options.roomNameOrUrl} joined with message: $message",
                );
              },
              onConferenceTerminated: (message, _) async {
                await showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return RateDialog(
                      availabilityId: availabilityId,
                    );
                  },
                );
                debugPrint(
                  "${options.roomNameOrUrl} terminated with message: $message",
                );
              },
            ),
          );

          setOnlineAppointmentMobileEntrance(webConsultantId);
        } else if (value != null && !(value as bool)) {}
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
          .setBool(SharedPreferencesKeys.applicationConsentForm, true);
    } else {
      await getIt<ISharedPreferencesManager>()
          .setBool(SharedPreferencesKeys.applicationConsentForm, false);
    }
  }

  @override
  bool getApplicationConsentFormState() {
    try {
      final sharedValue = getIt<ISharedPreferencesManager>()
          .getBool(SharedPreferencesKeys.applicationConsentForm);
      if (sharedValue != null) {
        return sharedValue;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future setKvkkFormState(bool isChecked) async {
    if (isChecked) {
      try {
        await getIt<Repository>().updateUserKvkkInfo();
        // if the user didn't get the token then try until they get the token
        await Future.delayed(const Duration(seconds: 5));
        setKvkkFormState(isChecked);
      } on Exception {
        //
      }
    } else {
      // Need api for user discard for kvkk approve
    }
  }

  @override
  Future<bool> getKvkkFormState() async {
    try {
      final response = await getIt<Repository>().getUserKvkkInfo();
      final datum = response.datum;
      KvkkApproveResponse kvkkApproveResponse = KvkkApproveResponse();
      kvkkApproveResponse =
          KvkkApproveResponse.fromJson(datum as Map<String, dynamic>);
      return kvkkApproveResponse.isKVKKAprovved!;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<List<SocialPostsResponse>> getPostsWithByTagsByPlatform(
    String text,
  ) async {
    final response = await getIt<Repository>().filterSocialPlatform(text);
    final List<SocialPostsResponse> filteredSocialResources =
        <SocialPostsResponse>[];
    final datum = response.datum;
    for (final data in datum) {
      final filteredSocialResponse =
          SocialPostsResponse.fromJson(data as Map<String, dynamic>);
      filteredSocialResources.add(filteredSocialResponse);
    }
     filteredSocialResources.sort((a,b) => a.title!.toLowerCase().compareTo(b.title!.toLowerCase()));
   return filteredSocialResources;
  }

  @override
  Future<List<SocialPostsResponse>> getSocialPostWithTagsByText(
    String text,
  ) async {
    final response = await getIt<Repository>().filterSocialPosts(text);
    final List<SocialPostsResponse> filteredSocialResources =
        <SocialPostsResponse>[];
    final datum = response.datum;
    for (final data in datum) {
      final filteredSocialResponse =
          SocialPostsResponse.fromJson(data as Map<String, dynamic>);
      filteredSocialResources.add(filteredSocialResponse);
    }
   return filteredSocialResources;
  }

  @override
  Future<List<SocialPostsResponse>> getAllSocialResources() async {
    final response = await getIt<Repository>().socialResource();
    final List<SocialPostsResponse> allSocialResources =
        <SocialPostsResponse>[];
    final datum = response.datum;
    for (final data in datum) {
      final allSocialPostsResponse =
          SocialPostsResponse.fromJson(data as Map<String, dynamic>);
      allSocialResources.add(allSocialPostsResponse);
    }
   return allSocialResources;
  }

  @override
  Future<GuvenResponseModel> clickPost(int postId) =>
      getIt<Repository>().clickPost(postId);
}
