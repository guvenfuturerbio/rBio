import 'package:flutter/foundation.dart';

class PatientAppointmentsResponse {
  String? appointmentCancellationReason;
  String? appointmentSelectionReason;
  int? appointmentSource;
  String? createdAt;
  String? description;
  String? from;
  int? id;
  String? patient;
  int? patientId;
  int? patientType;
  List<Resources>? resources;
  String? service;
  int? serviceId;
  int? status;
  String? tenant;
  int? tenantId;
  String? to;
  int? type;
  String? videoCallLink;
  String? videoGuid;

  PatientAppointmentsResponse({
    this.appointmentCancellationReason,
    this.appointmentSelectionReason,
    this.appointmentSource,
    this.createdAt,
    this.description,
    this.from,
    this.id,
    this.patient,
    this.patientId,
    this.patientType,
    this.resources,
    this.service,
    this.serviceId,
    this.status,
    this.tenant,
    this.tenantId,
    this.to,
    this.type,
    this.videoCallLink,
    this.videoGuid,
  });

  PatientAppointmentsResponse.fromJson(Map<String, dynamic> json) {
    appointmentCancellationReason =
        json['appointmentCancellationReason'] as String?;
    appointmentSelectionReason = json['appointmentSelectionReason'] as String?;
    appointmentSource = json['appointmentSource'] as int?;
    createdAt = json['createdAt'] as String?;
    description = json['description'] as String?;
    from = json['from'] as String?;
    id = json['id'] as int?;
    patient = json['patient'] as String?;
    patientId = json['patientId'] as int?;
    patientType = json['patientType'] as int?;
    if (json['resources'] != null) {
      resources = <Resources>[];
      json['resources'].forEach((v) {
        resources?.add(Resources.fromJson(
          v as Map<String, dynamic>,
        ));
      });
    }
    service = json['service'] as String?;
    serviceId = json['serviceId'] as int?;
    status = json['status'] as int?;
    tenant = json['tenant'] as String?;
    tenantId = json['tenantId'] as int?;
    to = json['to'] as String?;
    type = json['type'] as int?;
    videoCallLink = json['videoCallLink'] as String?;
    videoGuid = json['video_guid'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appointmentCancellationReason'] = appointmentCancellationReason;
    data['appointmentSelectionReason'] = appointmentSelectionReason;
    data['appointmentSource'] = appointmentSource;
    data['createdAt'] = createdAt;
    data['description'] = description;
    data['from'] = from;
    data['id'] = id;
    data['patient'] = patient;
    data['patientId'] = patientId;
    data['patientType'] = patientType;
    if (resources != null) {
      data['resources'] = resources?.map((v) => v.toJson()).toList();
    }
    data['service'] = service;
    data['serviceId'] = serviceId;
    data['status'] = status;
    data['tenant'] = tenant;
    data['tenantId'] = tenantId;
    data['to'] = to;
    data['type'] = type;
    data['videoCallLink'] = videoCallLink;
    data['video_guid'] = videoGuid;
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PatientAppointmentsResponse &&
        other.appointmentCancellationReason == appointmentCancellationReason &&
        other.appointmentSelectionReason == appointmentSelectionReason &&
        other.appointmentSource == appointmentSource &&
        other.createdAt == createdAt &&
        other.description == description &&
        other.from == from &&
        other.id == id &&
        other.patient == patient &&
        other.patientId == patientId &&
        other.patientType == patientType &&
        listEquals(other.resources, resources) &&
        other.service == service &&
        other.serviceId == serviceId &&
        other.status == status &&
        other.tenant == tenant &&
        other.tenantId == tenantId &&
        other.to == to &&
        other.type == type &&
        other.videoCallLink == videoCallLink &&
        other.videoGuid == videoGuid;
  }

  @override
  int get hashCode {
    return appointmentCancellationReason.hashCode ^
        appointmentSelectionReason.hashCode ^
        appointmentSource.hashCode ^
        createdAt.hashCode ^
        description.hashCode ^
        from.hashCode ^
        id.hashCode ^
        patient.hashCode ^
        patientId.hashCode ^
        patientType.hashCode ^
        resources.hashCode ^
        service.hashCode ^
        serviceId.hashCode ^
        status.hashCode ^
        tenant.hashCode ^
        tenantId.hashCode ^
        to.hashCode ^
        type.hashCode ^
        videoCallLink.hashCode ^
        videoGuid.hashCode;
  }
}

class Resources {
  String? department;
  int? departmentId;
  String? from;
  String? resource;
  int? resourceId;
  int? resourceType;
  String? to;

  Resources({
    this.department,
    this.departmentId,
    this.from,
    this.resource,
    this.resourceId,
    this.resourceType,
    this.to,
  });

  Resources.fromJson(Map<String, dynamic> json) {
    department = json['department'] as String?;
    departmentId = json['departmentId'] as int?;
    from = json['from'] as String?;
    resource = json['resource'] as String?;
    resourceId = json['resourceId'] as int?;
    resourceType = json['resourceType'] as int?;
    to = json['to'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['department'] = department;
    data['departmentId'] = departmentId;
    data['from'] = from;
    data['resource'] = resource;
    data['resourceId'] = resourceId;
    data['resourceType'] = resourceType;
    data['to'] = to;
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Resources &&
        other.department == department &&
        other.departmentId == departmentId &&
        other.from == from &&
        other.resource == resource &&
        other.resourceId == resourceId &&
        other.resourceType == resourceType &&
        other.to == to;
  }

  @override
  int get hashCode {
    return department.hashCode ^
        departmentId.hashCode ^
        from.hashCode ^
        resource.hashCode ^
        resourceId.hashCode ^
        resourceType.hashCode ^
        to.hashCode;
  }
}
