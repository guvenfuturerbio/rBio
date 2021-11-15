part of 'service_shaft.dart';

class ServiceManager extends ChopperClient implements Service, ChopperService {
  ServiceNetwork errorModel;
  ServiceManager(
      {@required String baseUrl, bool isEnableLogger, String authToken}) {
    client = ChopperClient(
        baseUrl: baseUrl,
        interceptors: isEnableLogger
            ? [
                HeadersInterceptor({
                  'Authorization': authToken,
                  'Lang': Intl.getCurrentLocale()
                }),
                NetworkConnectionChecker(),
                HttpLoggingInterceptor(),
                (Response response) async {
                  if (response.statusCode == 401) {
                    chopperLogger.severe("Unauthorized");
                  }
                  return response;
                }
              ]
            : [
                HeadersInterceptor({
                  'Authorization': authToken,
                  'Lang': Intl.getCurrentLocale()
                }),
                NetworkConnectionChecker(),
              ],
        converter: ModelConverter());
  }

  @override
  ChopperClient client;

  @override
  Type get definitionType => ServiceManager;

  ResponseModel<R> _onError<R>(dynamic e) {
    var errorResponse;
    if (e is Response) {
      errorResponse = e.body.toString();
    } else {
      errorResponse = e.toString();
    }

    final error = ErrorModel(
        description: errorResponse,
        statusCode: (e is Response)
            ? errorResponse.statusCode
            : HttpStatus.internalServerError);
    if (errorResponse != null) {
      _generateErrorModel(error, errorResponse.data);
    }
    return ResponseModel<R>(error: error);
  }

  void _generateErrorModel(ErrorModel error, dynamic data) {
    if (errorModel == null) return;
    final _data = data is Map ? data : jsonDecode(data);
    error.model = errorModel.fromJson(_data);
  }

  ResponseModel<R> getResponseResult<T extends ServiceNetwork, R>(
      dynamic data, T parserModel) {
    final model = _parseBody<R, T>(data, parserModel);
    return ResponseModel<R>(data: model);
  }

  @override
  Future<ServiceResponse<R>> request<T extends ServiceNetwork, R>(String path,
      {T parseModel,
      RequestType method,
      String urlSuffix,
      Map<String, dynamic> queryParameters,
      dynamic body,
      Map<String, String> headers,
      bool isMultiPart,
      file,
      data}) async {
    try {
      var _req = Request(
        method.toStr,
        path,
        client.baseUrl,
        body: body,
        parameters: queryParameters,
        multipart: isMultiPart,
        headers: headers ?? isMultiPart
            ? {'Content-Type': 'multipart/formdata'}
            : {},
        parts:
            isMultiPart ? <PartValue>[PartValueFile<String>('file', file)] : [],
      );
      final response = await client.send<dynamic, dynamic>(_req);

      switch (response.statusCode) {
        case HttpStatus.ok:
          return getResponseResult<T, R>(response.body, parseModel);
        default:
          return _onError(response);
      }
    } catch (e) {
      _onError(e);
    }
  }
}
