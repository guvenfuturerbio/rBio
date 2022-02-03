import 'resource_request.dart';

class FindResourceAvailableDaysRequest {
  ResourceRequest? resourceRequest;
  int? appointmentType;

  FindResourceAvailableDaysRequest({
    this.resourceRequest,
    this.appointmentType,
  });

  Map<String, dynamic> toJson() => {
        'resource': resourceRequest?.toJson(),
        'appointmentType': appointmentType,
      };

  factory FindResourceAvailableDaysRequest.fromJson(
          Map<String, dynamic> json) =>
      FindResourceAvailableDaysRequest(
        resourceRequest: ResourceRequest.fromJson(json['resource']),
        appointmentType: json['appointmentType'],
      );
}
