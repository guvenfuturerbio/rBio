import 'package:json_annotation/json_annotation.dart';
import 'body_pages_columns.dart';
import 'body_pages_order.dart';
import 'body_pages_search.dart';
part 'body_pages_model.g.dart';

@JsonSerializable()
class BodyPages {
  @JsonKey(name: 'draw')
  int draw;
  @JsonKey(name: 'columns')
  List<Columns> columns;
  @JsonKey(name: 'order')
  List<Order> order;
  @JsonKey(name: 'start')
  int start;
  @JsonKey(name: 'length')
  String length;
  @JsonKey(name: 'search')
  Search search;

  BodyPages({
    this.draw,
    this.columns,
    this.order,
    this.start,
    this.length,
    this.search
  });

  factory BodyPages.fromJson(Map<String, dynamic> json) => _$BodyPagesFromJson(json);

  Map<String, dynamic> toJson() => _$BodyPagesToJson(this);
}