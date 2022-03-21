import 'package:json_annotation/json_annotation.dart';

part 'add_step1_model.g.dart';

@JsonSerializable()
class AddStep1Model {
  @JsonKey(name: 'birthDate')
  String? birthDate;

  @JsonKey(name: 'email')
  String? email;

  @JsonKey(name: 'firstName')
  String? firstName;

  @JsonKey(name: 'gender')
  String? gender;

  @JsonKey(name: 'gsm')
  String? gsm;

  @JsonKey(name: 'countryCode')
  String? countryCode;

  @JsonKey(name: 'hasETKApproval')
  bool? hasETKApproval;

  @JsonKey(name: 'hasKVKKApproval')
  bool? hasKVKKApproval;

  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'identityNumber')
  String? identityNumber;

  @JsonKey(name: 'lastName')
  String? lastName;

  @JsonKey(name: 'nationalityId')
  int? nationalityId;

  @JsonKey(name: 'passportNumber')
  String? passportNumber;

  @JsonKey(name: 'patientType')
  int? patientType;

  AddStep1Model({
    this.birthDate,
    this.email,
    this.firstName,
    this.gender,
    this.gsm,
    this.countryCode,
    this.hasETKApproval = false,
    this.hasKVKKApproval = false,
    this.id = 0,
    this.identityNumber = "",
    this.lastName,
    this.nationalityId,
    this.passportNumber = "",
    this.patientType = 1,
  });

  factory AddStep1Model.fromJson(Map<String, dynamic> json) =>
      _$AddStep1ModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddStep1ModelToJson(this);
}
