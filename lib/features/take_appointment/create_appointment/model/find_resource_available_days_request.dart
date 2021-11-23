import 'dart:convert';

import 'package:onedosehealth/features/take_appointment/create_appointment/model/resource_request.dart';

class FindResourceAvailableDaysRequest {
  ResourceRequest resourceRequest;
  int appointmentType;
  FindResourceAvailableDaysRequest({
    this.resourceRequest,
    this.appointmentType,
  });

  Map<String, dynamic> toMap() {
    return {
      'resourceRequest': resourceRequest.toMap(),
      'appointmentType': appointmentType,
    };
  }

  factory FindResourceAvailableDaysRequest.fromMap(Map<String, dynamic> map) {
    return FindResourceAvailableDaysRequest(
      resourceRequest: ResourceRequest.fromMap(map['resourceRequest']),
      appointmentType: map['appointmentType'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FindResourceAvailableDaysRequest.fromJson(String source) =>
      FindResourceAvailableDaysRequest.fromMap(json.decode(source));
}
