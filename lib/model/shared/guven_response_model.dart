import '../../core/core.dart';

class GuvenResponseModel extends IBaseModel<GuvenResponseModel> {
  bool isSuccessful;
  String message;
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
    isSuccessful = json['is_successful'];
    message = json['message'];
    datum = json['datum'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_successful'] = this.isSuccessful;
    data['message'] = this.message;
    data['datum'] = this.datum;
    return data;
  }
}
