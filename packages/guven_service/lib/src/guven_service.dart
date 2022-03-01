import 'package:guven_service/src/model/model.dart';
import 'package:onedosehealth/core/core.dart';

/// {@template guven_server}
/// Network requests from Guven server
/// {@endtemplate}
class GuvenService {
  final IDioHelper _dioHelper;
  GuvenService(IDioHelper dioHelper):_dioHelper=dioHelper;

  /// {@macro guven_server}

  Future<GuvenResponseModel> updateScaleMeasurement(
    UpdateScaleMasurementBody updateScaleMasurementBody,
  ) async {
    final response = await _dioHelper.postGuven(
      R.endpoints.ctUpdateScaleMeasurement,
      updateScaleMasurementBody.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/updateScaleMeasurement : ${response.isSuccessful}');
    }
  }

  Future<GuvenResponseModel> getScaleMasurement(
    GetScaleMasurementBody getScaleMasurementBody,
  ) async {
    final response = await _dioHelper.postGuven(
      R.endpoints.ctGetScaleMeasurement,
      getScaleMasurementBody.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/getScaleMasurement : ${response.isSuccessful}');
    }
  }

  Future<GuvenResponseModel> deleteScaleMeasurement(
    DeleteScaleMasurementBody deleteScaleMasurementBody,
  ) async {
    final response = await _dioHelper.postGuven(
      R.endpoints.ctDeleteScaleMeasurement,
      deleteScaleMasurementBody.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/deleteScaleMeasurement : ${response.isSuccessful}');
    }
  }

  Future<GuvenResponseModel> insertNewScaleValue(
    AddScaleMasurementBody addScaleMasurementBody,
  ) async {
    final response = await _dioHelper.postGuven(
      R.endpoints.ctInsertNewScaleValue,
      addScaleMasurementBody.toJson(),
      options: authOptions,
    );
    if (response.xIsSuccessful) {
      return response;
    } else {
      throw Exception('/insertNewScaleValue : ${response.isSuccessful}');
    }
  }
}
