import 'dart:io';

import 'package:dio/dio.dart';
import 'package:onedosehealth/core/platform/mobil_interface.dart'
    if (dart.library.html) 'package:onedosehealth/core/platform/web_interface.dart';

import '../../config/config.dart';
import '../../core/core.dart';

const String getMethod = 'GET';
const String postMethod = 'POST';
const String patchMethod = 'PATCH';

class DioHelper with DioMixin implements Dio, IDioHelper {
  @override
  late bool isTest;

  // #region Settings
  DioHelper(this.isTest) {
    options = BaseOptions(
      connectTimeout: 60000,
      receiveTimeout: 60000,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      headers: {
        HttpHeaders.userAgentHeader: 'dio',
        // 'clientVersion': getIt<GuvenSettings>().version,
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

          if (options.method == postMethod || options.method == patchMethod) {
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
                map[field.key] = field.value;
              }
              LoggerUtils.instance.d(map);
            }
          }

          return handler.next(options);
        },
        onResponse:
            (Response<dynamic> response, ResponseInterceptorHandler handler) {
          LoggerUtils.instance
              .v("(${response.statusCode}) - ${response.requestOptions.uri}");
          LoggerUtils.instance.i(response.data);

          return handler.next(response);
        },
        onError: (DioError error, ErrorInterceptorHandler handler) {
          LoggerUtils.instance.v(
              "(${error.response?.statusCode}) - ${error.requestOptions.uri}");
          LoggerUtils.instance.wtf(error.response?.toString());

          return handler.next(error);
        },
      ),
    );

    interceptors.add(
      InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          return handler.next(options);
        },
        onResponse:
            (Response<dynamic> response, ResponseInterceptorHandler handler) {
          return handler.next(response);
        },
        onError: (DioError error, ErrorInterceptorHandler handler) async {
          final statusCode = error.response?.statusCode;
          if (statusCode != null) {
            if (statusCode == 401 && !isTest) {
              if (!Atom.url.contains(PagePaths.login)) {
                final password = getIt<ISharedPreferencesManager>()
                    .getString(SharedPreferencesKeys.loginPassword);
                final userName = getIt<ISharedPreferencesManager>()
                    .getString(SharedPreferencesKeys.loginUserName);
                final consentId = getIt<ISharedPreferencesManager>()
                    .getString(SharedPreferencesKeys.consentId);

                if (password != null && userName != null) {
                  if (getIt<IAppConfig>()
                      .endpoints
                      .accessToken
                      .loginPath
                      .contains(error.response!.requestOptions.uri.path)) {
                    Atom.to(PagePaths.login, isReplacement: true);
                  } else {
                    try {
                      await getIt<UserManager>()
                          .login(userName, password, consentId ?? '');

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
                                        .getString(
                                            SharedPreferencesKeys.jwtToken),
                              },
                            ),
                        ),
                      );
                      return handler.resolve(response);
                    } catch (e, stackTrace) {
                      getIt<IAppConfig>()
                          .platform
                          .sentryManager
                          .captureException(e, stackTrace: stackTrace);
                      return handler.reject(
                        DioError(
                          requestOptions: error.response!.requestOptions,
                          error: Exception('401'),
                        ),
                      );
                    }
                  }
                } else {
                  Atom.to(PagePaths.login, isReplacement: true);
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
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
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
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
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
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
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
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
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
    T? parseModel,
    bool? isJsonDecode = false,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      return getResponseResult<T, R>(
          response.data, parseModel, isJsonDecode ?? false);
    } on SocketException catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      throw SocketException(e.toString());
    } on FormatException catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      throw const FormatException('Unable to process the data');
    } catch (e, stackTrace) {
      _handleError(path, e);
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      return Future.value();
    }
  }
  // #endregion

  // #region DioPost
  @override
  Future dioPost(
    String path,
    dynamic data, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
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

      return response.data;
    } on SocketException catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      throw SocketException(e.toString());
    } on FormatException catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      throw const FormatException('Unable to process the data');
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      _handleError(path, e);
    }
  }
  // #endregion

  // #region DioDelete
  @override
  Future dioDelete(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return response.data;
    } on SocketException catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      throw SocketException(e.toString());
    } on FormatException catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      throw const FormatException('Unable to process the data');
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      _handleError(path, e);
    }
  }
  // #endregion

  // #region DioPatch
  @override
  Future dioPatch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
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

      return response.data;
    } on SocketException catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      throw SocketException(e.toString());
    } on FormatException catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      throw const FormatException('Unable to process the data');
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      _handleError(path, e);
    }
  }
  // #endregion

  void _handleError(String url, dynamic error) {
    if (error is Exception) {
      if (error is DioError) {
        switch (error.type) {
          case DioErrorType.response:
            _checkStatusCode(error.response, url);
            break;

          case DioErrorType.other:
            if (error.message.contains('SocketException: Failed host lookup')) {
              throw RbioNetworkException(url);
            }
            break;

          default:
            break;
        }
      }
    }

    throw error;
  }

  void _checkStatusCode(Response<dynamic>? response, String url) {
    final statusCode = response?.statusCode;
    if (statusCode != null) {
      if (statusCode >= HttpStatus.badRequest &&
          statusCode <= HttpStatus.clientClosedRequest) {
        throw RbioClientException(url, response?.data);
      } else if (statusCode >= HttpStatus.internalServerError &&
          statusCode <= HttpStatus.networkConnectTimeoutError) {
        throw RbioServerException(url, response?.data);
      }
    }
  }
}
