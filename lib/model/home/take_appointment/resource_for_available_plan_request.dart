import '../../model.dart';

class ResourceForAvailablePlanRequest {
  String from;
  String to;
  int appointmentType;
  List<ResourcesRequest> resourcesRequestList;

  ResourceForAvailablePlanRequest({
    this.from,
    this.to,
    this.appointmentType,
    this.resourcesRequestList,
  });

  factory ResourceForAvailablePlanRequest.fromJson(Map<String, dynamic> json) =>
      ResourceForAvailablePlanRequest(
        from: json['from'] as String,
        to: json['to'] as String,
        appointmentType: json['appointmentType'] as int,
        resourcesRequestList: (json['resources'] as List<dynamic>)
            .map((e) => ResourcesRequest.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'from': from,
        'to': to,
        'appointmentType': appointmentType,
        'resources': resourcesRequestList,
      };
}
