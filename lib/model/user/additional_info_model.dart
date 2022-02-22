import 'package:json_annotation/json_annotation.dart';
part 'additional_info_model.g.dart';

@JsonSerializable()
class AdditionalInfoModel {
  @JsonKey(name: 'identification_number')
  String? identificationNumber;
  @JsonKey(name: 'country')
  String? country;
  @JsonKey(name: 'phone_number')
  String? phoneNumber;

  AdditionalInfoModel({
    this.identificationNumber,
    this.country,
    this.phoneNumber,
  });

  factory AdditionalInfoModel.fromJson(Map<String, dynamic> json) =>
      _$AdditionalInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdditionalInfoModelToJson(this);
}
