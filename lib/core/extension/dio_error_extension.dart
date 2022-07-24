import 'package:dio/dio.dart';

import '../../config/config.dart';
import '../core.dart';

extension DioErrorExtension on DioError {
  GuvenResponseModel? get xGuvenResponseModel {
    final eType = type;
    if (eType == DioErrorType.response) {
      try {
        final responseData = Map<String, dynamic>.from(response?.data);
        return GuvenResponseModel.fromJson(responseData);
      } catch (e, stackTrace) {
        getIt<IAppConfig>()
            .platform
            .sentryManager
            .captureException(e, stackTrace: stackTrace);
        return null;
      }
    }

    return null;
  }
}
