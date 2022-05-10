import '../../../../model/model.dart';

class SaveAppointmentsRequest {
  int? tenantId;
  int? patientId;
  List<ResourcesRequest>? resourcesRequestList;
  int? type;
  int? status;
  int? patientType;
  int? appointmentSource;
  String? videoCallLink;

  SaveAppointmentsRequest({
    this.tenantId,
    this.patientId,
    this.resourcesRequestList,
    this.type,
    this.status,
    this.patientType,
    this.appointmentSource,
    this.videoCallLink,
  });

  factory SaveAppointmentsRequest.fromJson(Map<String, dynamic> json) =>
      SaveAppointmentsRequest(
        tenantId: json['tenantId'] as int?,
        patientId: json['patientId'] as int?,
        resourcesRequestList: (json['resources'] as List<dynamic>)
            .map((e) => ResourcesRequest.fromJson(e as Map<String, dynamic>))
            .toList(),
        type: json['type'] as int?,
        status: json['status'] as int?,
        patientType: json['patientType'] as int?,
        appointmentSource: json['appointmentSource'] as int?,
        videoCallLink: json['videoCallLink'] as String?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'tenantId': tenantId,
        'patientId': patientId,
        'resources': resourcesRequestList,
        'type': type,
        'status': status,
        'patientType': patientType,
        'appointmentSource': appointmentSource,
        'videoCallLink': videoCallLink,
      };

  @override
  String toString() {
    return 'SaveAppointmentsRequest(tenantId: $tenantId, patientId: $patientId, resourcesRequestList: $resourcesRequestList, type: $type, status: $status, patientType: $patientType, appointmentSource: $appointmentSource, videoCallLink: $videoCallLink)';
  }
}
