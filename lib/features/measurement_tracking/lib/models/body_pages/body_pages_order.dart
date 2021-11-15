import 'package:json_annotation/json_annotation.dart';
part 'body_pages_order.g.dart';

@JsonSerializable()
class Order {
  @JsonKey(name: 'column')
  int column;
  @JsonKey(name: 'dir')
  String dir;

  Order({
    this.column,
    this.dir
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}