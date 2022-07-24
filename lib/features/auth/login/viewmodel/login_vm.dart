import 'dart:io' as platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../../model/model.dart';
import '../../../bluetooth/bluetooth.dart';
import '../../../dashboard/home/viewmodel/home_vm.dart';
import '../../../shared/consent_form/consent_form_dialog.dart';
import '../../../shared/kvkk_form/kvkk_form_screen.dart';
import '../../../take_appointment/create_appointment_summary/model/synchronize_onedose_user_req.dart';
import '../../auth.dart';

enum VersionCheckProgress { done, loading, error }

class LoginScreenVm extends ChangeNotifier {
  BuildContext mContext;

  LoginScreenVm(this.mContext) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      consentForm = await getIt<Repository>().getConsentForm();

      getIt<ISharedPreferencesManager>().setString(SharedPreferencesKeys.consentId, consentForm.id.toString());
      fetchConsentFormState();
      await getSavedLoginInfo();
      getIt<UserNotifier>().setDefaultUser(getIt<ISharedPreferencesManager>().getBool(SharedPreferencesKeys.isDefaultUser));
    });
  }

  AutovalidateMode _autovalidateMode = AutovalidateMode.onUserInteraction;
  AutovalidateMode? get autovalidateMode => _autovalidateMode;
  late ConsentForm consentForm;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState>? get formKey => _formKey;

  String locale = "";
  LoadingDialog? loadingDialog;

  ApplicationVersionResponse? _applicationVersionResponse;
  ApplicationVersionResponse? get applicationVersion => _applicationVersionResponse;

  RbioLoginResponse? _guvenLogin;
  RbioLoginResponse? get guvenLogin => _guvenLogin;

  bool _needForceUpdate = false;
  bool get needForceUpdate => _needForceUpdate;

  VersionCheckProgress get versionCheckProgress => _versionCheckProgress;
  VersionCheckProgress _versionCheckProgress = VersionCheckProgress.done;

  bool _rememberMeChecked = false;
  bool get rememberMeChecked => _rememberMeChecked;
  void toggleRememberMeChecked() {
    _rememberMeChecked = !rememberMeChecked;
    notifyListeners();
  }

  String _userId = "", _password = "";
  String get userId => _userId;
  void setUserIdText(String text) {
    _userId = text;
  }

  String get password => _password;
  void setPasswordText(String text) {
    _password = text;
  }

  bool? _passwordVisibility;
  bool get passwordVisibility => _passwordVisibility ??= false;
  void togglePasswordVisibility() {
    _passwordVisibility = !(_passwordVisibility ??= false);
    notifyListeners();
  }

  bool _clickedGeneralForm = false;
  bool get clickedGeneralForm => _clickedGeneralForm;
  set clickedGeneralForm(bool value) {
    _clickedGeneralForm = value;
    notifyListeners();
  }

  bool _checkedKvkk = false;
  bool get checkedKvkkForm => _checkedKvkk;
  set checkedKvkkForm(bool value) {
    _checkedKvkk = value;
    notifyListeners();
  }

  void fetchConsentFormState() {
    _clickedGeneralForm = getIt<UserManager>().getApplicationConsentFormState();
  }

  Future<void> fetchKvkkFormState() async {
    _checkedKvkk = await getIt<UserManager>().getKvkkFormState();
  }

  void toggleGeneralFormClick() {
    _clickedGeneralForm = !clickedGeneralForm;
    if (clickedGeneralForm) {}
    notifyListeners();
  }

  Future<void> getSavedLoginInfo() async {
    var userLoginInfo = getIt<UserManager>().getSavedLoginInfo();
    if (userLoginInfo.password != null && (userLoginInfo.password?.length ?? 0) > 0) {
      _rememberMeChecked = true;
    }
    setUserIdText(userLoginInfo.username ?? '');
    setPasswordText(userLoginInfo.password ?? '');
    notifyListeners();
    await fetchAppVersion(userLoginInfo);
  }

  Future<void> startAppVersionOperation() async {
    _versionCheckProgress = VersionCheckProgress.loading;
    notifyListeners();

    try {
      if (!kIsWeb) {
        //await fetchAppVersion();
        //await checkAppVersion();
      } else {
        //autoLogin();
      }
      _versionCheckProgress = VersionCheckProgress.done;
      notifyListeners();
    } catch (e, stackTrace) {
      getIt<IAppConfig>().platform.sentryManager.captureException(e, stackTrace: stackTrace);
      showGradientDialog(
        mContext,
        LocaleProvider.current.warning,
        LocaleProvider.current.sorry_dont_transaction,
      );
      _versionCheckProgress = VersionCheckProgress.error;
      notifyListeners();
    }
  }

  Future<void> fetchAppVersion(UserLoginInfo userLoginInfo) async {
    try {
      _applicationVersionResponse = await getIt<Repository>().getCurrentApplicationVersion();
    } catch (e, stackTrace) {
      getIt<IAppConfig>().platform.sentryManager.captureException(e, stackTrace: stackTrace);
      LoggerUtils.instance.e(e);
    } finally {
      notifyListeners();
    }

    await checkAppVersion(userLoginInfo);
  }

  Future<void> checkAppVersion(UserLoginInfo userLoginInfo) async {
    final requiredMinVersion = Version.parse(applicationVersion?.minimum ?? '0.0.0');
    final latestVersion = Version.parse(applicationVersion?.latest ?? '0.0.0');

    final packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = Version.parse(packageInfo.version);

    if (requiredMinVersion > currentVersion) {
      _needForceUpdate = true;
      notifyListeners();
      showCompulsoryUpdateDialog(
        context: mContext,
        onPressed: () {
          updateNow();
        },
        message: LocaleProvider.of(mContext).force_update_message + "\n${applicationVersion?.name ?? ""}\n${applicationVersion?.releaseNotes ?? ""}",
      );
    } else if (latestVersion > currentVersion) {
      _needForceUpdate = false;
      notifyListeners();
      bool check = isShowOptional();
      if (check) {
        showOptionalUpdateDialog(
          context: mContext,
          message: LocaleProvider.of(mContext).optional_update_message + "\n${applicationVersion?.name ?? ""}\n${applicationVersion?.releaseNotes ?? ""}",
          onPressed: () {
            updateNow();
          },
        );
      }
    } else {
      if ((userLoginInfo.username ?? "").isNotEmpty && (userLoginInfo.password ?? "").isNotEmpty) {
        await login(
            userLoginInfo.username ?? '', userLoginInfo.password ?? '', getIt<ISharedPreferencesManager>().getString(SharedPreferencesKeys.consentId) ?? '');
      }
    }
  }

  Future<void> login(String username, String password, String consentId) async {
    if (checkFields(username, password)) {
      _autovalidateMode = AutovalidateMode.always;

      notifyListeners();

      try {
        if (getIt<IAppConfig>().functionality.recaptcha && kIsWeb) {
          String token = await getIt<IAppConfig>().platform.recaptchaManager?.login() ?? '';
          if (token.isEmpty) return;
        }
        final starterResponse = await getIt<Repository>().loginStarter(
          username,
          password,
        );
        hideDialog(mContext);

        if (starterResponse.datum is Map<String, dynamic>) {
          final starterBody = UserLoginStarterResponse.fromJson(starterResponse.datum);
          await getIt<ISharedPreferencesManager>().setBool(
            SharedPreferencesKeys.isTwoFactorAuth,
            starterBody.isTwoFa ?? false,
          );

          if (starterBody.isTwoFa == true && starterBody.isSsoValid == true) {
            if (starterBody.userId == null) return;

            // Verify Confirmation 2FA
            final dialogResult = await showDialog(
              context: mContext,
              barrierDismissible: true,
              builder: (context) {
                return TwoFaDialog(
                  userId: starterBody.userId!,
                );
              },
            );

            if (dialogResult == true) {
              // Get Token by GOs
              await loginWithProductType(username, password, consentId);
            } else if (dialogResult == false) {
              await login(username, password, consentId);
              return;
            }
          } else if (starterBody.isTwoFa == false && starterBody.isSsoValid == true) {
            // Get Token by GOs
            await loginWithProductType(username, password, consentId);
          } else if (starterBody.isTwoFa == false && starterBody.isSsoValid == false) {
            // Get Token by GO
            await loginWithProductType(username, password, consentId);
          } else if (starterBody.isTwoFa == true && starterBody.isSsoValid == false) {
            showGradientDialog(
              mContext,
              LocaleProvider.current.warning,
              LocaleProvider.current.sorry_dont_transaction,
            );
          }
        }
      } catch (e, stackTrace) {
        getIt<IAppConfig>().platform.sentryManager.captureException(e, stackTrace: stackTrace);
        LoggerUtils.instance.e(e);
        hideDialog(mContext);
        notifyListeners();
        showGradientDialog(
          mContext,
          LocaleProvider.current.warning,
          LocaleProvider.current.sorry_dont_transaction,
        );
      }
    }
  }

  Future<void> loginWithProductType(String username, String password, String consentId) async {
    showLoadingDialog();
    if (getIt<IAppConfig>().productType == ProductType.oneDose) {
      await loginOneDose(username, password, consentId);
    } else {
      await loginGuven(username, password, consentId);
    }
  }

  Future<void> loginGuven(String username, String password, String consentId) async {
    try {
      _guvenLogin = await getIt<UserManager>().login(username, password, consentId);
    } catch (e, stackTrace) {
      getIt<IAppConfig>().platform.sentryManager.captureException(e, stackTrace: stackTrace);
      hideDialog(mContext);

      if (e is LoginExceptions) {
        e.when(
          invalidUser: () {
            showGradientDialog(
              mContext,
              LocaleProvider.current.warning,
              LocaleProvider.current.wrong_user_credential,
            );
          },
          accountNotFullySetUp: () {
            Atom.to(PagePaths.forgotPasswordStep1);
          },
          accountDisabled: () {
            showGradientDialog(
              mContext,
              LocaleProvider.current.warning,
              LocaleProvider.current.account_disabled,
            );
          },
          serverError: () {
            showGradientDialog(
              mContext,
              LocaleProvider.current.warning,
              LocaleProvider.current.sorry_dont_transaction,
            );
          },
          networkError: () {
            showGradientDialog(
              mContext,
              LocaleProvider.current.warning,
              LocaleProvider.current.no_network,
            );
          },
          undefined: () {
            showGradientDialog(
              mContext,
              LocaleProvider.current.warning,
              LocaleProvider.current.sorry_dont_transaction,
            );
          },
        );
      }

      return;
    }

    await saveLoginInfo(
      username,
      password,
      _guvenLogin?.ssoResponse?.accessToken ?? '',
    );

    List<dynamic> results = await Future.wait(
      [
        getIt<UserManager>().setApplicationConsentFormState(true),
        //One dose hasta bilgileri
        // Güven online kullanıcı bilgileri
        getIt<UserManager>().getUserProfile(),
        getIt<UserManager>().getKvkkFormState(),
      ],
    );

    final patientDetail = results[1] as UserAccount;

    PatientResponse? pusulaPatientDetail;
    try {
      pusulaPatientDetail = await getIt<Repository>().getPatientDetail();
    } catch (e, stackTrace) {
      getIt<IAppConfig>().platform.sentryManager.captureException(e, stackTrace: stackTrace);
      if (pusulaPatientDetail == null) {
        var inputFormat = DateFormat('dd.MM.yyyy');
        var date1 = inputFormat.parse(patientDetail.patients!.first.birthDate!);

        var outputFormat = DateFormat('yyyy-MM-dd');
        var date2 = outputFormat.format(date1);
        SynchronizeOneDoseUserRequest synchronizeOneDoseUserRequest = SynchronizeOneDoseUserRequest(
            birthDate: date2,
            email: patientDetail.electronicMail,
            firstName: patientDetail.name,
            gender: patientDetail.patients?.first.gender,
            gsm: patientDetail.phoneNumber,
            countryCode: patientDetail.countryCode,
            id: 0,
            hasEtkApproval: true,
            hasKvkkApproval: true,
            identityNumber: patientDetail.identificationNumber,
            lastName: patientDetail.surname,
            nationalityId: (patientDetail.nationality!) == 'TC' ? 213 : 98,
            passportNumber: patientDetail.passaportNumber,
            patientType: 1);
        await getIt<Repository>().synchronizeOneDoseUser(synchronizeOneDoseUserRequest);
      }
    }
    if (pusulaPatientDetail == null) {
      pusulaPatientDetail = await getIt<Repository>().getPatientDetail();
      await getIt<UserFacade>().setPatient(pusulaPatientDetail!);
    }
    _checkedKvkk = results[2];

    try {
      final profilImage = await getIt<Repository>().getProfilePicture();
      if (profilImage.isNotEmpty) {
        await getIt<ISharedPreferencesManager>().setString(
          SharedPreferencesKeys.profileImage,
          profilImage,
        );
      }
    } catch (e, stackTrace) {
      getIt<IAppConfig>().platform.sentryManager.captureException(e, stackTrace: stackTrace);
      //
    }

    final term = Atom.queryParameters['then'];

    getIt<FirebaseAnalyticsManager>().setUserId(getIt<UserNotifier>().firebaseEmail);
    getIt<FirebaseAnalyticsManager>().setUserProperty('Login', 'authed');
    getIt<FirebaseAnalyticsManager>().setUserProperty('user_age', getIt<ProfileStorageImpl>().getFirst().birthDate);

    getIt<FirebaseAnalyticsManager>().logEvent(BasariliGirisEvent());
    getIt<IAppConfig>().platform.adjustManager?.trackEvent(SuccessfulLoginEvent());

    if (term != null && term != '') {
      Atom.to(term, isReplacement: true);
    }
    final allUsersModel = getIt<UserFacade>().getHomeWidgets(username);
    mContext.read<HomeVm>().init(allUsersModel);
    await Future.delayed(const Duration(milliseconds: 100));
    hideDialog(mContext);
    notifyListeners();
    Atom.to(PagePaths.main, isReplacement: true);
  }

  Future<void> loginOneDose(String username, String password, String consentId) async {
    // Roles and token
    try {
      _guvenLogin = await getIt<UserManager>().login(username, password, consentId);
    } catch (e, stackTrace) {
      getIt<IAppConfig>().platform.sentryManager.captureException(e, stackTrace: stackTrace);
      hideDialog(mContext);

      if (e is LoginExceptions) {
        e.when(
          invalidUser: () {
            showGradientDialog(
              mContext,
              LocaleProvider.current.warning,
              LocaleProvider.current.wrong_user_credential,
            );
          },
          accountNotFullySetUp: () {
            Atom.to(PagePaths.forgotPasswordStep1);
          },
          accountDisabled: () {
            showGradientDialog(
              mContext,
              LocaleProvider.current.warning,
              LocaleProvider.current.account_disabled,
            );
          },
          serverError: () {
            showGradientDialog(
              mContext,
              LocaleProvider.current.warning,
              LocaleProvider.current.sorry_dont_transaction,
            );
          },
          networkError: () {
            showGradientDialog(
              mContext,
              LocaleProvider.current.warning,
              LocaleProvider.current.no_network,
            );
          },
          undefined: () {
            showGradientDialog(
              mContext,
              LocaleProvider.current.warning,
              LocaleProvider.current.sorry_dont_transaction,
            );
          },
        );
      }

      return;
    }

    await saveLoginInfo(
      username,
      password,
      _guvenLogin?.ssoResponse?.accessToken ?? '',
    );

    List<dynamic> results = await Future.wait(
      [
        getIt<UserManager>().setApplicationConsentFormState(true),
        //One dose hasta bilgileri
        // Güven online kullanıcı bilgileri
        getIt<UserManager>().getUserProfile(),
        getIt<UserManager>().getKvkkFormState(),
      ],
    );

    final patientDetail = results[1] as UserAccount;

    PatientResponse? pusulaPatientDetail;
    try {
      pusulaPatientDetail = await getIt<Repository>().getPatientDetail();
    } catch (e, stackTrace) {
      getIt<IAppConfig>().platform.sentryManager.captureException(e, stackTrace: stackTrace);
      if (pusulaPatientDetail == null) {
        var inputFormat = DateFormat('dd.MM.yyyy');
        var date1 = inputFormat.parse(patientDetail.patients!.first.birthDate!);

        var outputFormat = DateFormat('yyyy-MM-dd');
        var date2 = outputFormat.format(date1);
        SynchronizeOneDoseUserRequest synchronizeOneDoseUserRequest = SynchronizeOneDoseUserRequest(
            birthDate: date2,
            email: patientDetail.electronicMail,
            firstName: patientDetail.name,
            gender: patientDetail.patients?.first.gender,
            gsm: patientDetail.phoneNumber,
            countryCode: patientDetail.countryCode,
            id: 0,
            hasEtkApproval: true,
            hasKvkkApproval: true,
            identityNumber: patientDetail.identificationNumber,
            lastName: patientDetail.surname,
            nationalityId: (patientDetail.nationality!) == 'TC' ? 213 : 98,
            passportNumber: patientDetail.passaportNumber,
            patientType: 1);
        await getIt<Repository>().synchronizeOneDoseUser(synchronizeOneDoseUserRequest);
      }
    }
    if (pusulaPatientDetail == null) {
      pusulaPatientDetail = await getIt<Repository>().getPatientDetail();
      await getIt<UserFacade>().setPatient(pusulaPatientDetail!);
    }
    _checkedKvkk = results[2];

    if (getIt<UserNotifier>().user.xGetChronicTrackingOrFalse) {
      var profiles = await getIt<ChronicTrackingRepository>().getAllProfiles();
      if (profiles.isNotEmpty) {
        await getIt<ProfileStorageImpl>().write(
          profiles.last,
          shouldSendToServer: false,
        );
      } else {
        await getIt<ProfileStorageImpl>().write(
          Person().fromDefault(
            name: patientDetail.name ?? 'Name',
            lastName: patientDetail.surname ?? 'LastName',
            birthDate: patientDetail.patients?.first.birthDate ?? '01.01.2000',
            gender: patientDetail.patients?.first.gender ?? 'unsp',
          ),
          shouldSendToServer: true,
        );
      }
    }

    if (!Atom.isWeb && getIt<UserNotifier>().user.xGetChronicTrackingOrFalse) {
      try {
        List<PairedDevice>? devices = getIt<BleDeviceManager>().getPairedDevices();
        if (devices.isNotEmpty) {
          Atom.context.read<BluetoothBloc>().add(const BluetoothEvent.listenBleStatus());
        }
      } catch (e, stackTrace) {
        getIt<IAppConfig>().platform.sentryManager.captureException(e, stackTrace: stackTrace);
        Atom.context.read<BluetoothBloc>().add(const BluetoothEvent.listenBleStatus());
      }
    }

    // await getIt<SymptomRepository>().getSymtptomsApiToken();

    try {
      final profilImage = await getIt<Repository>().getProfilePicture();
      if (profilImage.isNotEmpty) {
        await getIt<ISharedPreferencesManager>().setString(
          SharedPreferencesKeys.profileImage,
          profilImage,
        );
      }
    } catch (e, stackTrace) {
      getIt<IAppConfig>().platform.sentryManager.captureException(e, stackTrace: stackTrace);
      //
    }

    if (getIt<UserNotifier>().user.xGetChronicTrackingOrFalse) {
      getIt<ScaleRepository>().fetchScaleData(
        getIt<ProfileStorageImpl>().getFirst().id ?? 0,
      );
    }

    final term = Atom.queryParameters['then'];
    getIt<FirebaseAnalyticsManager>().setUserId(getIt<UserNotifier>().firebaseEmail);

    getIt<FirebaseAnalyticsManager>().setUserProperty('Login', 'authed');
    getIt<FirebaseAnalyticsManager>().setUserProperty('user_age', getIt<ProfileStorageImpl>().getFirst().birthDate);

    getIt<FirebaseAnalyticsManager>().logEvent(BasariliGirisEvent());
    getIt<IAppConfig>().platform.adjustManager?.trackEvent(SuccessfulLoginEvent());
    if (term != null && term != '') {
      Atom.to(term, isReplacement: true);
    }
    final allUsersModel = getIt<UserFacade>().getHomeWidgets(username);
    mContext.read<HomeVm>().init(allUsersModel);
    await Future.delayed(const Duration(milliseconds: 100));
    hideDialog(mContext);
    notifyListeners();

    /// Kullanici mail adresi boş ise, oturum açma esnasında Ana sayfa yerine
    /// kişisel bilgilerim sayfası açılır ve kullanıcıdan mail girmesi istenilir.
    if (getIt<UserFacade>().getUserAccount().electronicMail != null) {
      Atom.to(PagePaths.main, isReplacement: true);
    } else {
      Atom.to(
        PagePaths.personalInformation,
        isReplacement: true,
        queryParameters: {
          'emailRequired': 'true',
        },
      );
    }
  }

  bool checkFields(String username, String password) {
    if (clickedGeneralForm) {
      if (username.isNotEmpty && password.isNotEmpty) {
        return true;
      } else {
        // showGradientDialog(
        //   mContext,
        //   LocaleProvider.current.warning,
        //   LocaleProvider.current.tc_or_pass_cannot_empty,
        // );
        return false;
      }
    } else {
      showGradientDialog(
        mContext,
        LocaleProvider.current.warning,
        LocaleProvider.current.approve_consent_form,
      );
      return false;
    }
  }

  Future<void> saveLoginInfo(String userName, String password, String token) async {
    if (!rememberMeChecked) {
      password = "";
    }

    await getIt<UserManager>().saveLoginInfo(userName, password, rememberMeChecked, token);
  }

  bool isShowOptional() {
    final showUpdates = getIt<ISharedPreferencesManager>().getBool(SharedPreferencesKeys.updateDialog);
    if (showUpdates != null) {
      return showUpdates;
    } else {
      return true;
    }
  }

  Future<void> updateNow() async {
    String applicationUrl = platform.Platform.isIOS ? (applicationVersion?.iosUrl ?? '') : (applicationVersion?.androidUrl ?? '');
    bool urlActive = await canLaunchUrl(Uri.parse(applicationUrl));
    if (urlActive) {
      launchUrl(Uri.parse(applicationUrl));
    }
  }

  void showGradientDialog(BuildContext context, String title, String text) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return RbioMessageDialog(
          description: text,
          isAtom: false,
        );
      },
    ).then(
      (value) {
        if (text == LocaleProvider.current.approve_consent_form) {
          showApplicationContestForm();
        } else if ((text == LocaleProvider.current.must_clicked_kvkk)) {
          showKvkkInfo();
        }
      },
    );
  }

  void showLoadingDialog() async {
    await showDialog(context: mContext, barrierDismissible: false, builder: (BuildContext context) => loadingDialog = loadingDialog ?? LoadingDialog());
  }

  showApplicationContestForm() async {
    showDialog(
        context: mContext,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return ConsentFormDialog(
            title: consentForm.consentHeader,
            text: consentForm.consentContent,
            alwaysAsk: false,
          );
        }).then((value) async {
      if (value != null && value) {
        _clickedGeneralForm = true;
        notifyListeners();
      } else if (value != null && !value) {
        _clickedGeneralForm = false;
        notifyListeners();
      }
    });
  }

  void hideDialog(BuildContext context) {
    if (loadingDialog != null) {
      if (loadingDialog!.isShowing()) {
        Navigator.of(context).pop();
        loadingDialog = null;
      }
    }
  }

  void showKvkkInfo() {
    showDialog(
        context: mContext,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return KvkkFormScreen(
            title: LocaleProvider.current.kvkk_title,
            text: getIt<IAppConfig>().constants.kvkkUrl(context),
            alwaysAsk: true,
          );
        }).then((value) async {
      if (value != null && value) {
        _checkedKvkk = true;
        notifyListeners();
      } else if (value != null && !value) {
        _checkedKvkk = false;
        notifyListeners();
      }
    });
  }
}
