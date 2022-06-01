import 'package:freezed_annotation/freezed_annotation.dart';

part 'doctor_diet_list_add_request.freezed.dart';
part 'doctor_diet_list_add_request.g.dart';

@freezed
class DoctorDietListAddRequest with _$DoctorDietListAddRequest {
  const factory DoctorDietListAddRequest({
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'breakfast') String? breakfast,
    @JsonKey(name: 'refreshment') String? refreshment,
    @JsonKey(name: 'lunch') String? lunch,
    @JsonKey(name: 'dinner') String? dinner,
  }) = _DoctorDietListAddRequest;

  const DoctorDietListAddRequest._();

  factory DoctorDietListAddRequest.fromJson(Map<String, dynamic> json) =>
      _$DoctorDietListAddRequestFromJson(json);
}
