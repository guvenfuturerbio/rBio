import 'package:json_annotation/json_annotation.dart';
part 'Filter.g.dart';

@JsonSerializable()
class Filter {
  @JsonKey(name: 'type')
  String type;
  @JsonKey(name: 'id')
  int id;

  Filter({
    this.type,
    this.id
  });

  factory Filter.fromJson(Map<String, dynamic> json) => _$FilterFromJson(json);

  Map<String, dynamic> toJson() => _$FilterToJson(this);
}