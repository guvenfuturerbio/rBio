import '../../core/core.dart';

class FilterTenantsResponse extends IBaseModel<FilterTenantsResponse> {
  bool? enabled;
  int? id;
  String? title;

  FilterTenantsResponse({
    this.enabled,
    this.id,
    this.title,
  });

  FilterTenantsResponse.fromJson(Map<String, dynamic> json) {
    enabled = json['enabled'] as bool?;
    id = json['id'] as int?;
    title = json['title'] as String?;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['enabled'] = enabled;
    data['id'] = id;
    data['title'] = title;
    return data;
  }

  @override
  FilterTenantsResponse fromJson(Map<String, dynamic> json) {
    return FilterTenantsResponse.fromJson(json);
  }
}
