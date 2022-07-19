part of '../../abstract/app_config.dart';

class GuvenTreatmentEndpoints extends TreatmentEndpoints {
  @override
  String getTreatmentNoteWithDiet(int? entegrationId) =>
      throw RbioUndefinedEndpointException("getTreatmentNoteWithDiet");

  @override
  String getTreatmentNoteWithDietDoctor(int patientId) =>
      throw RbioUndefinedEndpointException("getTreatmentNoteWithDietDoctor");

  @override
  String treatmentGetDetail(int itemType, int id) =>
      throw RbioUndefinedEndpointException("treatmentGetDetail");

  @override
  String addTreatmentNote(int? entegrationId) =>
      throw RbioUndefinedEndpointException("addTreatmentNote");

  @override
  String addDiet(int patientId) =>
      throw RbioUndefinedEndpointException("addDiet");

  @override
  String deleteNoteDiet(int itemType, int id) =>
      throw RbioUndefinedEndpointException("deleteNoteDiet");

  @override
  String addTreatmentNoteDoctor(int patientId) =>
      throw RbioUndefinedEndpointException("addTreatmentNoteDoctor");
}
