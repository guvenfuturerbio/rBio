import '../../core/domain/base_model.dart';

import '../model.dart';

class FilterResourcesResponse extends IBaseModel<FilterResourcesResponse> {
  List<FilterTenantsResponse> departments;
  bool enabled;
  String gender;
  int id;
  bool isSSIContractor;
  bool isTSSContractor;
  List<FilterTenantsResponse> tenants;
  String title;
  bool isOnline; //hekim aktiflik durum
  bool isOnlineForWeb; //webden randevu kabul edip etmemesi

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
  });

  FilterResourcesResponse.fromJson(Map<String, dynamic> json) {
    if (json['departments'] != null) {
      departments = <FilterTenantsResponse>[];
      json['departments'].forEach((v) {
        departments.add(new FilterTenantsResponse.fromJson(v));
      });
    }
    enabled = json['enabled'];
    gender = json['gender'];
    id = json['id'];
    isSSIContractor = json['isSSIContractor'];
    isTSSContractor = json['isTSSContractor'];
    if (json['tenants'] != null) {
      tenants = <FilterTenantsResponse>[];
      json['tenants'].forEach((v) {
        tenants.add(new FilterTenantsResponse.fromJson(v));
      });
    }
    title = json['title'];
    isOnline = json['isOnline'];
    isOnlineForWeb = json['isOnlineForWeb'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.departments != null) {
      data['departments'] = this.departments.map((v) => v.toJson()).toList();
    }
    data['enabled'] = this.enabled;
    data['gender'] = this.gender;
    data['id'] = this.id;
    data['isSSIContractor'] = this.isSSIContractor;
    data['isTSSContractor'] = this.isTSSContractor;
    if (this.tenants != null) {
      data['tenants'] = this.tenants.map((v) => v.toJson()).toList();
    }
    data['title'] = this.title;
    data['isOnline'] = this.isOnline;
    data['isOnlineForWeb'] = this.isOnlineForWeb;
    return data;
  }

  @override
  FilterResourcesResponse fromJson(Map<String, dynamic> json) {
    return FilterResourcesResponse.fromJson(json);
  }
}
