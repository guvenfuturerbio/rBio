import 'package:json_annotation/json_annotation.dart';
part 'body_pages_search.g.dart';

@JsonSerializable()
class Search {
  @JsonKey(name: 'value')
  String value;
  @JsonKey(name: 'regex')
  bool regex;

  Search({
    this.value,
    this.regex
  });

  factory Search.fromJson(Map<String, dynamic> json) => _$SearchFromJson(json);

  Map<String, dynamic> toJson() => _$SearchToJson(this);
}