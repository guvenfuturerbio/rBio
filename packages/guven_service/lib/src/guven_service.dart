import 'package:dio/dio.dart';
import 'package:key_manager/key_manager.dart';

import '../guven_service.dart';

part 'endpoints.dart';

class GuvenService {
  final IDioHelper _dioHelper;
  final String _token;
  final String _lang;
  final _Endpoints endpoints;

  GuvenService(
    this._dioHelper,
    KeyManager _keyManager,
    this._token,
    this._lang,
  ) : endpoints = _Endpoints(_keyManager);

  Options get authOptions => Options(
        headers: <String, dynamic>{
          'Authorization': _token,
          'Lang': _lang,
        },
      );

  // #region Scale
  Future<GuvenResponseModel> getScaleMasurement(
    GetScaleMasurementBody getScaleMasurementBody,
  ) async {
    final response = await _dioHelper.postGuven(
      endpoints.getScaleMeasurement,
      getScaleMasurementBody.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/getScaleMasurement : ${response.isSuccessful}');
    }
  }

  Future<GuvenResponseModel> addScaleMeasurement(
    AddScaleMasurementBody addScaleMasurementBody,
  ) async {
    final response = await _dioHelper.postGuven(
      endpoints.insertNewScaleValue,
      addScaleMasurementBody.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/addScaleMeasurement : ${response.isSuccessful}');
    }
  }

  Future<bool> updateScaleMeasurement(
    UpdateScaleMasurementBody updateScaleMasurementBody,
  ) async {
    final response = await _dioHelper.postGuven(
      endpoints.updateScaleMeasurement,
      updateScaleMasurementBody.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response.datum;
    } else {
      throw Exception('/updateScaleMeasurement : ${response.isSuccessful}');
    }
  }

  Future<bool> deleteScaleMeasurement(
    DeleteScaleMasurementBody deleteScaleMasurementBody,
  ) async {
    final response = await _dioHelper.postGuven(
      endpoints.deleteScaleMeasurement,
      deleteScaleMasurementBody.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response.datum;
    } else {
      throw Exception('/deleteScaleMeasurement : ${response.isSuccessful}');
    }
  }
  // #endregion
}
