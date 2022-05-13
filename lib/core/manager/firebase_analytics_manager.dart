import 'package:firebase_analytics/firebase_analytics.dart';

class BaseEvent {
  late final String name;
  late final Map<String, dynamic>? parameters;

  BaseEvent(
    this.name,
    this.parameters,
  );

  @override
  String toString() =>
      "Event_Name: ${name.toString()}\nEvent_Parameters: ${parameters.toString()}";
}

class FirebaseAnalyticsManager {
  Future<void> logEvent(BaseEvent event) async {
    await FirebaseAnalytics.instance.logEvent(
      name: event.name,
      parameters: event.parameters,
    );
  }

  Future<void> setUserId(String? id) async {
    await FirebaseAnalytics.instance.setUserId(id: id);
  }

  Future<void> setUserProperty(String name, String? value) async {
    await FirebaseAnalytics.instance.setUserProperty(name: name, value: value);
  }
}

class _EventConstants {
  static const altBarTiklama = "Alt_Bar_Tiklama";
  static const basariliGiris = "Basarili_Giris";
  static const detailedSymptomChecker = "detailed_symptom_checker";
  static const menuButonTiklama = "Menu_Buton_Tiklama";
  static const menuElementTiklama = "Menu_Element_Tiklama";
  static const randevuOlusturRandevuAra = "RandevuOlustur_RandevuAra";
  static const saglikTakibiButonlar = "SaglikTakibi_Butonlar";
  static const sikayetlerimSayfa1Devam = "SikayetlerimSayfa1_Devam";
  static const sikayetlerimSayfa2Devam = "SikayetlerimSayfa2_Devam";
  static const sikayetlerimSayfa3Devam = "SikayetlerimSayfa3_Devam";
  static const sikayetlerimSayfa4BolumAnaliziYapin =
      "SikayetlerimSayfa4_BolumAnaliziYapin";
  static const sonuclarimRandevuAra = "Sonuclarim_RandevuAra";
  static const uygulamaCikis = "uygulamaCikis";

  static const sizeOzelSayfasiTiklamaEvent = "Size_Özel_sayfası_Tiklama";
  static const appDownloadEvent = "app_download";
  static const videoCallSuccessEvent = "video_call_success";
  static const yakinSilmeBasarili = "yakinSilme_Basarili";
  static const basariliOdeme = "payment_success";
  static const sizeOzelKategoriTiklandiEvent = "category_clicked";
  static const sizeOzelAltKategoriTiklandiEvent = "sub_category_clicked";
  static const sizeOzelAltKategoriOzeteTiklandi =
      "sub_category_summary_clicked";
  static const urunOdemesiTiklandiEvent = "item_payment_clicked";

  static const anaSayfaOnlineRandevuTiklama = "AnaSayfa_OnlineRandevu_Tiklama";
  static const anaSayfaPcrTestiTiklama = "AnaSayfa_pcrTesti_Tiklama";
  static const anaSayfaDoktorBulTiklama = "AnaSayfa_DoktorBul_Tiklama";
  static const anaSayfaRandevularimTiklama = "AnaSayfa_Randevularim_Tiklama";
  static const anaSayfaSonuclarimTiklama = "AnaSayfa_Sonuclarim_Tiklama";
  static const anaSayfaDestekHattiTiklama = "AnaSayfa_DestekHatti_Tiklama";
  static const doktorBulTabTiklama = "DoktorBul_TabTiklama";
  static const randevularimTabTiklama = "Randevularim_TabTiklama";
  static const anaSayfaTabTiklama = "anaSayfaTabTiklama";
  static const profilimTabTiklama = "Profilim_TabTiklama";
  static const onlineRandevuBirimSecimi = "OnlineRandevu_BirimSecimi";
  static const onlineRandevuDoktorSecimi = "OnlineRandevu_DoktorSecimi";
  static const doktorDetayRandevuAl = "DoktorDetay_RandevuAl";
  static const pcrTestiHastaneSecim = "pcrTesti_HastaneSecim";
  static const sifreDegisikligiBasarili = "sifreDegisikligi_Basarili";
  static const yakinlarimTabTiklama = "yakinlarimTab_Tiklama";
  static const yakinDegistirmeBasarili = "yakinDegistirme_Basarili";
  static const yakinEklemeBasarili = "yakinEkleme_Basarili";
  static const yakinlarimAnaHesapGecisBasarili =
      "yakinlarimAnaHesapGecis_Basarili";
  static const kisiselBilgilerTiklama = "kisiselBilgiler_Tiklama";
  static const profilResmiYukleme = "profilResmi_Yukleme";
  static const profilResmiSilme = "profilResmi_Silme";

// #region FailEvents

  static const sifreDegistirmeHata = "sifreDegisikligi_Basarisiz";
  static const yakinDegistirmeHata = "yakinDegistirme_Basarisiz";
  static const yakinEklemeHata = "yakinEkleme_Basarisiz";
  static const yakinlarimAnaHesapGecisHata =
      "yakinlarimAnaHesapGecis_Basarisiz";
  static const yakinSilmeHata = "yakinSilme_Basarisiz";
  static const kayitOlAdim1Hata = "RegisterStep1FailEvent";

// #endregion

}

// ----------- ----------- ----------- ----------- -----------

class AltBarTiklamaEvent extends BaseEvent {
  AltBarTiklamaEvent(String element)
      : super(
          _EventConstants.altBarTiklama,
          {'element': element},
        );
}

class BasariliGirisEvent extends BaseEvent {
  BasariliGirisEvent() : super(_EventConstants.basariliGiris, null);
}

class DetailedSymptomCheckerEvent extends BaseEvent {
  DetailedSymptomCheckerEvent()
      : super(
          _EventConstants.detailedSymptomChecker,
          {'element': 'profil'},
        );
}

class MenuButonTiklamaEvent extends BaseEvent {
  MenuButonTiklamaEvent()
      : super(
          _EventConstants.menuButonTiklama,
          {'element': null},
        );
}

class MenuElementTiklamaEvent extends BaseEvent {
  MenuElementTiklamaEvent(String element)
      : super(_EventConstants.menuElementTiklama, {'element': element});
}

class RandevuOlusturRandevuAraEvent extends BaseEvent {
  RandevuOlusturRandevuAraEvent(
    String? randevuAlacakKisiId,
    String? hastaneSecimi,
    String? bolumSecimi,
    int? doktorSecimi,
  ) : super(
          _EventConstants.randevuOlusturRandevuAra,
          {
            'randevu_alacak_kisi_id': randevuAlacakKisiId,
            'hastane_secimi': hastaneSecimi,
            'bolum_secimi': bolumSecimi,
            'doktor_secimi': doktorSecimi,
          },
        );
}

class SaglikTakibiButonlarEvent extends BaseEvent {
  SaglikTakibiButonlarEvent(String element)
      : super(
          _EventConstants.saglikTakibiButonlar,
          {'element': element},
        );
}

class SikayetlerimSayfa1DevamEvent extends BaseEvent {
  SikayetlerimSayfa1DevamEvent(
    String? randevuAlacakKisiId,
    String? cinsiyetId,
    String? dogumTarihiId,
  ) : super(
          _EventConstants.sikayetlerimSayfa1Devam,
          {
            'randevu_alacak_kisi_id': randevuAlacakKisiId,
            'cinsiyet_id': cinsiyetId,
            'dogum_tarihi_id': dogumTarihiId
          },
        );
}

class SikayetlerimSayfa2DevamEvent extends BaseEvent {
  SikayetlerimSayfa2DevamEvent(
    String? randevuAlacakKisiId,
    String? cinsiyetId,
    String? dogumTarihiId,
    String? agriBolgesi,
  ) : super(
          _EventConstants.sikayetlerimSayfa2Devam,
          {
            'randevu_alacak_kisi_id': randevuAlacakKisiId,
            'cinsiyet_id': cinsiyetId,
            'dogum_tarihi_id': dogumTarihiId,
            'agri_bolgesi': agriBolgesi
          },
        );
}

class SikayetlerimSayfa3DevamEvent extends BaseEvent {
  SikayetlerimSayfa3DevamEvent(String? randevuAlacakKisiId, String? cinsiyetId,
      String? dogumTarihiId, String? agriBolgesi)
      : super(_EventConstants.sikayetlerimSayfa3Devam, {
          'randevu_alacak_kisi_id': randevuAlacakKisiId,
          'cinsiyet_id': cinsiyetId,
          'dogum_tarihi_id': dogumTarihiId,
          'agri_bolgesi': agriBolgesi
        });
}

class SikayetlerimSayfa4BolumAnaliziYapin extends BaseEvent {
  SikayetlerimSayfa4BolumAnaliziYapin(
      String? randevuAlacakKisiId,
      String? cinsiyetId,
      String? dogumTarihiId,
      String? agriBolgesi,
      int? sikayetKapsamSeciliAdet)
      : super(_EventConstants.sikayetlerimSayfa4BolumAnaliziYapin, {
          'randevu_alacak_kisi_id': randevuAlacakKisiId,
          'cinsiyet_id': cinsiyetId,
          'dogum_tarihi_id': dogumTarihiId,
          'agri_bolgesi': agriBolgesi,
          'sikayet_kapsam_secili_adet': sikayetKapsamSeciliAdet
        });
}

class SonuclarimRandevuAraEvent extends BaseEvent {
  SonuclarimRandevuAraEvent(
      String? randevuAlacakKisiId,
      String? cinsiyetId,
      String? dogumTarihiId,
      String? agriBolgesi,
      int? sikayetKapsamSeciliAdet,
      String? birimAdi,
      int? tiklananBirimYuzdelik)
      : super(
          _EventConstants.sonuclarimRandevuAra,
          {
            'randevu_alacak_kisi_id': randevuAlacakKisiId,
            'cinsiyet_id': cinsiyetId,
            'dogum_tarihi_id': dogumTarihiId,
            'agri_bolgesi': agriBolgesi,
            'sikayet_kapsam_secili_adet': sikayetKapsamSeciliAdet,
            'birim_adi': birimAdi,
            'tiklanan_birim_yuzdelik': tiklananBirimYuzdelik
          },
        );
}

class UygulamaCikisEvent extends BaseEvent {
  UygulamaCikisEvent() : super(_EventConstants.uygulamaCikis, {});
}

class SizeOzelKategoriTiklandiEvent extends BaseEvent {
  SizeOzelKategoriTiklandiEvent(String categoryName)
      : super(_EventConstants.sizeOzelKategoriTiklandiEvent,
            {"categoryId": categoryName});
}

class SizeOzelAltKategoriTiklandiEvent extends BaseEvent {
  SizeOzelAltKategoriTiklandiEvent(String subCategoryName)
      : super(_EventConstants.sizeOzelAltKategoriTiklandiEvent,
            {"subCategoryId": subCategoryName});
}

class SizeOzelAltKategoriOzeteTiklandiEvent extends BaseEvent {
  SizeOzelAltKategoriOzeteTiklandiEvent(String subCategoryName)
      : super(_EventConstants.sizeOzelAltKategoriOzeteTiklandi,
            {"subCategoryName": subCategoryName});
}

class UrunOdemesiTiklandiEvent extends BaseEvent {
  UrunOdemesiTiklandiEvent(String itemName)
      : super(_EventConstants.urunOdemesiTiklandiEvent, {"itemName": itemName});
}

class NewDownloadEvent extends BaseEvent {
  NewDownloadEvent() : super(_EventConstants.appDownloadEvent, null);
}

class VideoCallSuccessfulEvent extends BaseEvent {
  VideoCallSuccessfulEvent()
      : super(_EventConstants.videoCallSuccessEvent, null);
}

class Covid19PcrTestiTiklandiEvent extends BaseEvent {
  Covid19PcrTestiTiklandiEvent()
      : super(_EventConstants.anaSayfaPcrTestiTiklama, null);
}

class SifreDegistirBasariliEvent extends BaseEvent {
  SifreDegistirBasariliEvent()
      : super(_EventConstants.sifreDegisikligiBasarili, null);
}

class YakinEklemeBasariliEvent extends BaseEvent {
  YakinEklemeBasariliEvent(int datumType)
      : super(_EventConstants.yakinEklemeBasarili, {"eklenme_tipi": datumType});
}

class BasariliOdemeEvent extends BaseEvent {
  BasariliOdemeEvent({
    String? patientName,
    String? patientPhone,
    String? doctorName,
    String? departmentName,
  }) : super(
          _EventConstants.basariliOdeme,
          {
            'patientName': patientName,
            'patientPhone': patientPhone,
            'doctorName': doctorName,
            'departmentName': departmentName,
          },
        );
}

// #region FailEvents

class KayitOlAdim1Hata extends BaseEvent {
  KayitOlAdim1Hata(String param1, int param2)
      : super(_EventConstants.kayitOlAdim1Hata, {
          'test_param1': param1,
          'test_param2': param2,
          'test_param3': 12345670,
          'test_param4': 42.0,
          'test_param5': true,
        });
}

class SifreDegistirmeHataEvent extends BaseEvent {
  SifreDegistirmeHataEvent() : super(_EventConstants.sifreDegistirmeHata, null);
}

class YakinEklemeHataEvent extends BaseEvent {
  YakinEklemeHataEvent() : super(_EventConstants.yakinEklemeHata, null);
}

// #endregion

// #region NoReference
class YakinDegistirmeHataEvent extends BaseEvent {
  YakinDegistirmeHataEvent(String relativeNameAndSurname)
      : super(_EventConstants.yakinDegistirmeHata,
            {'yakin_ismi': relativeNameAndSurname});
}

class YakinlarimAnaHesapGecisHataEvent extends BaseEvent {
  YakinlarimAnaHesapGecisHataEvent()
      : super(_EventConstants.yakinlarimAnaHesapGecisHata, null);
}

class YakinSilmeHataEvent extends BaseEvent {
  YakinSilmeHataEvent(String relativeNameAndSurname)
      : super(_EventConstants.yakinSilmeHata,
            {'yakin_ismi': relativeNameAndSurname});
}

class AnaSayfaOnlineRandevuTiklamaEvent extends BaseEvent {
  AnaSayfaOnlineRandevuTiklamaEvent()
      : super(_EventConstants.anaSayfaOnlineRandevuTiklama, null);
}

class DoktorBulTiklandiEvent extends BaseEvent {
  DoktorBulTiklandiEvent()
      : super(_EventConstants.anaSayfaDoktorBulTiklama, null);
}

class RandevularimTiklandiEvent extends BaseEvent {
  RandevularimTiklandiEvent()
      : super(_EventConstants.anaSayfaRandevularimTiklama, null);
}

class SonuclarimTiklandiEvent extends BaseEvent {
  SonuclarimTiklandiEvent()
      : super(_EventConstants.anaSayfaSonuclarimTiklama, null);
}

class CanliDestekTiklandiEvent extends BaseEvent {
  CanliDestekTiklandiEvent()
      : super(_EventConstants.anaSayfaDestekHattiTiklama, null);
}

class DoktorBulTabTiklandiEvent extends BaseEvent {
  DoktorBulTabTiklandiEvent()
      : super(_EventConstants.doktorBulTabTiklama, null);
}

class RandevularimTabTiklamaEvent extends BaseEvent {
  RandevularimTabTiklamaEvent()
      : super(_EventConstants.randevularimTabTiklama, null);
}

class AnasayfaTabTiklandiEvent extends BaseEvent {
  AnasayfaTabTiklandiEvent() : super(_EventConstants.anaSayfaTabTiklama, null);
}

class ProfilTabTiklandiEvent extends BaseEvent {
  ProfilTabTiklandiEvent() : super(_EventConstants.profilimTabTiklama, null);
}

class OnlineRandevuDepartmanSecimiEvent extends BaseEvent {
  OnlineRandevuDepartmanSecimiEvent(String department)
      : super(_EventConstants.onlineRandevuBirimSecimi, {
          'birim_adi': department,
        });
}

class OnlineRandevuDoktorSecimiEvent extends BaseEvent {
  OnlineRandevuDoktorSecimiEvent(String department, String doctorName)
      : super(_EventConstants.onlineRandevuDoktorSecimi,
            {'birim_adi': department, 'doktor_adi': doctorName});
}

class OnlineRandevuAlTiklandiEvent extends BaseEvent {
  OnlineRandevuAlTiklandiEvent(String department, String doctorName)
      : super(_EventConstants.doktorDetayRandevuAl,
            {'birim_adi': department, 'doktor_adi': doctorName});
}

class PcrHastaneSecimiEvent extends BaseEvent {
  PcrHastaneSecimiEvent(String hospitalName)
      : super(_EventConstants.pcrTestiHastaneSecim,
            {'hastane_adi': hospitalName});
}

class YakinlarimTabTiklandiEvent extends BaseEvent {
  YakinlarimTabTiklandiEvent()
      : super(_EventConstants.yakinlarimTabTiklama, null);
}

class YakinDegistirmeBasariliEvent extends BaseEvent {
  YakinDegistirmeBasariliEvent(String relativeNameAndSurname)
      : super(_EventConstants.yakinDegistirmeBasarili,
            {'yakin_ismi': relativeNameAndSurname});
}

class YakinlarimAnaHesabaGecisBasariliEvent extends BaseEvent {
  YakinlarimAnaHesabaGecisBasariliEvent()
      : super(_EventConstants.yakinlarimAnaHesapGecisBasarili, null);
}

class KisiselBilgilerTiklandiEvent extends BaseEvent {
  KisiselBilgilerTiklandiEvent()
      : super(_EventConstants.kisiselBilgilerTiklama, null);
}

class ProfilResmiYuklemeEvent extends BaseEvent {
  ProfilResmiYuklemeEvent() : super(_EventConstants.profilResmiYukleme, null);
}

class ProfilResmiSilmeEvent extends BaseEvent {
  ProfilResmiSilmeEvent() : super(_EventConstants.profilResmiSilme, null);
}

class YakinSilmeBasariliEvent extends BaseEvent {
  YakinSilmeBasariliEvent(
    String relativeNameAndSurname,
  ) : super(_EventConstants.yakinSilmeBasarili, {
          'yakin_ismi': relativeNameAndSurname,
        });
}

class SizeOzelSayfasiTiklamaEvent extends BaseEvent {
  SizeOzelSayfasiTiklamaEvent()
      : super(_EventConstants.sizeOzelSayfasiTiklamaEvent, null);
}

// #endregion

