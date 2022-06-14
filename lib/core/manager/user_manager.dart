import 'package:flutter/material.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';

import '../../features/auth/login/model/login_exception.dart';
import '../../features/shared/consent_form/consent_form_dialog.dart';
import '../../features/shared/rate_dialog/rate_dialog.dart';
import '../../model/model.dart';
import '../core.dart';

abstract class UserManager {
  Future<RbioLoginResponse> login(
      String userName, String password, String consentId);
  Future<void> saveLoginInfo(
    String userName,
    String password,
    bool rememberMeChecked,
    String token,
  );
  UserLoginInfo getSavedLoginInfo();
  Future<UserAccount> getUserProfile();
  Future updateIdentityOps(String identityNumber);
  Future startMeeting(
    BuildContext context,
    String webConsultantId,
    int availabilityId,
  );
  Future setApplicationConsentFormState(bool isChecked);
  bool getApplicationConsentFormState();
  Future setKvkkFormState(bool isChecked);
  Future<bool> getKvkkFormState();
}

class UserManagerImpl extends UserManager {
  late final ISharedPreferencesManager _sharedPreferencesManager;
  late final Repository _repository;
  UserManagerImpl(
    this._sharedPreferencesManager,
    this._repository,
  );

  @override
  Future<RbioLoginResponse> login(
      String userName, String password, String consentId) async {
    var either = await _repository.login(userName, password, consentId);
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

            _loginToFirebase(loginResponse);
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

  Future<void> _loginToFirebase(RbioLoginResponse? response) async {
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
    await _sharedPreferencesManager.setString(
      SharedPreferencesKeys.loginUserName,
      userName,
    );
    if (rememberMeChecked) {
      await _sharedPreferencesManager.setString(
        SharedPreferencesKeys.loginPassword,
        password,
      );
    } else {
      await _sharedPreferencesManager.setString(
        SharedPreferencesKeys.loginPassword,
        "",
      );
    }

    await _sharedPreferencesManager.setString(
      SharedPreferencesKeys.jwtToken,
      token,
    );
  }

  @override
  UserLoginInfo getSavedLoginInfo() {
    final userLoginInfo = UserLoginInfo();
    final username = _sharedPreferencesManager.getString(
      SharedPreferencesKeys.loginUserName,
    );
    userLoginInfo.username = username;
    final password = _sharedPreferencesManager.getString(
      SharedPreferencesKeys.loginPassword,
    );
    userLoginInfo.password = password;
    return userLoginInfo;
  }

  @override
  Future updateIdentityOps(String identityNumber) async {
    await _updateIdentityNumber(identityNumber);
    await _changeLoginUserParameter(identityNumber);
    await _refreshToken();
    await getUserProfile();
  }

  Future _updateIdentityNumber(String identityNumber) async {
    final response = await _repository.updateUserSystemName(identityNumber);
    if (response.datum == 10) {
      return response.datum;
    } else if (response.datum == 5) {
      throw 5;
    } else {
      throw response.datum as Object;
    }
  }

  Future _changeLoginUserParameter(String identityNumber) async {
    final token = _sharedPreferencesManager.get(SharedPreferencesKeys.jwtToken);
    final userLoginInfo = getSavedLoginInfo();
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

  Future _refreshToken() async {
    final token = _sharedPreferencesManager.get(SharedPreferencesKeys.jwtToken);
    final userLoginInfo = getSavedLoginInfo();
    await login(
        userLoginInfo.username as String,
        _sharedPreferencesManager
                .getString(SharedPreferencesKeys.loginPassword) ??
            '',
        _sharedPreferencesManager.getString(SharedPreferencesKeys.consentId) ??
            '');
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
  Future<UserAccount> getUserProfile() async {
    final response = await _repository.getUserProfile();
    await getIt<UserNotifier>().setUserAccount(response);
    return response;
  }

  @override
  Future startMeeting(
    BuildContext context,
    String webConsultantId,
    int availabilityId,
  ) async {
    final token = _sharedPreferencesManager.get(SharedPreferencesKeys.jwtToken);
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
                getIt<IAppConfig>()
                    .platform
                    .adjustManager
                    ?.trackEvent(SuccessfulVideoCallEvent());
                getIt<FirebaseAnalyticsManager>()
                    .logEvent(VideoCallSuccessfulEvent());
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

          await _repository.setJitsiWebConsultantId(webConsultantId);
        } else if (value != null && !(value as bool)) {}
      });
    }
  }

  @override
  Future setApplicationConsentFormState(bool isChecked) async {
    if (isChecked) {
      await _sharedPreferencesManager.setBool(
          SharedPreferencesKeys.applicationConsentForm, true);
    } else {
      await _sharedPreferencesManager.setBool(
          SharedPreferencesKeys.applicationConsentForm, false);
    }
  }

  @override
  bool getApplicationConsentFormState() {
    try {
      final sharedValue = _sharedPreferencesManager
          .getBool(SharedPreferencesKeys.applicationConsentForm);
      if (sharedValue != null) {
        return sharedValue;
      } else {
        return false;
      }
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      return false;
    }
  }

  @override
  Future setKvkkFormState(bool isChecked) async {
    if (isChecked) {
      try {
        await _repository.updateUserKvkkInfo();
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
      final response = await _repository.getUserKvkkInfo();
      final datum = response.datum;
      KvkkApproveResponse kvkkApproveResponse = KvkkApproveResponse();
      kvkkApproveResponse =
          KvkkApproveResponse.fromJson(datum as Map<String, dynamic>);
      return kvkkApproveResponse.isKVKKAprovved!;
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      return false;
    }
  }
}
