import '../../create_appointment_events/model/resources_request.dart';

class GetEventsRequest {
  int? patientId;
  int? appointmentType;
  List<ResourcesRequest>? resourcesRequestList;

  GetEventsRequest({
    this.patientId,
    this.resourcesRequestList,
    this.appointmentType,
  });

  factory GetEventsRequest.fromJson(Map<String, dynamic> json) =>
      GetEventsRequest(
        patientId: json['patientId'] as int,
        resourcesRequestList: (json['resources'] as List<dynamic>)
            .map((e) => ResourcesRequest.fromJson(e as Map<String, dynamic>))
            .toList(),
        appointmentType: json['appointmentType'] as int,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'patientId': patientId,
        'appointmentType': appointmentType,
        'resources': resourcesRequestList,
      };
}
