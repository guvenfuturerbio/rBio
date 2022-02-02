import '../../core/core.dart';

class GuvenResponseModel extends IBaseModel<GuvenResponseModel> {
  bool? isSuccessful;
  String? message;
  dynamic datum;

  GuvenResponseModel({
    this.isSuccessful,
    this.message,
    this.datum,
  });

  @override
  GuvenResponseModel fromJson(Map<String, dynamic> json) =>
      GuvenResponseModel.fromJson(json);

  GuvenResponseModel.fromJson(Map<String, dynamic> json) {
    isSuccessful = json['is_successful'] as bool?;
    message = json['message'] as String?;
    datum = json['datum'] as dynamic;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_successful'] = isSuccessful;
    data['message'] = message;
    data['datum'] = datum;
    return data;
  }
}
