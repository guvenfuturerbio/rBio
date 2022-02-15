import 'package:freezed_annotation/freezed_annotation.dart';

part 'all_users_model.freezed.dart';
part 'all_users_model.g.dart';

@freezed
class AllUsersModel with _$AllUsersModel {
  /// Cihaz üzerinde uygulamaya giriş yapan tüm kullanıcıları tuttuğumuz model.
  /// Her kullanıcının home widget listesini saklıyoruz.
  const factory AllUsersModel({
    @JsonKey(name: 'useWidgets') List<String>? useWidgets,
  }) = _AllUsersModel;

  factory AllUsersModel.fromJson(Map<String, dynamic> json) =>
      _$AllUsersModelFromJson(json);
}

/*
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
*/