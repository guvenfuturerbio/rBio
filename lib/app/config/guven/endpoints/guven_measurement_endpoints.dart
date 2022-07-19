part of '../../abstract/app_config.dart';

class GuvenMeasurementEndpoints extends MeasurementEndpoints {
  @override
  String get ctInsertNewBloodGlucoseValue =>
      throw RbioUndefinedEndpointException("ctInsertNewBloodGlucoseValue");

  @override
  String get ctDeleteBloodGlucoseValue =>
      throw RbioUndefinedEndpointException("ctDeleteBloodGlucoseValue");

  @override
  String get ctUpdateBloodGlucoseValue =>
      throw RbioUndefinedEndpointException("ctUpdateBloodGlucoseValue");

  @override
  String ctUploadMeasurementImage(entegrationId, measurementId) =>
      throw RbioUndefinedEndpointException("ctUploadMeasurementImage");

  @override
  String get ctGetBloodGlucoseReport =>
      throw RbioUndefinedEndpointException("ctGetBloodGlucoseReport");

  @override
  String get ctGetBloodGlucoseDataOfPerson =>
      throw RbioUndefinedEndpointException("ctGetBloodGlucoseDataOfPerson");

  @override
  String ctAddHospitalHba1cMeasurement(entegrationId) =>
      throw RbioUndefinedEndpointException("ctAddHospitalHba1cMeasurement");

  @override
  String ctGetHba1cMeasurementList(entegrationId) =>
      throw RbioUndefinedEndpointException("ctGetHba1cMeasurementList");

  @override
  String get ctInsertNewBpValue =>
      throw RbioUndefinedEndpointException("ctInsertNewBpValue");

  @override
  String get ctDeleteBpMeasurement =>
      throw RbioUndefinedEndpointException("ctDeleteBpMeasurement");

  @override
  String get ctGetBpMeasurement =>
      throw RbioUndefinedEndpointException("ctGetBpMeasurement");

  @override
  String get ctUpdateBpMeasurement =>
      throw RbioUndefinedEndpointException("ctUpdateBpMeasurement");
}
