import 'package:adjust_sdk/adjust.dart';
import 'package:adjust_sdk/adjust_config.dart';
import 'package:adjust_sdk/adjust_event.dart';
import 'package:flutter/foundation.dart';

class AdjustBaseEvent {
  late final String token;
  late final String unitPrice;

  AdjustBaseEvent(
    this.token,
  );

  @override
  String toString() => "Event_Name: ${token.toString()}";
}

class AdjustManager {
  void initializeAdjust() {
    final adjustConfig =
        AdjustConfig('1vvx05nbpkio', AdjustEnvironment.production);
    adjustConfig.setAppSecret(1, 492801584, 1304692510, 331550936, 2085469560);
    Adjust.start(adjustConfig);
    adjustConfig.logLevel = AdjustLogLevel.verbose;
  }



   void initializeAdjust() {
    final adjustConfig =
        AdjustConfig('xe34hcactfk0', AdjustEnvironment.production);
    adjustConfig.setAppSecret(1, 413165747, 1265213513, 190651275, 1454099636);
    Adjust.start(adjustConfig);
    adjustConfig.logLevel = AdjustLogLevel.verbose;
  }

  // Firebase analytics log event fonksiyonu gibi event oluşturur
  void trackEvent(AdjustBaseEvent eventToken) {
    if (!kIsWeb) {
      AdjustEvent adjustEvent = AdjustEvent(eventToken.token);
      Adjust.trackEvent(adjustEvent);
    }
  }

  void setRevenue(String eventToken, int unitPrice) {
    AdjustEvent adjustEvent = AdjustEvent(eventToken);
    adjustEvent.setRevenue(unitPrice, 'TRY');
    Adjust.trackEvent(adjustEvent);
  }
}

class _EventConstants {
  static const bottomBarClicked = "vwg8bv";
  static const successfulLogin = "vy6mgv";
  static const detailedSymptom = "h4tj9v";
  static const menuButtonClicked = "jhcyym";
  static const menuElementProfileClicked = "1aa4xx";
  static const menuElementHospitalAppointmentClicked = "fw7xdi";
  static const menuElementOnlineAppoClicked = "cpj0rf";
  static const menuElementHealthTrackerClicked = "49dlhe";
  static const menuElementAppointmentsClicked = "guwigx";
  static const menuElementResultsClicked = "wmzdyf";
  static const menuElementForYouClicked = "z8sk2a";
  static const menuElementSymptomCheckerClicked = "cp0oio";
  static const menuElementDevicesClicked = "rttp59";
  static const menuElementRemindersClicked = "hpsxdn";
  static const menuElementSuggestionsClicked = "v5dodw";
  static const searchCreateAppointment = "f91ouo";
  static const healthTrackerButtons = "zhrfdd";
  static const mySymptomsPage1 = "c3dx1z";
  static const mySymptomsPage2 = "ahdywy";
  static const mySymptomsPage3 = "n2z16t";
  static const mySymptomsPage4DepartmentAnalysis = "dyeud2";
  static const myResultsSearchAppointment = "c6h3h4";
  static const logOut = "ihw9p0";
  static const forYouPageClicked = "dpnqva";
  static const newDownloads = "rsml96";
  static const successfulVideoCall = "4llqz6";
  static const successfulRelativeDeletion = "dc34w5";
  static const successfulPayment = "wvqbcc";
  static const forYouCategoryClicked = "kvdzsj";
  static const forYouSubCategoryClicked = "2ribmy";
  static const forYouPackageSummaryClicked = "xd4t3j";
  static const forYouItemPaymentClicked = "lt0z0h";
  static const mainPageOAClicked = "2ftzvq";
  static const mainPagePcrTestClicked = "4gwqqg";
  static const mainPageFindDoctorClicked = "q7k5q6";
  static const mainPageMyAppointmentsClicked = "wvq9hk";
  static const mainPageMyResultsClicked = "ts6j50";
  static const mainPageCounselingLineClicked = "v6lyqz";
  static const findDoctorTabClicked = "ovn5sg";
  static const myAppointmentsTabClicked = "6rj3zc";
  static const mainPageTabClicked = "p91pmy";
  static const myProfileTabClicked = "4ov0ec";
  static const oaDepartmentSelection = "a9qfnv";
  static const oaDoctorSelection = "dseepq";
  static const takeAppointmentDoctorDetails = "hlf3ku";
  static const pcrTestHospitalSelection = "7lxbki";
  static const successfulPasswordChange = "cutzy7";
  static const relativesTabClicked = "sser7e";
  static const relativeSwitchSuccessful = "lwcgya";
  static const successfulRelativeAdd = "r1k91r";
  static const successfulRelativeMainAccountSwitch = "m4zngn";
  static const personalInformationClicked = "eswkij";
  static const uploadProfilePicture = "pbavbr";
  static const deleteProfilePicture = "5v6ii0";
  static const unsuccessfulPasswordChange = "ibb356";
  static const unsuccessfulRelativeSwitch = "7d27gi";
  static const unsuccessfulRelativeAdd = "9xtf38";
  static const unccessfulRelativeMainAccountSwitchEvent = "7m63s1";
  static const unsuccessfulRelativeDeletion = "9oy0yy";
  static const unsuccessfulRegisterStep1 = "5swn1m";
}

class _EventConstants {
  static const bottomBarClicked = "khu88v";
  static const successfulLogin = "8sqe4g";
  static const detailedSymptom = "k20scn";
  static const menuButtonClicked = "tlw11k";
  static const menuElementProfileClicked = "fghm1j";
  static const menuElementHospitalAppointmentClicked = "pijg1n";
  static const menuElementOnlineAppoClicked = "4gan0y";
  static const menuElementHealthTrackerClicked = "bbs00j";
  static const menuElementAppointmentsClicked = "ok0oi3";
  static const menuElementResultsClicked = "qjzo3m";
  static const menuElementForYouClicked = "gjzzgc";
  static const menuElementSymptomCheckerClicked = "vgwi9b";
  static const menuElementDevicesClicked = "h8ifus";
  static const menuElementRemindersClicked = "enil6j";
  static const menuElementSuggestionsClicked = "vpysce";
  static const searchCreateAppointment = "e6g9a2";
  static const healthTrackerButtons = "httskd";
  static const mySymptomsPage1 = "59jxtk";
  static const mySymptomsPage2 = "cd55ql";
  static const mySymptomsPage3 = "e2ovww";
  static const mySymptomsPage4DepartmentAnalysis = "j6uc7c";
  static const myResultsSearchAppointment = "gxrszf";
  static const logOut = "ihw9p0";
  static const forYouPageClicked = "4ofik7";
  static const newDownloads = "mc3w9b";
  static const successfulVideoCall = "197n1w";
  static const successfulRelativeDeletion = "xq0m88";
  static const successfulPayment = "7l8fms";
  static const forYouCategoryClicked = "5au1nh";
  static const forYouSubCategoryClicked = "fk34sf";
  static const forYouPackageSummaryClicked = "no3rt8";
  static const forYouItemPaymentClicked = "tp6wxp";
  static const mainPageOAClicked = "cnwdss";
  static const mainPagePcrTestClicked = "nhq16b";
  static const mainPageFindDoctorClicked = "hjxw4y";
  static const mainPageMyAppointmentsClicked = "ti44ge";
  static const mainPageMyResultsClicked = "5hitl5";
  static const mainPageCounselingLineClicked = "hnezai";
  static const findDoctorTabClicked = "7q8cf3";
  static const myAppointmentsTabClicked = "2adgzc";
  static const mainPageTabClicked = "ogwm86";
  static const myProfileTabClicked = "3ueq3x";
  static const oaDepartmentSelection = "zi0ctu";
  static const oaDoctorSelection = "x3dxbq";
  static const takeAppointmentDoctorDetails = "sgi3b7";
  static const pcrTestHospitalSelection = "n14jzp";
  static const successfulPasswordChange = "3sqrhh";
  static const relativesTabClicked = "yhcbfa";
  static const relativeSwitchSuccessful = "mbbfrl";
  static const successfulRelativeAdd = "vcegxl";
  static const successfulRelativeMainAccountSwitch = "7r5q4d";
  static const personalInformationClicked = "1ztdn1";
  static const uploadProfilePicture = "d8ubop";
  static const deleteProfilePicture = "y8vkrq";
  static const unsuccessfulPasswordChange = "7pqrni";
  static const unsuccessfulRelativeSwitch = "agmlb6";
  static const unsuccessfulRelativeAdd = "ht91wu";
  static const unccessfulRelativeMainAccountSwitchEvent = "sts62r";
  static const unsuccessfulRelativeDeletion = "xefzyc";
 static const unsuccessfulRegisterStep1 = "p3wk5v”;

class BottomBarClickedEvent extends AdjustBaseEvent {
  BottomBarClickedEvent() : super(_EventConstants.bottomBarClicked);
}

class SuccessfulLoginEvent extends AdjustBaseEvent {
  SuccessfulLoginEvent() : super(_EventConstants.successfulLogin);
}

class DetailedSymptomEvent extends AdjustBaseEvent {
  DetailedSymptomEvent() : super(_EventConstants.detailedSymptom);
}

class MenuButtonClickedEvent extends AdjustBaseEvent {
  MenuButtonClickedEvent() : super(_EventConstants.menuButtonClicked);
}

class MenuElementProfileClickedEvent extends AdjustBaseEvent {
  MenuElementProfileClickedEvent()
      : super(_EventConstants.menuElementProfileClicked);
}

class MenuElementHospitalAppointmentClickedEvent extends AdjustBaseEvent {
  MenuElementHospitalAppointmentClickedEvent()
      : super(_EventConstants.menuElementHospitalAppointmentClicked);
}

class MenuElementOnlineAppoClickedEvent extends AdjustBaseEvent {
  MenuElementOnlineAppoClickedEvent()
      : super(_EventConstants.menuElementOnlineAppoClicked);
}

class MenuElementHealthTrackerClickedEvent extends AdjustBaseEvent {
  MenuElementHealthTrackerClickedEvent()
      : super(_EventConstants.menuElementHealthTrackerClicked);
}

class MenuElementAppointmentsClickedEvent extends AdjustBaseEvent {
  MenuElementAppointmentsClickedEvent()
      : super(_EventConstants.menuElementAppointmentsClicked);
}

class MenuElementResultsClickedEvent extends AdjustBaseEvent {
  MenuElementResultsClickedEvent()
      : super(_EventConstants.menuElementResultsClicked);
}

class MenuElementForYouClickedEvent extends AdjustBaseEvent {
  MenuElementForYouClickedEvent()
      : super(_EventConstants.menuElementForYouClicked);
}

class MenuElementSymptomCheckerClickedEvent extends AdjustBaseEvent {
  MenuElementSymptomCheckerClickedEvent()
      : super(_EventConstants.menuElementSymptomCheckerClicked);
}

class MenuElementDevicesClickedEvent extends AdjustBaseEvent {
  MenuElementDevicesClickedEvent()
      : super(_EventConstants.menuElementDevicesClicked);
}

class MenuElementRemindersClickedEvent extends AdjustBaseEvent {
  MenuElementRemindersClickedEvent()
      : super(_EventConstants.menuElementRemindersClicked);
}

class MenuElementSuggestionsClickedEvent extends AdjustBaseEvent {
  MenuElementSuggestionsClickedEvent()
      : super(_EventConstants.menuElementSuggestionsClicked);
}

class SearchCreateAppointmentEvent extends AdjustBaseEvent {
  SearchCreateAppointmentEvent()
      : super(_EventConstants.searchCreateAppointment);
}

class HealthTrackerButtonsEvent extends AdjustBaseEvent {
  HealthTrackerButtonsEvent() : super(_EventConstants.healthTrackerButtons);
}

class MySymptomsPage1Event extends AdjustBaseEvent {
  MySymptomsPage1Event() : super(_EventConstants.mySymptomsPage1);
}

class MySymptomsPage2Event extends AdjustBaseEvent {
  MySymptomsPage2Event() : super(_EventConstants.mySymptomsPage2);
}

class MySymptomsPage3Event extends AdjustBaseEvent {
  MySymptomsPage3Event() : super(_EventConstants.mySymptomsPage3);
}

class MySymptomsPage4DepartmentAnalysisEvent extends AdjustBaseEvent {
  MySymptomsPage4DepartmentAnalysisEvent()
      : super(_EventConstants.mySymptomsPage4DepartmentAnalysis);
}

class MyResultsSearchAppointmentEvent extends AdjustBaseEvent {
  MyResultsSearchAppointmentEvent()
      : super(_EventConstants.myResultsSearchAppointment);
}

class LogOutEvent extends AdjustBaseEvent {
  LogOutEvent() : super(_EventConstants.logOut);
}

class NewDownloadsEvent extends AdjustBaseEvent {
  NewDownloadsEvent() : super(_EventConstants.newDownloads);
}

class SuccessfulVideoCallEvent extends AdjustBaseEvent {
  SuccessfulVideoCallEvent() : super(_EventConstants.successfulVideoCall);
}

class SuccessfulPaymentEvent extends AdjustBaseEvent {
  SuccessfulPaymentEvent() : super(_EventConstants.successfulPayment);
}

class ForYouCategoryClickedEvent extends AdjustBaseEvent {
  ForYouCategoryClickedEvent() : super(_EventConstants.forYouCategoryClicked);
}

class ForYouSubCategoryClickedEvent extends AdjustBaseEvent {
  ForYouSubCategoryClickedEvent()
      : super(_EventConstants.forYouSubCategoryClicked);
}

class ForYouPackageSummaryClickedEvent extends AdjustBaseEvent {
  ForYouPackageSummaryClickedEvent()
      : super(_EventConstants.forYouPackageSummaryClicked);
}

class ForYouItemPaymentClickedEvent extends AdjustBaseEvent {
  ForYouItemPaymentClickedEvent()
      : super(_EventConstants.forYouItemPaymentClicked);
}

class SuccessfulPasswordChangeEvent extends AdjustBaseEvent {
  SuccessfulPasswordChangeEvent()
      : super(_EventConstants.successfulPasswordChange);
}

class MainPagePcrTestClickedEvent extends AdjustBaseEvent {
  MainPagePcrTestClickedEvent() : super(_EventConstants.mainPagePcrTestClicked);
}

class SuccessfulRelativeAddEvent extends AdjustBaseEvent {
  SuccessfulRelativeAddEvent() : super(_EventConstants.successfulRelativeAdd);
}

//#region No Reference

class SuccessfulRelativeDeletionEvent extends AdjustBaseEvent {
  SuccessfulRelativeDeletionEvent()
      : super(_EventConstants.successfulRelativeDeletion);
}

class MainPageOAClickedEvent extends AdjustBaseEvent {
  MainPageOAClickedEvent() : super(_EventConstants.mainPageOAClicked);
}

class MainPageFindDoctorClickedEvent extends AdjustBaseEvent {
  MainPageFindDoctorClickedEvent()
      : super(_EventConstants.mainPageFindDoctorClicked);
}

class MainPageMyAppointmentsClickedEvent extends AdjustBaseEvent {
  MainPageMyAppointmentsClickedEvent()
      : super(_EventConstants.mainPageMyAppointmentsClicked);
}

class MainPageMyResultsClickedEvent extends AdjustBaseEvent {
  MainPageMyResultsClickedEvent()
      : super(_EventConstants.mainPageMyResultsClicked);
}

class MainPageCounselingLineClickedEvent extends AdjustBaseEvent {
  MainPageCounselingLineClickedEvent()
      : super(_EventConstants.mainPageCounselingLineClicked);
}

class FindDoctorTabClickedEvent extends AdjustBaseEvent {
  FindDoctorTabClickedEvent() : super(_EventConstants.findDoctorTabClicked);
}

class MyAppointmentsTabClickedEvent extends AdjustBaseEvent {
  MyAppointmentsTabClickedEvent()
      : super(_EventConstants.myAppointmentsTabClicked);
}

class MainPageTabClickedEvent extends AdjustBaseEvent {
  MainPageTabClickedEvent() : super(_EventConstants.mainPageTabClicked);
}

class MyProfileTabClickedEvent extends AdjustBaseEvent {
  MyProfileTabClickedEvent() : super(_EventConstants.myProfileTabClicked);
}

class OaDepartmentSelectionEvent extends AdjustBaseEvent {
  OaDepartmentSelectionEvent() : super(_EventConstants.oaDepartmentSelection);
}

class OaDoctorSelectionEvent extends AdjustBaseEvent {
  OaDoctorSelectionEvent() : super(_EventConstants.oaDoctorSelection);
}

class TakeAppointmentDoctorDetailsEvent extends AdjustBaseEvent {
  TakeAppointmentDoctorDetailsEvent()
      : super(_EventConstants.takeAppointmentDoctorDetails);
}

class PcrTestHospitalSelectionEvent extends AdjustBaseEvent {
  PcrTestHospitalSelectionEvent()
      : super(_EventConstants.pcrTestHospitalSelection);
}

class RelativesTabClickedEvent extends AdjustBaseEvent {
  RelativesTabClickedEvent() : super(_EventConstants.relativesTabClicked);
}

class RelativeSwitchSuccessfulEvent extends AdjustBaseEvent {
  RelativeSwitchSuccessfulEvent()
      : super(_EventConstants.relativeSwitchSuccessful);
}

class SuccessfulRelativeMainAccountSwitchEvent extends AdjustBaseEvent {
  SuccessfulRelativeMainAccountSwitchEvent()
      : super(_EventConstants.successfulRelativeMainAccountSwitch);
}

class PersonalInformationClickedEvent extends AdjustBaseEvent {
  PersonalInformationClickedEvent()
      : super(_EventConstants.personalInformationClicked);
}

class UploadProfilePictureEvent extends AdjustBaseEvent {
  UploadProfilePictureEvent() : super(_EventConstants.uploadProfilePicture);
}

class DeleteProfilePictureEvent extends AdjustBaseEvent {
  DeleteProfilePictureEvent() : super(_EventConstants.deleteProfilePicture);
}

class UnsuccessfulRelativeSwitchEvent extends AdjustBaseEvent {
  UnsuccessfulRelativeSwitchEvent()
      : super(_EventConstants.unsuccessfulRelativeSwitch);
}

class UnccessfulRelativeMainAccountSwitchEvent extends AdjustBaseEvent {
  UnccessfulRelativeMainAccountSwitchEvent()
      : super(_EventConstants.unccessfulRelativeMainAccountSwitchEvent);
}

class UnsuccessfulRelativeDeletionEvent extends AdjustBaseEvent {
  UnsuccessfulRelativeDeletionEvent()
      : super(_EventConstants.unsuccessfulRelativeDeletion);
}

class ForYouPageClickedEvent extends AdjustBaseEvent {
  ForYouPageClickedEvent() : super(_EventConstants.forYouPageClicked);
}
//#endregion

//#region FailEvents

class UnsuccessfulPasswordChangeEvent extends AdjustBaseEvent {
  UnsuccessfulPasswordChangeEvent()
      : super(_EventConstants.unsuccessfulPasswordChange);
}

class UnsuccessfulRelativeAddEvent extends AdjustBaseEvent {
  UnsuccessfulRelativeAddEvent()
      : super(_EventConstants.unsuccessfulRelativeAdd);
}

class UnsuccessfulRegisterStep1Event extends AdjustBaseEvent {
  UnsuccessfulRegisterStep1Event()
      : super(_EventConstants.unsuccessfulRegisterStep1);
}

//#endregion


