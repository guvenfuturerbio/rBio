part of '../../abstract/app_config.dart';

class OneDoseTreatmentEndpoints extends TreatmentEndpoints {
  @override
  String getTreatmentNoteWithDiet(int? entegrationId) =>
      '/Treatment/get-treatment-note-with-diet/$entegrationId'.xDevApiTest;

  @override
  String getTreatmentNoteWithDietDoctor(int patientId) =>
      '/Treatment/get-treatment-note-with-diet-doctor/$patientId'.xDevApiTest;

  @override
  String treatmentGetDetail(int itemType, int id) =>
      '/Treatment/get-detail/$itemType/$id'.xDevApiTest;

  @override
  String addTreatmentNote(int? entegrationId) =>
      '/Treatment/add-treatment-note/$entegrationId'.xDevApiTest;

  @override
  String addDiet(int patientId) => '/Treatment/add-diet/$patientId'.xDevApiTest;

  @override
  String deleteNoteDiet(int itemType, int id) =>
      '/Treatment/delete-note-diet/$itemType/$id'.xDevApiTest;

  @override
  String addTreatmentNoteDoctor(int patientId) =>
      '/Treatment/add-treatment-note-by-doctor/$patientId'.xDevApiTest;
}
