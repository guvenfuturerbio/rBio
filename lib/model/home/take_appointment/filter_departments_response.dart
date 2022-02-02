import '../../../core/core.dart';
import '../filter_tenants_response.dart';

class FilterDepartmentsResponse extends IBaseModel<FilterDepartmentsResponse> {
  bool? enabled;
  int? id;
  List<FilterTenantsResponse>? tenants;
  String? title;

  FilterDepartmentsResponse({
    this.enabled,
    this.id,
    this.tenants,
    this.title,
  });

  FilterDepartmentsResponse.fromJson(Map<String, dynamic> json) {
    enabled = json['enabled'] as bool?;
    id = json['id'] as int?;
    if (json['tenants'] != null) {
      tenants = <FilterTenantsResponse>[];
      json['tenants'].forEach((v) {
        tenants?.add(FilterTenantsResponse.fromJson(v as Map<String, dynamic>));
      });
    }
    title = json['title'] as String?;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['enabled'] = enabled;
    data['id'] = id;
    if (tenants != null) {
      data['tenants'] = tenants?.map((v) => v.toJson()).toList();
    }
    data['title'] = title;
    return data;
  }

  @override
  FilterDepartmentsResponse fromJson(Map<String, dynamic> json) {
    return FilterDepartmentsResponse.fromJson(json);
  }
}
