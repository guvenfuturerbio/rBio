part of '../../abstract/app_config.dart';

class OneDoseMeasurementEndpoints extends MeasurementEndpoints {
  @override
  String get ctInsertNewBloodGlucoseValue =>
      '/Measurement/add-blood-glucose-with-detail'.xDevApiTest;

  @override
  String get ctDeleteBloodGlucoseValue =>
      '/Measurement/delete-blood-glucose-with-detail'.xDevApiTest;

  @override
  String get ctUpdateBloodGlucoseValue =>
      '/Measurement/update-blood-glucose-with-detail'.xDevApiTest;

  @override
  String ctUploadMeasurementImage(entegrationId, measurementId) =>
      '/Measurement/upload-measurement-image/$entegrationId/$measurementId'
          .xDevApiTest;

  @override
  String get ctGetBloodGlucoseReport =>
      '/Measurement/get-my-blood-glucose-report'.xDevApiTest;

  @override
  String get ctGetBloodGlucoseDataOfPerson =>
      '/Measurement/get-my-blood-glucose-with-detail-and-limit-value'
          .xDevApiTest;

  @override
  String ctAddHospitalHba1cMeasurement(entegrationId) =>
      '/Measurement/add-hospital-hba1c-measurement/$entegrationId'.xDevApiTest;

  @override
  String ctGetHba1cMeasurementList(entegrationId) =>
      '/Measurement/get-list-hospital-hba1c-measurement/$entegrationId'
          .xDevApiTest;

  @override
  String get ctInsertNewBpValue =>
      '/Measurement/add-bp-with-detail'.xDevApiTest;

  @override
  String get ctDeleteBpMeasurement =>
      '/Measurement/delete-bp-with-detail'.xDevApiTest;

  @override
  String get ctGetBpMeasurement =>
      '/Measurement/get-bp-measurements'.xDevApiTest;

  @override
  String get ctUpdateBpMeasurement =>
      '/Measurement/update-bp-measurement'.xDevApiTest;
}
