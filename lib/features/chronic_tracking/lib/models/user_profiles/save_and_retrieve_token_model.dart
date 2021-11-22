import 'package:json_annotation/json_annotation.dart';
part 'save_and_retrieve_token_model.g.dart';

@JsonSerializable()
class SaveAndRetrieveTokenModel {
  static const TEXT = "text";
  static const MAIL = "mail";

  @JsonKey(name: TEXT)
  String text;
  @JsonKey(name: MAIL)
  String mail;

  factory SaveAndRetrieveTokenModel.fromJson(Map<String, dynamic> json) => _$SaveAndRetrieveTokenModelFromJson(json);

  Map<String, dynamic> toJson() => _$SaveAndRetrieveTokenModelToJson(this);

  SaveAndRetrieveTokenModel(
      {this.text, this.mail});

}
