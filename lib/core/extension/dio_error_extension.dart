import 'package:dio/dio.dart';

import '../../model/model.dart';
import '../core.dart';

extension DioErrorExtension on DioError {
  GuvenResponseModel? get xGuvenResponseModel {
    final eType = type;
    if (eType == DioErrorType.response) {
      try {
        final responseData = Map<String, dynamic>.from(response?.data);
        return GuvenResponseModel.fromJson(responseData);
      } catch (e) {
        return null;
      }
    }

    return null;
  }
}
