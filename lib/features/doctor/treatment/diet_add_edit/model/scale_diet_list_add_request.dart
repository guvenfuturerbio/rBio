import 'package:freezed_annotation/freezed_annotation.dart';

part 'scale_diet_list_add_request.freezed.dart';
part 'scale_diet_list_add_request.g.dart';

@freezed
class ScaleDietListAddRequest with _$ScaleDietListAddRequest {
  const factory ScaleDietListAddRequest({
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'breakfast') String? breakfast,
    @JsonKey(name: 'refreshmentBreakfast') String? refreshmentBreakfast,
    @JsonKey(name: 'lunch') String? lunch,
    @JsonKey(name: 'refreshmentLunch') String? refreshmentLunch,
    @JsonKey(name: 'dinner') String? dinner,
    @JsonKey(name: 'refreshmentDinner') String? refreshmentDinner,
  }) = _ScaleDietListAddRequest;

  const ScaleDietListAddRequest._();

  factory ScaleDietListAddRequest.fromJson(Map<String, dynamic> json) =>
      _$ScaleDietListAddRequestFromJson(json);
}
