import 'package:onedosehealth/core/exception/model_cast_exception.dart';

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

extension MapCastExtension on GuvenResponseModel {
  bool get xIsSuccessful => isSuccessful ?? false;

  Map<String, dynamic> get xGetMap {
    if (datum is Map<String, dynamic>) {
      return datum as Map<String, dynamic>;
    }

    throw RbioModelCastException("Model cast exception");
  }

  bool get xGetBool {
    if (datum is bool) {
      return datum as bool;
    }

    throw RbioModelCastException("Model cast exception");
  }

  List<Map<String, dynamic>> get xGetMapList {
    if (this is List<Map<String, dynamic>>) {
      return this as List<Map<String, dynamic>>;
    }

    throw RbioModelCastException("Dynamic cast exception");
  }
}
