import 'dart:developer';
import 'dart:io' as platform;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/core.dart';
import '../../../core/data/repository/doctor_repository.dart';
import '../../../core/utils/utils.dart';
import '../../../model/model.dart';
import '../../shared/consent_form/consent_form_dialog.dart';
import '../../shared/kvkk_form/kvkk_form_screen.dart';
import '../auth.dart';
import '../user_service.dart';

enum VersionCheckProgress { DONE, LOADING, ERROR }

class LoginScreenVm extends ChangeNotifier {
  BuildContext mContext;

  LoadingProgress _progress;

  VersionCheckProgress _versionCheckProgress;

  ApplicationVersionResponse _applicationVersionResponse;

  bool _rememberMeChecked;

  GuvenLogin _guvenLogin;

  bool _needForceUpdate;

  UserLoginInfo _userLoginInfo;

  LoadingDialog loadingDialog;

  String _userId, _password;

  String _locale;

  bool _clickedGeneralForm;

  bool _checkedKvkk;

  bool _passwordVisibility;
  PackageInfo packageInfo;
  LoginScreenVm({BuildContext context}) {
    this.mContext = context;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getCurrentLocale();
      await getSavedLoginInfo();
      await fetchConsentFormState();
      await fetchKvkkFormState();
      //await startAppVersionOperation();
      //    packageInfo = await PackageInfo.fromPlatform();
    });
  }

  String get locale => this._locale ?? "";

  bool get clickedGeneralForm => this._clickedGeneralForm ?? false;

  bool get checkedKvkkForm => this._checkedKvkk ?? false;

  bool get passwordVisibility => this._passwordVisibility ?? false;

  toggleKvkkFormClick() {
    this._checkedKvkk = !checkedKvkkForm;
    notifyListeners();
    getIt<UserManager>().setKvkkFormState(checkedKvkkForm);
  }

  togglePasswordVisibility() {
    this._passwordVisibility = !passwordVisibility;
    notifyListeners();
  }

  fetchConsentFormState() async {
    this._clickedGeneralForm =
        await getIt<UserManager>().getApplicationConsentFormState();
    notifyListeners();
  }

  fetchKvkkFormState() async {
    log(getIt<ISharedPreferencesManager>()
            .getString(SharedPreferencesKeys.CT_AUTH_TOKEN) ??
        '');
    this._checkedKvkk = await getIt<UserManager>().getKvkkFormState();
    notifyListeners();
  }

  toggleGeneralFormClick() {
    this._clickedGeneralForm = !clickedGeneralForm;
    if (clickedGeneralForm) {}
    notifyListeners();
  }

  getCurrentLocale() async {
    this._locale = await getIt<UserManager>().loadLocaleIfStored();
    notifyListeners();
  }

  setCurrentLocale(String locale) async {
    await getIt<UserManager>().changeLocale(locale);
    getCurrentLocale();
  }

  getSavedLoginInfo() async {
    var userLoginInfo = await getIt<UserManager>().getSavedLoginInfo();
    this._userLoginInfo = userLoginInfo;
    if (userLoginInfo.password.length > 0) {
      this._rememberMeChecked = true;
    }
    setUserIdText(userLoginInfo.username);
    setPasswordText(userLoginInfo.password);
    notifyListeners();
  }

  setUserIdText(String text) {
    this._userId = text;
    notifyListeners();
  }

  String get userId => this._userId ?? "";

  setPasswordText(String text) {
    this._password = text;
    notifyListeners();
  }

  String get password => this._password ?? "";

  UserLoginInfo get userLoginInfo => this._userLoginInfo ?? UserLoginInfo();

  Future<void> startAppVersionOperation() async {
    this._versionCheckProgress = VersionCheckProgress.LOADING;
    notifyListeners();
    try {
      if (!kIsWeb) {
        //await fetchAppVersion();
        //await checkAppVersion();
      } else {
        //autoLogin();
      }
      this._versionCheckProgress = VersionCheckProgress.DONE;
      notifyListeners();
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      showGradientDialog(mContext, LocaleProvider.current.warning,
          LocaleProvider.current.sorry_dont_transaction);
      this._versionCheckProgress = VersionCheckProgress.ERROR;
      notifyListeners();
    }
  }

  VersionCheckProgress get versionCheckProgress =>
      this._versionCheckProgress ?? VersionCheckProgress.DONE;

  Future<void> fetchAppVersion() async {
    this._progress = LoadingProgress.LOADING;
    notifyListeners();
    try {
      await Future.delayed(Duration(seconds: 2));
      this._applicationVersionResponse =
          await getIt<Repository>().getCurrentApplicationVersion();
      this._progress = LoadingProgress.DONE;
      notifyListeners();
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      this._progress = LoadingProgress.ERROR;
      notifyListeners();
    }
  }

  Future<void> checkAppVersion() async {
    Version requiredMinVersion = Version.parse(applicationVersion.minimum);
    Version latestVersion = Version.parse(applicationVersion.latest);

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    Version currentVersion = Version.parse(packageInfo.version);

    if (requiredMinVersion > currentVersion) {
      this._needForceUpdate = true;
      notifyListeners();
      // force Update
      showCompulsoryUpdateDialog(
        context: mContext,
        onPressed: () {
          updateNow();
        },
        message: LocaleProvider.of(mContext).force_update_message +
            "\n${applicationVersion.name ?? ""}\n${applicationVersion.releaseNotes ?? ""}",
      );
    } else if (latestVersion > currentVersion) {
      this._needForceUpdate = false;
      notifyListeners();
      // optional update
      bool check = await isShowOptional();
      if (check) {
        showOptionalUpdateDialog(
          context: mContext,
          message: LocaleProvider.of(mContext).optional_update_message +
              "\n${applicationVersion.name ?? ""}\n${applicationVersion.releaseNotes ?? ""}",
          onPressed: () {
            updateNow();
          },
        );
      }
    } else {
      autoLogin();
    }
  }

  Future<void> autoLogin() async {
    this._needForceUpdate = false;
    notifyListeners();

    // app is up to date
    UserLoginInfo userLoginInfo =
        await getIt<UserManager>().getSavedLoginInfo();
    if ((userLoginInfo?.username ?? "").length > 0 &&
        (userLoginInfo?.password ?? "").length > 0) {
      login(userLoginInfo.username, userLoginInfo.password);
    }
  }

  bool get needForceUpdate => this._needForceUpdate ?? false;

  Future<void> login(String username, String password) async {
    if (checkFields(username, password)) {
      showLoadingDialog(mContext);
      await Future.delayed(Duration(milliseconds: 500));
      this._progress = LoadingProgress.LOADING;
      notifyListeners();

      try {
        this._guvenLogin = await getIt<UserManager>().login(username, password);
        await saveLoginInfo(username, password, guvenLogin.access_token);
        await getIt<Repository>().getPatientDetail();
        await getIt<UserManager>().getUserProfile();
        await UtilityManager().setTokenToServer(_guvenLogin.access_token);
        this._checkedKvkk = await getIt<UserManager>().getKvkkFormState();
        this._progress = LoadingProgress.DONE;
        // final userCredential = await UserService().signInWithEmailAndPasswordFirebase('deneme@gmal.com', '123456');
        // await UserService().saveAndRetrieveToken(userCredential.user, 'patientLogin');
        // await UserService().handleSuccessfulLogin(userCredential.user);
        final doctorResponse =
            await getIt<DoctorRepository>().login('dr.alev.eken', '12345');
        await getIt<ISharedPreferencesManager>().setString(
            SharedPreferencesKeys.DOCTOR_TOKEN,
            doctorResponse.token.accessToken);
        hideDialog(mContext);
        notifyListeners();
        AnalyticsManager().sendEvent(LoginSuccessEvent());
        final term = Atom.queryParameters['then'];
        if (term != null && term != '') {
          Atom.to(term, isReplacement: true);
        }
        Atom.to(PagePaths.MAIN, isReplacement: true);
        var devices = await getIt<BleDeviceManager>().getPairedDevices();
        if (devices.isNotEmpty) {
          getIt<BleScannerOps>().startScan();
        }
        // MainNavigation.toHome(mContext);
      } catch (e, stackTrace) {
        Sentry.captureException(e, stackTrace: stackTrace);
        hideDialog(mContext);
        this._progress = LoadingProgress.ERROR;
        notifyListeners();
        if (e.toString().contains("401")) {
          showGradientDialog(
            mContext,
            LocaleProvider.current.warning,
            LocaleProvider.current.wrong_username_password,
          );
        } else if (e.toString().contains("400")) {
          Atom.to(
            PagePaths.FORGOT_PASSWORD_STEP_2,
            queryParameters: {'identityNumber': username},
          );
        } else {
          showGradientDialog(mContext, LocaleProvider.current.warning,
              LocaleProvider.current.sorry_dont_transaction);
        }
      }
    }
  }

  bool checkFields(String username, String password) {
    if (clickedGeneralForm) {
      if (username.length > 0 && password.length > 0) {
        return true;
      } else {
        showGradientDialog(mContext, LocaleProvider.current.warning,
            LocaleProvider.current.tc_or_pass_cannot_empty);
        return false;
      }
    } else {
      showGradientDialog(mContext, LocaleProvider.current.warning,
          LocaleProvider.current.approve_consent_form);
      return false;
    }
  }

  GuvenLogin get guvenLogin => this._guvenLogin;

  Future<void> saveLoginInfo(
      String userName, String password, String token) async {
    if (!rememberMeChecked) {
      password = "";
    }

    await getIt<UserManager>()
        .saveLoginInfo(userName, password, rememberMeChecked, token);
  }

  isShowOptional() async {
    bool showUpdates = false;
    showUpdates = getIt<ISharedPreferencesManager>()
        .getBool(SharedPreferencesKeys.UPDATE_DIALOG);
    if (showUpdates != null) {
      return showUpdates;
    } else {
      return true;
    }
  }

  updateNow() async {
    String applicationUrl = platform.Platform.isIOS
        ? applicationVersion.iosUrl
        : applicationVersion.androidUrl;
    bool urlActive = await canLaunch(applicationUrl);
    if (urlActive) {
      launch(applicationUrl);
    }
  }

  ApplicationVersionResponse get applicationVersion =>
      this._applicationVersionResponse;

  LoadingProgress get progress => this._progress;

  bool get rememberMeChecked => this._rememberMeChecked ?? false;

  toggleRememberMeChecked() {
    this._rememberMeChecked = !rememberMeChecked;
    notifyListeners();
  }

  void showGradientDialog(BuildContext context, String title, String text) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return WarningDialog(title, text);
        }).then((value) {
      if (text == LocaleProvider.current.approve_consent_form) {
        showApplicationContestForm();
      } else if ((text == LocaleProvider.current.must_clicked_kvkk)) {
        showKvkkInfo();
      }
    });
  }

  void showLoadingDialog(BuildContext context) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) =>
            loadingDialog = loadingDialog ?? LoadingDialog());
  }

  showApplicationContestForm() {
    showDialog(
        context: mContext,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return ConsentFormDialog(
            title: LocaleProvider.current.approve_consent_form,
            text: LocaleProvider.current.application_consent_form_text,
            alwaysAsk: false,
          );
        }).then((value) async {
      if (value != null && value) {
        this._clickedGeneralForm = true;
        notifyListeners();
      } else if (value != null && !value) {
        this._clickedGeneralForm = false;
        notifyListeners();
      }
    });
  }

  void hideDialog(BuildContext context) {
    if (loadingDialog != null && loadingDialog.isShowing()) {
      Navigator.of(context).pop();
      loadingDialog = null;
    }
  }

  void showKvkkInfo() {
    showDialog(
        context: mContext,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return KvkkFormScreen(
            title: LocaleProvider.current.kvkk_title,
            text: LocaleProvider.current.kvkk_url_text,
            alwaysAsk: true,
          );
        }).then((value) async {
      if (value != null && value) {
        this._checkedKvkk = true;
        notifyListeners();
      } else if (value != null && !value) {
        this._checkedKvkk = false;
        notifyListeners();
      }
    });
  }
}
