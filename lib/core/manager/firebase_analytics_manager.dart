import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:onedosehealth/features/symptom_checker/symptoms_body_location/model/get_bodylocations_response.dart';

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

    Future<void> setUserProperty(String name,String? value) async {
    await FirebaseAnalytics.instance.setUserProperty(name: name,value : value);
  }
}

class _EventConstants {
  static const basariliGiris = "Basarili_Giris";
  static const saglikTakibiButonlar = "SaglikTakibi_Butonlar";
  static const menuElementTiklama = "Menu_Element_Tiklama";
  static const altBarTiklama = "Alt_Bar_Tiklama";
  static const detailedSymptomChecker = "detailed_symptom_checker";
  static const sikayetlerimSayfa1Devam = "SikayetlerimSayfa1_Devam";
  static const sikayetlerimSayfa2Devam = "SikayetlerimSayfa2_Devam";
  static const sikayetlerimSayfa3Devam = "SikayetlerimSayfa3_Devam";
  static const sikayetlerimSayfa4BolumAnaliziYapin =
      "SikayetlerimSayfa4_BolumAnaliziYapin";
  static const sonuclarimRandevuAra = "Sonuclarim_RandevuAra";
  static const randevuOlusturRandevuAra = "RandevuOlustur_RandevuAra";
  static const menuButonTiklama = "Menu_Buton_Tiklama";
}

// ----------- ----------- ----------- ----------- -----------

class BasariliGirisEvent extends BaseEvent {
  BasariliGirisEvent() : super(_EventConstants.basariliGiris, null);
}

class SaglikTakibiButonlarEvent extends BaseEvent {
  SaglikTakibiButonlarEvent(String element)
      : super(_EventConstants.saglikTakibiButonlar, {'element': element});
}

class MenuElementTiklamaEvent extends BaseEvent {
  MenuElementTiklamaEvent(String element)
      : super(_EventConstants.menuElementTiklama, {'element': element});
}

class AltBarTiklamaEvent extends BaseEvent {
  AltBarTiklamaEvent(String element)
      : super(_EventConstants.altBarTiklama, {'element': element});
}

class DetailedSymptomCheckerEvent extends BaseEvent {
  DetailedSymptomCheckerEvent()
      : super(_EventConstants.detailedSymptomChecker, {'element': 'profil'});
}

class SikayetlerimSayfa1DevamEvent extends BaseEvent {
  SikayetlerimSayfa1DevamEvent(
      String? randevuAlacakKisiId, String? cinsiyetId, String? dogumTarihiId)
      : super(_EventConstants.sikayetlerimSayfa1Devam, {
          'randevu_alacak_kisi_id': randevuAlacakKisiId,
          'cinsiyet_id': cinsiyetId,
          'dogum_tarihi_id': dogumTarihiId
        });
}

class SikayetlerimSayfa2DevamEvent extends BaseEvent {
  SikayetlerimSayfa2DevamEvent(String? randevuAlacakKisiId, String? cinsiyetId,
      String? dogumTarihiId, GetBodyLocationResponse? agriBolgesi)
      : super(_EventConstants.sikayetlerimSayfa2Devam, {
          'randevu_alacak_kisi_id': randevuAlacakKisiId,
          'cinsiyet_id': cinsiyetId,
          'dogum_tarihi_id': dogumTarihiId,
          'agri_bolgesi': agriBolgesi
        });
}

class SikayetlerimSayfa3DevamEvent extends BaseEvent {
  SikayetlerimSayfa3DevamEvent(String? randevuAlacakKisiId, String? cinsiyetId,
      String? dogumTarihiId, GetBodyLocationResponse? agriBolgesi)
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
      : super(_EventConstants.sonuclarimRandevuAra, {
          'randevu_alacak_kisi_id': randevuAlacakKisiId,
          'cinsiyet_id': cinsiyetId,
          'dogum_tarihi_id': dogumTarihiId,
          'agri_bolgesi': agriBolgesi,
          'sikayet_kapsam_secili_adet': sikayetKapsamSeciliAdet,
          'birim_adi': birimAdi,
          'tiklanan_birim_yuzdelik': tiklananBirimYuzdelik
        });
}

class RandevuOlusturRandevuAraEvent extends BaseEvent {
  RandevuOlusturRandevuAraEvent(String? randevuAlacakKisiId,
      String? hastaneSecimi, String? bolumSecimi, int? doktorSecimi)
      : super(_EventConstants.randevuOlusturRandevuAra, {
          'randevu_alacak_kisi_id': randevuAlacakKisiId,
          'hastane_secimi': hastaneSecimi,
          'bolum_secimi': bolumSecimi,
          'doktor_secimi': doktorSecimi,
        });
}

class MenuButonTiklamaEvent extends BaseEvent {
  MenuButonTiklamaEvent()
      : super(_EventConstants.menuButonTiklama, {'element': null});
}
