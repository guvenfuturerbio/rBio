import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:guven_service/guven_service.dart';

import '../src/model/base_model.dart';

abstract class IDioHelper {
  Future<GuvenResponseModel> getGuven(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  });

  Future<GuvenResponseModel> postGuven(
    String path,
    dynamic data, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  });

  Future<GuvenResponseModel> deleteGuven(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  });

  Future<GuvenResponseModel> patchGuven(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  });

  Future<R> dioGet<T extends IBaseModel, R>(
    String path, {
    T? parseModel,
    bool? isJsonDecode = false,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  });

  Future dioPost(
    String path,
    dynamic data, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  });

  Future dioDelete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  });

  Future dioPatch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  });
}

extension DioHelperExtension on IDioHelper {
  // #region GetResponseResult
  dynamic getResponseResult<T extends IBaseModel, R>(
      dynamic data, T? parserModel, bool isJsonDecode) {
    if (parserModel == null) return data;

    dynamic model;

    if (isJsonDecode) {
      model = parseModel<R, T>(jsonDecode(data as String), parserModel);
    } else {
      model = parseModel<R, T>(data, parserModel);
    }

    return model;
  }
  // #endregion
}

R parseModel<R, T extends IBaseModel>(dynamic responseBody, T model) {
  if (responseBody is List) {
    return responseBody
        .map<dynamic>(
            (dynamic data) => model.fromJson(data as Map<String, dynamic>))
        .cast<T>()
        .toList() as R;
  } else if (responseBody is Map) {
    try {
      if (responseBody.length > 1) {
        var list = <T>[];
        responseBody.forEach((dynamic key, dynamic value) {
          list.add(model.fromJson(value as Map<String, dynamic>) as T);
        });

        return list as R;
      } else {
        return model.fromJson(Map<String, dynamic>.from(responseBody)) as R;
      }
    } catch (_) {
      return model.fromJson(Map<String, dynamic>.from(responseBody)) as R;
    }
  } else {
    return responseBody as R;
  }
}
