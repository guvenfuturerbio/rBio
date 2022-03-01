
import 'dart:convert';

import 'package:dio/dio.dart';

import '../../guven_service.dart';

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
      model = parseModel<R, T>(jsonDecode(data), parserModel);
    } else {
      model = parseModel<R, T>(data, parserModel);
    }

    return model;
  }
  // #endregion
}
R parseModel<R, T extends IBaseModel>(dynamic responseBody, T model) {
  if (responseBody is List) {
    return responseBody.map((data) => model.fromJson(data)).cast<T>().toList()
        as R;
  } else if (responseBody is Map) {
    try {
      if (responseBody.length > 1) {
        var list = <T>[];
        responseBody.forEach((key, value) {
          list.add(model.fromJson(value));
        });

        return list as R;
      } else {
        return model.fromJson(Map.from(responseBody)) as R;
      }
    } catch (_) {
      return model.fromJson(Map.from(responseBody)) as R;
    }
  } else {
    return responseBody as R;
  }
}