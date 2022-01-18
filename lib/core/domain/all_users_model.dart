import '../core.dart';

// Cihaz üzerinde uygulamaya giriş yapan tüm kullanıcıları tuttuğumuz model.
// Her kullanıcının home widget listesini saklıyoruz.
class AllUsersModel extends IBaseModel<AllUsersModel> {
  List<String> useWidgets;
  List<String> deletedWidgets;

  AllUsersModel({
    this.useWidgets,
    this.deletedWidgets,
  });

  AllUsersModel.fromJson(Map<String, dynamic> json) {
    useWidgets = json['useWidgets'].cast<String>();
    deletedWidgets = json['deletedWidgets'].cast<String>();
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'useWidgets': useWidgets,
        'deletedWidgets': deletedWidgets,
      };

  @override
  AllUsersModel fromJson(Map<String, dynamic> json) {
    return AllUsersModel.fromJson(json);
  }
}
