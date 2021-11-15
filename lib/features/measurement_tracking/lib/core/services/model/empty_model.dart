import 'package:json_annotation/json_annotation.dart';
import '../service_shaft.dart';

part 'empty_model.g.dart';

@JsonSerializable()
class EmptyModel extends ServiceNetwork<EmptyModel> {
  String name;

  EmptyModel({this.name});

  factory EmptyModel.fromJson(Map<String, dynamic> json) =>
      _$EmptyModelFromJson(json);

  @override
  Map<String, dynamic> toJson() {
    return _$EmptyModelToJson(this);
  }

  @override
  EmptyModel fromJson(Map<String, dynamic> json) {
    return EmptyModel.fromJson(json);
  }
}
