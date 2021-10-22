import '../filter_tenants_response.dart';

class FilterDepartmentsResponse {
  bool enabled;
  int id;
  List<FilterTenantsResponse> tenants;
  String title;

  FilterDepartmentsResponse({
    this.enabled,
    this.id,
    this.tenants,
    this.title,
  });

  FilterDepartmentsResponse.fromJson(Map<String, dynamic> json) {
    enabled = json['enabled'];
    id = json['id'];
    if (json['tenants'] != null) {
      tenants = <FilterTenantsResponse>[];
      json['tenants'].forEach((v) {
        tenants.add(new FilterTenantsResponse.fromJson(v));
      });
    }
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enabled'] = this.enabled;
    data['id'] = this.id;
    if (this.tenants != null) {
      data['tenants'] = this.tenants.map((v) => v.toJson()).toList();
    }
    data['title'] = this.title;
    return data;
  }
}
