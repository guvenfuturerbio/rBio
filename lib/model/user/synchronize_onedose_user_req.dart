// To parse this JSON data, do
//
//     final synchronizeOneDoseUserRequest = synchronizeOneDoseUserRequestFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';

part 'synchronize_onedose_user_req.freezed.dart';
part 'synchronize_onedose_user_req.g.dart';

@freezed
class SynchronizeOneDoseUserRequest with _$SynchronizeOneDoseUserRequest {
  const factory SynchronizeOneDoseUserRequest({
    String? birthDate,
    String? email,
    String? firstName,
    String? gender,
    String? gsm,
    String? countryCode,
    bool? hasEtkApproval,
    bool? hasKvkkApproval,
    int? id,
    String? identityNumber,
    String? lastName,
    int? nationalityId,
    String? passportNumber,
    int? patientType,
  }) = _SynchronizeOneDoseUserRequest;

  factory SynchronizeOneDoseUserRequest.fromJson(Map<String, dynamic> json) =>
      _$SynchronizeOneDoseUserRequestFromJson(json);
}
