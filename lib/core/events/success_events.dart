import 'base_event.dart';

class LoginSuccessEvent extends BaseEvent {
  LoginSuccessEvent() : super("Basarili_Giris", null);
}

class ForYouPageClickEvent extends BaseEvent {
  ForYouPageClickEvent() : super("Size_Özel_sayfası_Tiklama", null);
}

// Home Page - Main
class OnlineAppointmentClickEvent extends BaseEvent {
  OnlineAppointmentClickEvent() : super("AnaSayfa_OnlineRandevu_Tiklama", null);
}

class WhatIsCovid19ClickEvent extends BaseEvent {
  WhatIsCovid19ClickEvent() : super("AnaSayfa_Covid19Nedir_Tiklama", null);
}

class Covid19PcrTestClickEvent extends BaseEvent {
  Covid19PcrTestClickEvent() : super("AnaSayfa_pcrTesti_Tiklama", null);
}

class FindDoctorClickEvent extends BaseEvent {
  FindDoctorClickEvent() : super("AnaSayfa_DoktorBul_Tiklama", null);
}

class FindHospitalClickEvent extends BaseEvent {
  FindHospitalClickEvent() : super("AnaSayfa_HastaneBul_Tiklama", null);
}

class MyAppointmentsClickEvent extends BaseEvent {
  MyAppointmentsClickEvent() : super("AnaSayfa_Randevularim_Tiklama", null);
}

class MyResultsClickEvent extends BaseEvent {
  MyResultsClickEvent() : super("AnaSayfa_Sonuclarim_Tiklama", null);
}

class LiveSupportClickEvent extends BaseEvent {
  LiveSupportClickEvent() : super("AnaSayfa_DestekHatti_Tiklama", null);
}

// Home Page - Tabs
class FindDoctorTabClickEvent extends BaseEvent {
  FindDoctorTabClickEvent() : super("DoktorBul_TabTiklama", null);
}

class MyAppointmentsTabClickEvent extends BaseEvent {
  MyAppointmentsTabClickEvent() : super("Randevularim_TabTiklama", null);
}

class HomePageTabClickEvent extends BaseEvent {
  HomePageTabClickEvent() : super("AnaSayfa_TabTiklama", null);
}

class MyResultsTabClickEvent extends BaseEvent {
  MyResultsTabClickEvent() : super("Sonuclarim_TabTiklama", null);
}

class ProfileTabClickEvent extends BaseEvent {
  ProfileTabClickEvent() : super("Profilim_TabTiklama", null);
}

// Find Page
// OA -> OnlineAppointment
class OADepartmentSelectionEvent extends BaseEvent {
  OADepartmentSelectionEvent(String department)
      : super("OnlineRandevu_BirimSecimi", {
          'birim_adi': department,
        });
}

class OADoctorSelectionEvent extends BaseEvent {
  OADoctorSelectionEvent(String department, String doctorName)
      : super("OnlineRandevu_DoktorSecimi",
            {'birim_adi': department, 'doktor_adi': doctorName});
}

class OAMakeAppointmentClickEvent extends BaseEvent {
  OAMakeAppointmentClickEvent(String department, String doctorName)
      : super("DoktorDetay_RandevuAl",
            {'birim_adi': department, 'doktor_adi': doctorName});
}

class OADoctorCareerClickEvent extends BaseEvent {
  OADoctorCareerClickEvent(String department, String doctorName)
      : super("DoktorDetay_Kariyer",
            {'birim_adi': department, 'doktor_adi': doctorName});
}

class OADoctorCVClickEvent extends BaseEvent {
  OADoctorCVClickEvent(String department, String doctorName)
      : super("DoktorDetay_Ozgecmis",
            {'birim_adi': department, 'doktor_adi': doctorName});
}

class OADateTimeSelectionEvent extends BaseEvent {
  OADateTimeSelectionEvent(String department, String doctorName,
      String appointmentType, String hospitalName)
      : super("OnlineRandevu_RandevuSecimi", {
          'birim_adi': department,
          'doktor_adi': doctorName,
          'randevu_tipi': appointmentType,
          'hastane_adi': hospitalName
        });
}

class OAPaymentDetailEvent extends BaseEvent {
  OAPaymentDetailEvent(String department, String doctorName,
      String appointmentType, String hospitalName, String appointmentFee)
      : super("OnlineRandevu_DetayOnay", {
          'birim_adi': department,
          'doktor_adi': doctorName,
          'randevu_tipi': appointmentType,
          'hastane_adi': hospitalName,
          'randevu_ucreti': appointmentFee
        });
}

class OAPaymentConfirmationEvent extends BaseEvent {
  OAPaymentConfirmationEvent(String department, String doctorName,
      String appointmentType, String hospitalName, String appointmentFee)
      : super("OnlineRandevu_OdemeOnay", {
          'birim_adi': department,
          'doktor_adi': doctorName,
          'randevu_tipi': appointmentType,
          'hastane_adi': hospitalName,
          'randevu_ucreti': appointmentFee
        });
}

class OAPaymentSuccessEvent extends BaseEvent {
  OAPaymentSuccessEvent(String department, String doctorName,
      String appointmentType, String hospitalName, String appointmentFee)
      : super("OnlineRandevu_RandevuTamamlandi", {
          'birim_adi': department,
          'doktor_adi': doctorName,
          'randevu_tipi': appointmentType,
          'hastane_adi': hospitalName,
          'randevu_ucreti': appointmentFee
        });
}

// PCR-19 Hospital Page
class HospitalSelectionEvent extends BaseEvent {
  HospitalSelectionEvent(String hospitalName)
      : super("pcrTesti_HastaneSecim", {'hastane_adi': hospitalName});
}

class PcrAppointmentDateTimeSelectionEvent extends BaseEvent {
  PcrAppointmentDateTimeSelectionEvent(String hospitalName)
      : super("pcrTesti_RandevuSecim", {'hastane_adi': hospitalName});
}

class PcrAppointmentPaymentDetailEvent extends BaseEvent {
  PcrAppointmentPaymentDetailEvent(String hospitalName, String appointmentFee)
      : super("pcrTesti_DetayOnay",
            {'hastane_adi': hospitalName, 'randevu_ucreti': appointmentFee});
}

class PcrAppointmentPaymentConfirmationEvent extends BaseEvent {
  PcrAppointmentPaymentConfirmationEvent(
      String hospitalName, String appointmentFee)
      : super("pcrTesti_OdemeOnay",
            {'hastane_adi': hospitalName, 'randevu_ucreti': appointmentFee});
}

class PcrPaymentSuccessEvent extends BaseEvent {
  PcrPaymentSuccessEvent(String hospitalName, String appointmentFee)
      : super("pcrTesti_RandevuTamamlandi",
            {'hastane_adi': hospitalName, 'randevu_ucreti': appointmentFee});
}

// Profile Page
class ChangeMyPasswordSuccessEvent extends BaseEvent {
  ChangeMyPasswordSuccessEvent() : super("sifreDegisikligi_Basarili", null);
}

class LogoutEvent extends BaseEvent {
  LogoutEvent() : super("uygulamaCikis", null);
}

class MyRelativesTabClickEvent extends BaseEvent {
  MyRelativesTabClickEvent() : super("yakinlarimTab_Tiklama", null);
}

class ChangeToRelativeSuccessEvent extends BaseEvent {
  ChangeToRelativeSuccessEvent(String relativeNameAndSurname)
      : super(
            "yakinDegistirme_Basarili", {'yakin_ismi': relativeNameAndSurname});
}

class AddPatientRelativeSuccessEvent extends BaseEvent {
  AddPatientRelativeSuccessEvent(int datumType)
      : super("yakinEkleme_Basarili", {"eklenme_tipi": datumType});
}

class ChangeToDefaultFromRelativeSuccessEvent extends BaseEvent {
  ChangeToDefaultFromRelativeSuccessEvent()
      : super("yakinlarimAnaHesapGecis_Basarili", null);
}

class PersonalInformationTabClickEvent extends BaseEvent {
  PersonalInformationTabClickEvent() : super("kisiselBilgiler_Tiklama", null);
}

class ProfilePictureUploadEvent extends BaseEvent {
  ProfilePictureUploadEvent() : super("profilResmi_Yukleme", null);
}

class ProfilePictureDeleteEvent extends BaseEvent {
  ProfilePictureDeleteEvent() : super("profilResmi_Silme", null);
}

class DeleteRelativeSuccessEvent extends BaseEvent {
  DeleteRelativeSuccessEvent(String relativeNameAndSurname)
      : super("yakinSilme_Basarili", {'yakin_ismi': relativeNameAndSurname});
}

class YoutubeSurveyCompleteEvent extends BaseEvent {
  YoutubeSurveyCompleteEvent(
      {String? name, String? surname, String? phone, String? courseId})
      : super("youtubeAnket_Tamamlandi", {
          'isim': name,
          'soyisim': surname,
          'telefon': phone,
          'egitim': courseId
        });
}

class YoutubeSurveySkipEvent extends BaseEvent {
  YoutubeSurveySkipEvent({String? courseId})
      : super("youtubeAnket_Atlandi", {'egitim': courseId});
}

class ForUClicked extends BaseEvent {
  ForUClicked() : super("for_u_clicked", null);
}

class CategoryClicked extends BaseEvent {
  CategoryClicked({String? categoryName})
      : super("category_clicked", {"categoryName": categoryName});
}

class SubCategoryClicked extends BaseEvent {
  SubCategoryClicked({String? subCategoryName})
      : super("sub_category_clicked", {"subCategoryName": subCategoryName});
}

class SubCategorySummaryClicked extends BaseEvent {
  SubCategorySummaryClicked({String? subCategoryName})
      : super("sub_category_summary_clicked",
            {"subCategoryName": subCategoryName});
}

class ItemPaymentClicked extends BaseEvent {
  ItemPaymentClicked({String? itemName})
      : super("item_payment_clicked", {"itemName": itemName});
}
