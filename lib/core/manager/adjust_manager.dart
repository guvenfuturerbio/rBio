import 'package:adjust_sdk/adjust.dart';
import 'package:adjust_sdk/adjust_config.dart';
import 'package:adjust_sdk/adjust_event.dart';
import 'package:flutter/foundation.dart';

import '../../config/config.dart';
import '../core.dart';

class AdjustBaseEvent {
  late final String? token;
  late final String unitPrice;

  AdjustBaseEvent(
    this.token,
  );

  @override
  String toString() => "Event_Name: ${token.toString()}";
}

abstract class AdjustManager {
  late final AdjustConstants constants;
  AdjustManager(this.constants);

  void initializeAdjust();

  void trackEvent(AdjustBaseEvent eventToken) {
    if (!kIsWeb && eventToken.token != null) {
      AdjustEvent adjustEvent = AdjustEvent(eventToken.token!);
      Adjust.trackEvent(adjustEvent);
    }
  }

  void setRevenue(String eventToken, int unitPrice) {
    AdjustEvent adjustEvent = AdjustEvent(eventToken);
    adjustEvent.setRevenue(unitPrice, 'TRY');
    Adjust.trackEvent(adjustEvent);
  }
}

class OneDoseAdjustManagerImpl extends AdjustManager {
  OneDoseAdjustManagerImpl() : super(_OneDoseEventConstants());

  @override
  void initializeAdjust() {
    final adjustConfig =
        AdjustConfig('1vvx05nbpkio', AdjustEnvironment.production);
    adjustConfig.setAppSecret(1, 492801584, 1304692510, 331550936, 2085469560);
    Adjust.start(adjustConfig);
    adjustConfig.logLevel = AdjustLogLevel.verbose;
  }
}

class GuvenOnlineAdjustManagerImpl extends AdjustManager {
  GuvenOnlineAdjustManagerImpl() : super(_GuvenOnlineEventConstants());

  @override
  void initializeAdjust() {
    final adjustConfig =
        AdjustConfig('xe34hcactfk0', AdjustEnvironment.production);
    adjustConfig.setAppSecret(1, 413165747, 1265213513, 190651275, 1454099636);
    Adjust.start(adjustConfig);
    adjustConfig.logLevel = AdjustLogLevel.verbose;
  }
}

abstract class AdjustConstants {
  String get bottomBarClicked;
  String get successfulLogin;
  String get detailedSymptom;
  String get menuButtonClicked;
  String get menuElementProfileClicked;
  String get menuElementHospitalAppointmentClicked;
  String get menuElementOnlineAppoClicked;
  String get menuElementHealthTrackerClicked;
  String get menuElementAppointmentsClicked;
  String get menuElementResultsClicked;
  String get menuElementForYouClicked;
  String get menuElementSymptomCheckerClicked;
  String get menuElementDevicesClicked;
  String get menuElementRemindersClicked;
  String get menuElementSuggestionsClicked;
  String get searchCreateAppointment;
  String get healthTrackerButtons;
  String get mySymptomsPage1;
  String get mySymptomsPage2;
  String get mySymptomsPage3;
  String get mySymptomsPage4DepartmentAnalysis;
  String get myResultsSearchAppointment;
  String get logOut;
  String get forYouPageClicked;
  String get newDownloads;
  String get successfulVideoCall;
  String get successfulRelativeDeletion;
  String get successfulPayment;
  String get forYouCategoryClicked;
  String get forYouSubCategoryClicked;
  String get forYouPackageSummaryClicked;
  String get forYouItemPaymentClicked;
  String get mainPageOAClicked;
  String get mainPagePcrTestClicked;
  String get mainPageFindDoctorClicked;
  String get mainPageMyAppointmentsClicked;
  String get mainPageMyResultsClicked;
  String get mainPageCounselingLineClicked;
  String get findDoctorTabClicked;
  String get myAppointmentsTabClicked;
  String get mainPageTabClicked;
  String get myProfileTabClicked;
  String get oaDepartmentSelection;
  String get oaDoctorSelection;
  String get takeAppointmentDoctorDetails;
  String get pcrTestHospitalSelection;
  String get successfulPasswordChange;
  String get relativesTabClicked;
  String get relativeSwitchSuccessful;
  String get successfulRelativeAdd;
  String get successfulRelativeMainAccountSwitch;
  String get personalInformationClicked;
  String get uploadProfilePicture;
  String get deleteProfilePicture;
  String get unsuccessfulPasswordChange;
  String get unsuccessfulRelativeSwitch;
  String get unsuccessfulRelativeAdd;
  String get unccessfulRelativeMainAccountSwitchEvent;
  String get unsuccessfulRelativeDeletion;
  String get unsuccessfulRegisterStep1;
}

class _OneDoseEventConstants extends AdjustConstants {
  @override
  final bottomBarClicked = "vwg8bv";

  @override
  final successfulLogin = "vy6mgv";

  @override
  final detailedSymptom = "h4tj9v";

  @override
  final menuButtonClicked = "jhcyym";

  @override
  final menuElementProfileClicked = "1aa4xx";

  @override
  final menuElementHospitalAppointmentClicked = "fw7xdi";

  @override
  final menuElementOnlineAppoClicked = "cpj0rf";

  @override
  final menuElementHealthTrackerClicked = "49dlhe";

  @override
  final menuElementAppointmentsClicked = "guwigx";

  @override
  final menuElementResultsClicked = "wmzdyf";

  @override
  final menuElementForYouClicked = "z8sk2a";

  @override
  final menuElementSymptomCheckerClicked = "cp0oio";

  @override
  final menuElementDevicesClicked = "rttp59";

  @override
  final menuElementRemindersClicked = "hpsxdn";

  @override
  final menuElementSuggestionsClicked = "v5dodw";

  @override
  final searchCreateAppointment = "f91ouo";

  @override
  final healthTrackerButtons = "zhrfdd";

  @override
  final mySymptomsPage1 = "c3dx1z";

  @override
  final mySymptomsPage2 = "ahdywy";

  @override
  final mySymptomsPage3 = "n2z16t";

  @override
  final mySymptomsPage4DepartmentAnalysis = "dyeud2";

  @override
  final myResultsSearchAppointment = "c6h3h4";

  @override
  final logOut = "ihw9p0";

  @override
  final forYouPageClicked = "dpnqva";

  @override
  final newDownloads = "rsml96";

  @override
  final successfulVideoCall = "4llqz6";

  @override
  final successfulRelativeDeletion = "dc34w5";

  @override
  final successfulPayment = "wvqbcc";

  @override
  final forYouCategoryClicked = "kvdzsj";

  @override
  final forYouSubCategoryClicked = "2ribmy";

  @override
  final forYouPackageSummaryClicked = "xd4t3j";

  @override
  final forYouItemPaymentClicked = "lt0z0h";

  @override
  final mainPageOAClicked = "2ftzvq";

  @override
  final mainPagePcrTestClicked = "4gwqqg";

  @override
  final mainPageFindDoctorClicked = "q7k5q6";

  @override
  final mainPageMyAppointmentsClicked = "wvq9hk";

  @override
  final mainPageMyResultsClicked = "ts6j50";

  @override
  final mainPageCounselingLineClicked = "v6lyqz";

  @override
  final findDoctorTabClicked = "ovn5sg";

  @override
  final myAppointmentsTabClicked = "6rj3zc";

  @override
  final mainPageTabClicked = "p91pmy";

  @override
  final myProfileTabClicked = "4ov0ec";

  @override
  final oaDepartmentSelection = "a9qfnv";

  @override
  final oaDoctorSelection = "dseepq";

  @override
  final takeAppointmentDoctorDetails = "hlf3ku";

  @override
  final pcrTestHospitalSelection = "7lxbki";

  @override
  final successfulPasswordChange = "cutzy7";

  @override
  final relativesTabClicked = "sser7e";

  @override
  final relativeSwitchSuccessful = "lwcgya";

  @override
  final successfulRelativeAdd = "r1k91r";

  @override
  final successfulRelativeMainAccountSwitch = "m4zngn";

  @override
  final personalInformationClicked = "eswkij";

  @override
  final uploadProfilePicture = "pbavbr";

  @override
  final deleteProfilePicture = "5v6ii0";

  @override
  final unsuccessfulPasswordChange = "ibb356";

  @override
  final unsuccessfulRelativeSwitch = "7d27gi";

  @override
  final unsuccessfulRelativeAdd = "9xtf38";

  @override
  final unccessfulRelativeMainAccountSwitchEvent = "7m63s1";

  @override
  final unsuccessfulRelativeDeletion = "9oy0yy";

  @override
  final unsuccessfulRegisterStep1 = "5swn1m";
}

class _GuvenOnlineEventConstants extends AdjustConstants {
  @override
  final bottomBarClicked = "khu88v";

  @override
  final successfulLogin = "8sqe4g";

  @override
  final detailedSymptom = "k20scn";

  @override
  final menuButtonClicked = "tlw11k";

  @override
  final menuElementProfileClicked = "fghm1j";

  @override
  final menuElementHospitalAppointmentClicked = "pijg1n";

  @override
  final menuElementOnlineAppoClicked = "4gan0y";

  @override
  final menuElementHealthTrackerClicked = "bbs00j";

  @override
  final menuElementAppointmentsClicked = "ok0oi3";

  @override
  final menuElementResultsClicked = "qjzo3m";

  @override
  final menuElementForYouClicked = "gjzzgc";

  @override
  final menuElementSymptomCheckerClicked = "vgwi9b";

  @override
  final menuElementDevicesClicked = "h8ifus";

  @override
  final menuElementRemindersClicked = "enil6j";

  @override
  final menuElementSuggestionsClicked = "vpysce";

  @override
  final searchCreateAppointment = "e6g9a2";

  @override
  final healthTrackerButtons = "httskd";

  @override
  final mySymptomsPage1 = "59jxtk";

  @override
  final mySymptomsPage2 = "cd55ql";

  @override
  final mySymptomsPage3 = "e2ovww";

  @override
  final mySymptomsPage4DepartmentAnalysis = "j6uc7c";

  @override
  final myResultsSearchAppointment = "gxrszf";

  @override
  final logOut = "ihw9p0";

  @override
  final forYouPageClicked = "4ofik7";

  @override
  final newDownloads = "mc3w9b";

  @override
  final successfulVideoCall = "197n1w";

  @override
  final successfulRelativeDeletion = "xq0m88";

  @override
  final successfulPayment = "7l8fms";

  @override
  final forYouCategoryClicked = "5au1nh";

  @override
  final forYouSubCategoryClicked = "fk34sf";

  @override
  final forYouPackageSummaryClicked = "no3rt8";

  @override
  final forYouItemPaymentClicked = "tp6wxp";

  @override
  final mainPageOAClicked = "cnwdss";

  @override
  final mainPagePcrTestClicked = "nhq16b";

  @override
  final mainPageFindDoctorClicked = "hjxw4y";

  @override
  final mainPageMyAppointmentsClicked = "ti44ge";

  @override
  final mainPageMyResultsClicked = "5hitl5";

  @override
  final mainPageCounselingLineClicked = "hnezai";

  @override
  final findDoctorTabClicked = "7q8cf3";

  @override
  final myAppointmentsTabClicked = "2adgzc";

  @override
  final mainPageTabClicked = "ogwm86";

  @override
  final myProfileTabClicked = "3ueq3x";

  @override
  final oaDepartmentSelection = "zi0ctu";

  @override
  final oaDoctorSelection = "x3dxbq";

  @override
  final takeAppointmentDoctorDetails = "sgi3b7";

  @override
  final pcrTestHospitalSelection = "n14jzp";

  @override
  final successfulPasswordChange = "3sqrhh";

  @override
  final relativesTabClicked = "yhcbfa";

  @override
  final relativeSwitchSuccessful = "mbbfrl";

  @override
  final successfulRelativeAdd = "vcegxl";

  @override
  final successfulRelativeMainAccountSwitch = "7r5q4d";

  @override
  final personalInformationClicked = "1ztdn1";

  @override
  final uploadProfilePicture = "d8ubop";

  @override
  final deleteProfilePicture = "y8vkrq";

  @override
  final unsuccessfulPasswordChange = "7pqrni";

  @override
  final unsuccessfulRelativeSwitch = "agmlb6";

  @override
  final unsuccessfulRelativeAdd = "ht91wu";

  @override
  final unccessfulRelativeMainAccountSwitchEvent = "sts62r";

  @override
  final unsuccessfulRelativeDeletion = "xefzyc";

  @override
  final unsuccessfulRegisterStep1 = "p3wk5v";
}

class BottomBarClickedEvent extends AdjustBaseEvent {
  BottomBarClickedEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .bottomBarClicked);
}

class SuccessfulLoginEvent extends AdjustBaseEvent {
  SuccessfulLoginEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .successfulLogin);
}

class DetailedSymptomEvent extends AdjustBaseEvent {
  DetailedSymptomEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .detailedSymptom);
}

class MenuButtonClickedEvent extends AdjustBaseEvent {
  MenuButtonClickedEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .menuButtonClicked);
}

class MenuElementProfileClickedEvent extends AdjustBaseEvent {
  MenuElementProfileClickedEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .menuElementProfileClicked);
}

class MenuElementHospitalAppointmentClickedEvent extends AdjustBaseEvent {
  MenuElementHospitalAppointmentClickedEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .menuElementHospitalAppointmentClicked);
}

class MenuElementOnlineAppoClickedEvent extends AdjustBaseEvent {
  MenuElementOnlineAppoClickedEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .menuElementOnlineAppoClicked);
}

class MenuElementHealthTrackerClickedEvent extends AdjustBaseEvent {
  MenuElementHealthTrackerClickedEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .menuElementHealthTrackerClicked);
}

class MenuElementAppointmentsClickedEvent extends AdjustBaseEvent {
  MenuElementAppointmentsClickedEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .menuElementAppointmentsClicked);
}

class MenuElementResultsClickedEvent extends AdjustBaseEvent {
  MenuElementResultsClickedEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .menuElementResultsClicked);
}

class MenuElementForYouClickedEvent extends AdjustBaseEvent {
  MenuElementForYouClickedEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .menuElementForYouClicked);
}

class MenuElementSymptomCheckerClickedEvent extends AdjustBaseEvent {
  MenuElementSymptomCheckerClickedEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .menuElementSymptomCheckerClicked);
}

class MenuElementDevicesClickedEvent extends AdjustBaseEvent {
  MenuElementDevicesClickedEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .menuElementDevicesClicked);
}

class MenuElementRemindersClickedEvent extends AdjustBaseEvent {
  MenuElementRemindersClickedEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .menuElementRemindersClicked);
}

class MenuElementSuggestionsClickedEvent extends AdjustBaseEvent {
  MenuElementSuggestionsClickedEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .menuElementSuggestionsClicked);
}

class SearchCreateAppointmentEvent extends AdjustBaseEvent {
  SearchCreateAppointmentEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .searchCreateAppointment);
}

class HealthTrackerButtonsEvent extends AdjustBaseEvent {
  HealthTrackerButtonsEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .healthTrackerButtons);
}

class MySymptomsPage1Event extends AdjustBaseEvent {
  MySymptomsPage1Event()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .mySymptomsPage1);
}

class MySymptomsPage2Event extends AdjustBaseEvent {
  MySymptomsPage2Event()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .mySymptomsPage2);
}

class MySymptomsPage3Event extends AdjustBaseEvent {
  MySymptomsPage3Event()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .mySymptomsPage3);
}

class MySymptomsPage4DepartmentAnalysisEvent extends AdjustBaseEvent {
  MySymptomsPage4DepartmentAnalysisEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .mySymptomsPage4DepartmentAnalysis);
}

class MyResultsSearchAppointmentEvent extends AdjustBaseEvent {
  MyResultsSearchAppointmentEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .myResultsSearchAppointment);
}

class LogOutEvent extends AdjustBaseEvent {
  LogOutEvent()
      : super(getIt<IAppConfig>().platform.adjustManager?.constants.logOut);
}

class NewDownloadsEvent extends AdjustBaseEvent {
  NewDownloadsEvent()
      : super(
            getIt<IAppConfig>().platform.adjustManager?.constants.newDownloads);
}

class SuccessfulVideoCallEvent extends AdjustBaseEvent {
  SuccessfulVideoCallEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .successfulVideoCall);
}

class SuccessfulPaymentEvent extends AdjustBaseEvent {
  SuccessfulPaymentEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .successfulPayment);
}

class ForYouCategoryClickedEvent extends AdjustBaseEvent {
  ForYouCategoryClickedEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .forYouCategoryClicked);
}

class ForYouSubCategoryClickedEvent extends AdjustBaseEvent {
  ForYouSubCategoryClickedEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .forYouSubCategoryClicked);
}

class ForYouPackageSummaryClickedEvent extends AdjustBaseEvent {
  ForYouPackageSummaryClickedEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .forYouPackageSummaryClicked);
}

class ForYouItemPaymentClickedEvent extends AdjustBaseEvent {
  ForYouItemPaymentClickedEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .forYouItemPaymentClicked);
}

class SuccessfulPasswordChangeEvent extends AdjustBaseEvent {
  SuccessfulPasswordChangeEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .successfulPasswordChange);
}

class MainPagePcrTestClickedEvent extends AdjustBaseEvent {
  MainPagePcrTestClickedEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .mainPagePcrTestClicked);
}

class SuccessfulRelativeAddEvent extends AdjustBaseEvent {
  SuccessfulRelativeAddEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .successfulRelativeAdd);
}

//#region No Reference
class SuccessfulRelativeDeletionEvent extends AdjustBaseEvent {
  SuccessfulRelativeDeletionEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .successfulRelativeDeletion);
}

class MainPageOAClickedEvent extends AdjustBaseEvent {
  MainPageOAClickedEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .mainPageOAClicked);
}

class MainPageFindDoctorClickedEvent extends AdjustBaseEvent {
  MainPageFindDoctorClickedEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .mainPageFindDoctorClicked);
}

class MainPageMyAppointmentsClickedEvent extends AdjustBaseEvent {
  MainPageMyAppointmentsClickedEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .mainPageMyAppointmentsClicked);
}

class MainPageMyResultsClickedEvent extends AdjustBaseEvent {
  MainPageMyResultsClickedEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .mainPageMyResultsClicked);
}

class MainPageCounselingLineClickedEvent extends AdjustBaseEvent {
  MainPageCounselingLineClickedEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .mainPageCounselingLineClicked);
}

class FindDoctorTabClickedEvent extends AdjustBaseEvent {
  FindDoctorTabClickedEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .findDoctorTabClicked);
}

class MyAppointmentsTabClickedEvent extends AdjustBaseEvent {
  MyAppointmentsTabClickedEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .myAppointmentsTabClicked);
}

class MainPageTabClickedEvent extends AdjustBaseEvent {
  MainPageTabClickedEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .mainPageTabClicked);
}

class MyProfileTabClickedEvent extends AdjustBaseEvent {
  MyProfileTabClickedEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .myProfileTabClicked);
}

class OaDepartmentSelectionEvent extends AdjustBaseEvent {
  OaDepartmentSelectionEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .oaDepartmentSelection);
}

class OaDoctorSelectionEvent extends AdjustBaseEvent {
  OaDoctorSelectionEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .oaDoctorSelection);
}

class TakeAppointmentDoctorDetailsEvent extends AdjustBaseEvent {
  TakeAppointmentDoctorDetailsEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .takeAppointmentDoctorDetails);
}

class PcrTestHospitalSelectionEvent extends AdjustBaseEvent {
  PcrTestHospitalSelectionEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .pcrTestHospitalSelection);
}

class RelativesTabClickedEvent extends AdjustBaseEvent {
  RelativesTabClickedEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .relativesTabClicked);
}

class RelativeSwitchSuccessfulEvent extends AdjustBaseEvent {
  RelativeSwitchSuccessfulEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .relativeSwitchSuccessful);
}

class SuccessfulRelativeMainAccountSwitchEvent extends AdjustBaseEvent {
  SuccessfulRelativeMainAccountSwitchEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .successfulRelativeMainAccountSwitch);
}

class PersonalInformationClickedEvent extends AdjustBaseEvent {
  PersonalInformationClickedEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .personalInformationClicked);
}

class UploadProfilePictureEvent extends AdjustBaseEvent {
  UploadProfilePictureEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .uploadProfilePicture);
}

class DeleteProfilePictureEvent extends AdjustBaseEvent {
  DeleteProfilePictureEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .deleteProfilePicture);
}

class UnsuccessfulRelativeSwitchEvent extends AdjustBaseEvent {
  UnsuccessfulRelativeSwitchEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .unsuccessfulRelativeSwitch);
}

class UnccessfulRelativeMainAccountSwitchEvent extends AdjustBaseEvent {
  UnccessfulRelativeMainAccountSwitchEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .unccessfulRelativeMainAccountSwitchEvent);
}

class UnsuccessfulRelativeDeletionEvent extends AdjustBaseEvent {
  UnsuccessfulRelativeDeletionEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .unsuccessfulRelativeDeletion);
}

class ForYouPageClickedEvent extends AdjustBaseEvent {
  ForYouPageClickedEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .forYouPageClicked);
}
//#endregion

//#region FailEvents
class UnsuccessfulPasswordChangeEvent extends AdjustBaseEvent {
  UnsuccessfulPasswordChangeEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .unsuccessfulPasswordChange);
}

class UnsuccessfulRelativeAddEvent extends AdjustBaseEvent {
  UnsuccessfulRelativeAddEvent()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .unsuccessfulRelativeAdd);
}

class UnsuccessfulRegisterStep1Event extends AdjustBaseEvent {
  UnsuccessfulRegisterStep1Event()
      : super(getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.constants
            .unsuccessfulRegisterStep1);
}
//#endregion


