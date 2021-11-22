import 'package:json_annotation/json_annotation.dart';
part 'token_user_text_body.g.dart';

@JsonSerializable()
class TokenUserTextBody {

  @JsonKey(name: "Id")
  String id;
  @JsonKey(name: "NameSurname")
  String name;
  @JsonKey(name: "ElectronicMail")
  String email;

  factory TokenUserTextBody.fromJson(Map<String, dynamic> json) => _$TokenUserTextBodyFromJson(json);

  Map<String, dynamic> toJson() => _$TokenUserTextBodyToJson(this);

  TokenUserTextBody(
      {this.id, this.name, this.email});

}
