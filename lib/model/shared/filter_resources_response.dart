import '../../core/core.dart';
import '../../features/search/bloc/search_bloc.dart';
import '../model.dart';

class FilterResourcesResponse extends IBaseModel<FilterResourcesResponse>
    with SearchModel {
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
        departments
            ?.add(FilterTenantsResponse.fromJson(v as Map<String, dynamic>));
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
    return data;
  }

  @override
  FilterResourcesResponse fromJson(Map<String, dynamic> json) {
    return FilterResourcesResponse.fromJson(json);
  }
}
