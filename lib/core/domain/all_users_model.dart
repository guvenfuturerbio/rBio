import '../core.dart';

// Cihaz üzerinde uygulamaya giriş yapan tüm kullanıcıları tuttuğumuz model.
// Her kullanıcının home widget listesini saklıyoruz.
class AllUsersModel extends IBaseModel<AllUsersModel> {
  late List<String> useWidgets;

  AllUsersModel({
    required this.useWidgets,
  });

  AllUsersModel.fromJson(Map<String, dynamic> json) {
    useWidgets = json['useWidgets'] as List<String>;
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'useWidgets': useWidgets,
      };

  @override
  AllUsersModel fromJson(Map<String, dynamic> json) {
    return AllUsersModel.fromJson(json);
  }
}
