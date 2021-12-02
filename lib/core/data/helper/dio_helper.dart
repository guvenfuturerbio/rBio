import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';

import 'package:onedosehealth/core/platform/mobil_interface.dart'
    if (dart.library.html) 'package:onedosehealth/core/platform/web_interface.dart';

import '../../core.dart';
import '../../../model/model.dart';

const String getMethod = 'GET';
const String postMethod = 'POST';

abstract class IDioHelper {
  Future<GuvenResponseModel> getGuven(
    String path, {
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
  });

  Future<GuvenResponseModel> postGuven(
    String path,
    dynamic data, {
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  });

  Future<GuvenResponseModel> deleteGuven(
    String path, {
    data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
  });

  Future<GuvenResponseModel> patchGuven(
    String path, {
    dynamic data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    void Function(int, int) onSendProgress,
    void Function(int, int) onReceiveProgress,
  });

  Future<R> dioGet<T extends IBaseModel, R>(
    String path, {
    T parseModel,
    bool isJsonDecode = false,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
  });

  Future dioPost(
    String path,
    dynamic data, {
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  });

  Future dioDelete(
    String path, {
    data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
  });

  Future dioPatch(
    String path, {
    dynamic data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    void Function(int, int) onSendProgress,
    void Function(int, int) onReceiveProgress,
  });
}

extension DioHelperExtension on IDioHelper {
  // #region GetResponseResult
  dynamic getResponseResult<T extends IBaseModel, R>(
      dynamic data, T parserModel, bool isJsonDecode) {
    if (parserModel == null) return data;

    dynamic model;

    if (isJsonDecode) {
      model = ParseModel<R, T>(jsonDecode(data), parserModel);
    } else {
      model = ParseModel<R, T>(data, parserModel);
    }

    return model;
  }
  // #endregion
}

R ParseModel<R, T extends IBaseModel>(dynamic responseBody, T model) {
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

class DioHelper with DioMixin implements Dio, IDioHelper {
  // #region Settings
  DioHelper() {
    options = BaseOptions(
      connectTimeout: 60000,
      receiveTimeout: 60000,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      headers: {
        HttpHeaders.userAgentHeader: 'dio',
        'clientVersion': getIt<GuvenSettings>().version,
      },
    );

    httpClientAdapter = MobileWebInterface.getAdapter();
    final newAdapter = MobileWebInterface.onHttpClientCreate(httpClientAdapter);
    if (newAdapter != null) {
      httpClientAdapter = newAdapter;
    }

    interceptors.add(
      InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          LoggerUtils.instance.v(options.uri);
          LoggerUtils.instance.d(options.headers);

          if (options.method == postMethod) {
            final data = options.data;
            if (data is Map) {
              LoggerUtils.instance.d(data);
            } else if (data is FormData) {
              final map = <String, dynamic>{};
              for (var file in data.files) {
                map[file.key] =
                    '${file.value.filename} ${file.value.contentType}';
              }
              for (var field in data.fields) {
                map['${field.key}'] = '${field.value}';
              }
              LoggerUtils.instance.d(map);
            }
          }

          return handler.next(options);
        },
        onResponse:
            (Response<dynamic> response, ResponseInterceptorHandler handler) {
          LoggerUtils.instance.v(response.requestOptions.uri);
          LoggerUtils.instance.i(response.data);

          return handler.next(response);
        },
        onError: (DioError error, ErrorInterceptorHandler handler) {
          LoggerUtils.instance.v(error.requestOptions.uri);
          LoggerUtils.instance.w(error.response?.statusCode);
          LoggerUtils.instance.wtf(error.response?.toString());
          LoggerUtils.instance.wtf(error.error?.toString());

          return handler.next(error);
        },
      ),
    );

    interceptors.add(
      InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          final connectivityResult = await Connectivity().checkConnectivity();
          final isConnectionNone =
              connectivityResult == ConnectivityResult.none;
          if (isConnectionNone) {
            return handler.reject(
              DioError(
                requestOptions: options,
                error: RbioNetworkException(),
              ),
            );
          }

          return handler.next(options);
        },
        onResponse:
            (Response<dynamic> response, ResponseInterceptorHandler handler) {
          return handler.next(response);
        },
        onError: (DioError error, ErrorInterceptorHandler handler) async {
          final statusCode = error.response?.statusCode;
          if (statusCode != null) {
            if (statusCode == 401) {
              if (!Atom.url.contains(PagePaths.LOGIN)) {
                final password = getIt<ISharedPreferencesManager>()
                    .getString(SharedPreferencesKeys.LOGIN_PASSWORD);
                final userName = getIt<ISharedPreferencesManager>()
                    .getString(SharedPreferencesKeys.LOGIN_USERNAME);

                if (password != null) {
                  if (R.endpoints.loginPath
                      .contains(error.response.requestOptions.uri.path)) {
                    Atom.to(PagePaths.LOGIN, isReplacement: true);
                  } else {
                    try {
                      await getIt<UserManager>().login(userName, password);

                      final requestModel = error.requestOptions;
                      final response = await request(
                        requestModel.path,
                        data: requestModel.data,
                        queryParameters: requestModel.queryParameters,
                        cancelToken: requestModel.cancelToken,
                        onReceiveProgress: requestModel.onReceiveProgress,
                        onSendProgress: requestModel.onSendProgress,
                        options: Options(
                            method: requestModel.method,
                            headers: requestModel.headers
                              ..addAll(
                                {
                                  'Authorization':
                                      getIt<ISharedPreferencesManager>()
                                          .get(SharedPreferencesKeys.JWT_TOKEN),
                                },
                              )),
                      );
                      return handler.resolve(response);
                    } catch (_) {
                      return handler.reject(
                        DioError(
                          requestOptions: error.response.requestOptions,
                          error: Exception('401'),
                        ),
                      );
                    }
                  }
                } else {
                  Atom.to(PagePaths.LOGIN, isReplacement: true);
                }
              }
            }
          }

          return handler.next(error);
        },
      ),
    );
  }
  // #endregion

  // ************************** **************************

  @override
  Future<GuvenResponseModel> getGuven(
    String path, {
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
  }) async {
    return await dioGet<GuvenResponseModel, GuvenResponseModel>(
      path,
      isJsonDecode: false,
      parseModel: GuvenResponseModel(),
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  @override
  Future<GuvenResponseModel> postGuven(
    String path,
    dynamic data, {
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  }) async {
    final response = await dioPost(
      path,
      data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    return GuvenResponseModel.fromJson(response);
  }

  @override
  Future<GuvenResponseModel> deleteGuven(
    String path, {
    data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
  }) async {
    final response = await dioDelete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );

    return GuvenResponseModel.fromJson(response);
  }

  @override
  Future<GuvenResponseModel> patchGuven(
    String path, {
    dynamic data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    void Function(int, int) onSendProgress,
    void Function(int, int) onReceiveProgress,
  }) async {
    final response = await dioPatch(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    return GuvenResponseModel.fromJson(response);
  }

  // #region DioGet
  @override
  Future<R> dioGet<T extends IBaseModel, R>(
    String path, {
    T parseModel,
    bool isJsonDecode = false,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
  }) async {
    try {
      final response = await get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      if (response.statusCode < HttpStatus.ok ||
          response.statusCode > HttpStatus.badRequest) {
        throw Exception('GET | ${response.data}');
      }

      return getResponseResult<T, R>(response.data, parseModel, isJsonDecode);
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }
  // #endregion

  // #region DioPost
  @override
  Future dioPost(
    String path,
    dynamic data, {
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  }) async {
    try {
      final response = await post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      if (response.statusCode < HttpStatus.ok ||
          response.statusCode > HttpStatus.badRequest) {
        throw Exception('POST | ${response.data}');
      }

      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }
  // #endregion

  // #region DioDelete
  @override
  Future dioDelete(
    String path, {
    data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
  }) async {
    try {
      final response = await delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      if (response.statusCode < HttpStatus.ok ||
          response.statusCode > HttpStatus.badRequest) {
        throw Exception('DELETE | ${response.data}');
      }

      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }
  // #endregion

  // #region DioPatch
  @override
  Future dioPatch(
    String path, {
    dynamic data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    void Function(int, int) onSendProgress,
    void Function(int, int) onReceiveProgress,
  }) async {
    try {
      final response = await patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      if (response.statusCode < HttpStatus.ok ||
          response.statusCode > HttpStatus.badRequest) {
        throw Exception('PATCH | ${response.data}');
      }

      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }

  // #endregion
}
