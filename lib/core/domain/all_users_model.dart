import 'package:json_annotation/json_annotation.dart';

import '../core.dart';

part 'all_users_model.g.dart';

// Cihaz üzerinde uygulamaya giriş yapan tüm kullanıcıları tuttuğumuz model.
// Her kullanıcının home widget listesini saklıyoruz.
@JsonSerializable()
class AllUsersModel extends IBaseModel<AllUsersModel> {
  @JsonKey(name: "useWidgets")
  List<String>? useWidgets;

  AllUsersModel({
    this.useWidgets,
  });

  factory AllUsersModel.fromJson(Map<String, dynamic> json) =>
      _$AllUsersModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AllUsersModelToJson(this);

  @override
  AllUsersModel fromJson(Map<String, dynamic> json) {
    return AllUsersModel.fromJson(json);
  }
}
