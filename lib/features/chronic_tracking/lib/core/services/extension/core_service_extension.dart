part of '../service_shaft.dart';

extension _CoreServiceExtension on ServiceManager {
  dynamic _getBodyModel(dynamic data) {
    if (data is ServiceNetwork) {
      return data.toJson();
    } else if (data != null) {
      return jsonEncode(data);
    } else {
      return data;
    }
  }

  R _parseBody<R, T extends ServiceNetwork>(dynamic responseBody, T model) {
    print(responseBody.runtimeType);
    if (responseBody is List) {
      return responseBody.map((data) => model.fromJson(data)).cast<T>().toList()
          as R;
    } else if (responseBody is Map<String, dynamic>) {
      return model.fromJson(responseBody) as R;
    } else if (responseBody is String) {
      return model.fromJson(jsonDecode(responseBody)) as R;
    } else {
      return EmptyModel(name: responseBody.toString()) as R;
    }
  }
}
