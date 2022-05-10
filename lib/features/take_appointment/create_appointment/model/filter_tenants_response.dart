import 'package:json_annotation/json_annotation.dart';

import '../../../../core/core.dart';

part 'filter_tenants_response.g.dart';

@JsonSerializable()
class FilterTenantsResponse extends IBaseModel<FilterTenantsResponse> {
  @JsonKey(name: "enabled")
  bool? enabled;

  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "title")
  String? title;

  FilterTenantsResponse({
    this.enabled,
    this.id,
    this.title,
  });

  factory FilterTenantsResponse.fromJson(Map<String, dynamic> json) =>
      _$FilterTenantsResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FilterTenantsResponseToJson(this);

  @override
  FilterTenantsResponse fromJson(Map<String, dynamic> json) {
    return FilterTenantsResponse.fromJson(json);
  }
}
