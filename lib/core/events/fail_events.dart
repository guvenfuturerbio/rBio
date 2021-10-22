
import 'base_event.dart';

class RegisterStep1FailEvent extends BaseEvent {
  @override
  String name;

  RegisterStep1FailEvent(String param1, int param2)
      : super("RegisterStep1FailEvent", {
          'test_param1': param1,
          'test_param2': param2,
          'test_param3': 12345670,
          'test_param4': 42.0,
          'test_param5': true,
        });
}

class RegisterStep2FailEvent extends BaseEvent {
  RegisterStep2FailEvent(String param1, int param2)
      : super("RegisterStep2FailEvent", {
          'string': param1,
          'int': param2,
          'long': 12345910,
          'double': 42.0,
          'bool': true,
        });
}

class OAPaymentFailureEvent extends BaseEvent {
  OAPaymentFailureEvent(String errorMessage) : super("OnlineRandevu_OdemeHata", {
    'hata_mesaji': errorMessage
  });
}

class PcrPaymentFailureEvent extends BaseEvent {
  PcrPaymentFailureEvent(String errorMessage) : super("pcrTesti_OdemeHata", {
    'hata_mesaji': errorMessage
  });
}

// Profile Page
class ChangeMyPasswordFailEvent extends BaseEvent {
  ChangeMyPasswordFailEvent() : super("sifreDegisikligi_Basarisiz", null);
}

class ChangeToRelativeFailEvent extends BaseEvent {
  ChangeToRelativeFailEvent(String relativeNameAndSurname) : super("yakinDegistirme_Basarisiz", {
    'yakin_ismi': relativeNameAndSurname
  });
}

class AddPatientRelativeFailEvent extends BaseEvent {
  AddPatientRelativeFailEvent() : super("yakinEkleme_Basarisiz", null);
}

class ChangeToDefaultFromRelativeFailEvent extends BaseEvent {
  ChangeToDefaultFromRelativeFailEvent() : super("yakinlarimAnaHesapGecis_Basarisiz", null);
}

class DeleteRelativeFailEvent extends BaseEvent {
  DeleteRelativeFailEvent(String relativeNameAndSurname) : super("yakinSilme_Basarisiz", {
    'yakin_ismi': relativeNameAndSurname
  });
}