import '../../config/config.dart';
import '../core.dart';

class RbioClientException implements Exception {
  final String url;
  final Object? data;

  RbioClientException(this.url, [this.data]);

  @override
  String toString() => '[RbioClientException]';
}

extension RbioClientExceptionExt on RbioClientException {
  GuvenResponseModel? get xGetGuvenResponseModel {
    if (data != null) {
      if (data is Map<String, dynamic>) {
        try {
          return GuvenResponseModel.fromJson(data as Map<String, dynamic>);
        } catch (e, stackTrace) {
          getIt<IAppConfig>()
              .platform
              .sentryManager
              .captureException(e, stackTrace: stackTrace);
          return null;
        }
      }
    }

    return null;
  }

  T? xGetModel<T extends IBaseModel>(T parserModel) {
    final guvenResponseModel = xGetGuvenResponseModel;
    if (guvenResponseModel != null) {
      final datum = guvenResponseModel.datum;
      return parseModel<T, T>(datum, parserModel);
    }

    return null;
  }
}
