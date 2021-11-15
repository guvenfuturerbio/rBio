import 'package:json_annotation/json_annotation.dart';
import 'body_pages_search.dart';
part 'body_pages_columns.g.dart';

@JsonSerializable()
class Columns {
  @JsonKey(name: 'data')
  String data;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'searchable')
  bool searchable;
  @JsonKey(name: 'orderable')
  bool orderable;
  @JsonKey(name: 'search')
  Search search;

  Columns({
    this.data,
    this.name,
    this.searchable,
    this.orderable,
    this.search});

  factory Columns.fromJson(Map<String, dynamic> json) => _$ColumnsFromJson(json);

  Map<String, dynamic> toJson() => _$ColumnsToJson(this);
}