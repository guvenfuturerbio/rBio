import '../../core/core.dart';

class FilterTenantsResponse extends IBaseModel<FilterTenantsResponse> {
  bool enabled;
  int id;
  String title;

  FilterTenantsResponse({
    this.enabled,
    this.id,
    this.title,
  });

  FilterTenantsResponse.fromJson(Map<String, dynamic> json) {
    enabled = json['enabled'];
    id = json['id'];
    title = json['title'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enabled'] = this.enabled;
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }

  @override
  FilterTenantsResponse fromJson(Map<String, dynamic> json) {
    return FilterTenantsResponse.fromJson(json);
  }
}
