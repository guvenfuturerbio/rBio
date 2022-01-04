import 'package:flutter/foundation.dart';

class PatientAppointmentsResponse {
  String appointmentCancellationReason;
  String appointmentSelectionReason;
  int appointmentSource;
  String createdAt;
  String description;
  String from;
  int id;
  String patient;
  int patientId;
  int patientType;
  List<Resources> resources;
  String service;
  int serviceId;
  int status;
  String tenant;
  int tenantId;
  String to;
  int type;
  String videoCallLink;
  String videoGuid;

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
    appointmentCancellationReason = json['appointmentCancellationReason'];
    appointmentSelectionReason = json['appointmentSelectionReason'];
    appointmentSource = json['appointmentSource'];
    createdAt = json['createdAt'];
    description = json['description'];
    from = json['from'];
    id = json['id'];
    patient = json['patient'];
    patientId = json['patientId'];
    patientType = json['patientType'];
    if (json['resources'] != null) {
      resources = <Resources>[];
      json['resources'].forEach((v) {
        resources.add(new Resources.fromJson(v));
      });
    }
    service = json['service'];
    serviceId = json['serviceId'];
    status = json['status'];
    tenant = json['tenant'];
    tenantId = json['tenantId'];
    to = json['to'];
    type = json['type'];
    videoCallLink = json['videoCallLink'];
    videoGuid = json['video_guid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appointmentCancellationReason'] = this.appointmentCancellationReason;
    data['appointmentSelectionReason'] = this.appointmentSelectionReason;
    data['appointmentSource'] = this.appointmentSource;
    data['createdAt'] = this.createdAt;
    data['description'] = this.description;
    data['from'] = this.from;
    data['id'] = this.id;
    data['patient'] = this.patient;
    data['patientId'] = this.patientId;
    data['patientType'] = this.patientType;
    if (this.resources != null) {
      data['resources'] = this.resources.map((v) => v.toJson()).toList();
    }
    data['service'] = this.service;
    data['serviceId'] = this.serviceId;
    data['status'] = this.status;
    data['tenant'] = this.tenant;
    data['tenantId'] = this.tenantId;
    data['to'] = this.to;
    data['type'] = this.type;
    data['videoCallLink'] = this.videoCallLink;
    data['video_guid'] = this.videoGuid;
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
  String department;
  int departmentId;
  String from;
  String resource;
  int resourceId;
  int resourceType;
  String to;

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
    department = json['department'];
    departmentId = json['departmentId'];
    from = json['from'];
    resource = json['resource'];
    resourceId = json['resourceId'];
    resourceType = json['resourceType'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['department'] = this.department;
    data['departmentId'] = this.departmentId;
    data['from'] = this.from;
    data['resource'] = this.resource;
    data['resourceId'] = this.resourceId;
    data['resourceType'] = this.resourceType;
    data['to'] = this.to;
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
