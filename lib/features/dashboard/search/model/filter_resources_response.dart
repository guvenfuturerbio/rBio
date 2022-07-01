// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../../../core/core.dart';
import '../../../take_appointment/create_appointment/model/filter_tenants_response.dart';
import '../bloc/search_bloc.dart';

class FilterResourcesResponse extends IBaseModel<FilterResourcesResponse> with SearchModel {
  List<FilterTenantsResponse>? departments;
  bool? enabled;
  String? gender;
  int? id;
  bool? isSSIContractor;
  bool? isTSSContractor;
  List<FilterTenantsResponse>? tenants;
  String? title;
  bool? isOnline; //hekim aktiflik durum
  bool? isOnlineForWeb; //webden randevu kabul edip etmemesi
  String? cvLink;

  FilterResourcesResponse({
    this.departments,
    this.enabled,
    this.gender,
    this.id,
    this.isSSIContractor,
    this.isTSSContractor,
    this.tenants,
    this.title,
    this.isOnline,
    this.isOnlineForWeb,
    this.cvLink,
  });

  FilterResourcesResponse.fromJson(Map<String, dynamic> json) {
    if (json['departments'] != null) {
      departments = <FilterTenantsResponse>[];
      json['departments'].forEach((v) {
        departments?.add(FilterTenantsResponse.fromJson(v as Map<String, dynamic>));
      });
    }
    enabled = json['enabled'] as bool?;
    gender = json['gender'] as String?;
    id = json['id'] as int?;
    isSSIContractor = json['isSSIContractor'] as bool?;
    isTSSContractor = json['isTSSContractor'] as bool?;
    if (json['tenants'] != null) {
      tenants = <FilterTenantsResponse>[];
      json['tenants'].forEach((v) {
        tenants?.add(FilterTenantsResponse.fromJson(v as Map<String, dynamic>));
      });
    }
    title = json['title'] as String?;
    isOnline = json['isOnline'] as bool?;
    isOnlineForWeb = json['isOnlineForWeb'] as bool?;
    cvLink = json['cvLink'] as String?;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (departments != null) {
      data['departments'] = departments?.map((v) => v.toJson()).toList();
    }
    data['enabled'] = enabled;
    data['gender'] = gender;
    data['id'] = id;
    data['isSSIContractor'] = isSSIContractor;
    data['isTSSContractor'] = isTSSContractor;
    if (tenants != null) {
      data['tenants'] = tenants?.map((v) => v.toJson()).toList();
    }
    data['title'] = title;
    data['isOnline'] = isOnline;
    data['isOnlineForWeb'] = isOnlineForWeb;
    data['cvLink'] = cvLink;
    return data;
  }

  @override
  FilterResourcesResponse fromJson(Map<String, dynamic> json) {
    return FilterResourcesResponse.fromJson(json);
  }

  @override
  String toString() {
    return 'FilterResourcesResponse(departments: $departments, enabled: $enabled, gender: $gender, id: $id, isSSIContractor: $isSSIContractor, isTSSContractor: $isTSSContractor, tenants: $tenants, title: $title, isOnline: $isOnline, isOnlineForWeb: $isOnlineForWeb, cvLink: $cvLink)';
  }
}
