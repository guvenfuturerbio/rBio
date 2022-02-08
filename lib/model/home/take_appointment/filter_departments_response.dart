import 'package:json_annotation/json_annotation.dart';

import '../../../core/core.dart';
import '../filter_tenants_response.dart';

part 'filter_departments_response.g.dart';

@JsonSerializable()
class FilterDepartmentsResponse extends IBaseModel<FilterDepartmentsResponse> {
  @JsonKey(name: "enabled")
  bool? enabled;

  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "tenants")
  List<FilterTenantsResponse>? tenants;

  @JsonKey(name: "title")
  String? title;

  FilterDepartmentsResponse({
    this.enabled,
    this.id,
    this.tenants,
    this.title,
  });

  factory FilterDepartmentsResponse.fromJson(Map<String, dynamic> json) =>
      _$FilterDepartmentsResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FilterDepartmentsResponseToJson(this);

  @override
  FilterDepartmentsResponse fromJson(Map<String, dynamic> json) {
    return FilterDepartmentsResponse.fromJson(json);
  }
}
