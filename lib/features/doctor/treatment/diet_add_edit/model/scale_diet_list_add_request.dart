import 'package:freezed_annotation/freezed_annotation.dart';

part 'scale_diet_list_add_request.freezed.dart';
part 'scale_diet_list_add_request.g.dart';

@freezed
class ScaleDietListAddRequest with _$ScaleDietListAddRequest {
  const factory ScaleDietListAddRequest({
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'breakfast') String? breakfast,
    @JsonKey(name: 'refreshment') String? refreshment,
    @JsonKey(name: 'lunch') String? lunch,
    @JsonKey(name: 'dinner') String? dinner,
  }) = _ScaleDietListAddRequest;

  const ScaleDietListAddRequest._();

  factory ScaleDietListAddRequest.fromJson(Map<String, dynamic> json) =>
      _$ScaleDietListAddRequestFromJson(json);
}
