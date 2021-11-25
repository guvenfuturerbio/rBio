import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onedosehealth/features/mediminder/models/strip_detail_model.dart';
import 'package:onedosehealth/core/core.dart';

import '../../../../../core/data/imports/cronic_tracking.dart';
import '../../../../../core/locator.dart';
import '../../database/repository/glucose_repository.dart';
import '../../models/bg_measurement/blood_glucose_report_body.dart';
import '../../models/bg_measurement/blood_glucose_value_model.dart';
import '../../models/bg_measurement/delete_bg_measurement_request.dart';
import '../../models/bg_measurement/get_blood_glucose_data_of_person.dart';
import '../../models/bg_measurement/get_hba1c_measurement_list.dart';
import '../../models/bg_measurement/update_bg_measurement_request.dart';
import '../../models/firebase/add_firebase_body.dart';
import '../../notifiers/user_profiles_notifier.dart';

class BaseProviderRepository with ChangeNotifier {
  static final BaseProviderRepository _instance =
      BaseProviderRepository._internal();

  factory BaseProviderRepository() {
    return _instance;
  }

  static const int TIMEOUT_DURATION = 15;

  BaseProviderRepository._internal() {}

  /// EXAMPLE USAGE OF THIS REPOSITORY CLASS
  /// This class should act as an interface between base_provider and ui pages
  /// Expected result or an error should be returned to the calling function
  /// BaseProvider class should not be referenced outside this class
  Future<List<HbA1cMeasurement>> getHba1cMeasurementList(
      GetHba1cMeasurementListModel getHba1cMeasurementListModel,
      String entegrationId) async {
    try {
      final response = await getIt<ChronicTrackingRepository>()
          .getHba1cMeasurementList(getHba1cMeasurementListModel, entegrationId);
      return response.datum;
      // if (response.statusCode == HttpStatus.ok) {
      //   // 200
      //   final datum = getDatumFromResponse(response);
      //   if (datum != null) {
      //     return (datum as List);
      //   } else {
      //     return null;
      //   }
      // } else {
      //   // else
      //   return null;
      // }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<int>> getBloodGlucoseReport(int type) async {
    try {
      BloodGlucoseReportBody bloodGlucoseReportBody =
          new BloodGlucoseReportBody(
        start: "2010-09-10T00:00:00",
        end: "2022-09-10T00:00:00",
        reportType: type,
        userId: UserProfilesNotifier().selection?.id ?? 0,
      ); // Report Type 1 -> Excel
      final response = await getIt<ChronicTrackingRepository>()
          .getBloodGlucoseReport(bloodGlucoseReportBody);
      var bytes = base64.decode(response.datum);
      return bytes;
    } catch (e) {
      return null;
    }
  }

  Future<StripDetailModel> getUserStrips(
      int entegrationId, String deviceUUID) async {
    try {
      final response = await getIt<ChronicTrackingRepository>().getUserStrip(
          entegrationId, deviceUUID == "" ? "no-device" : deviceUUID);
      return response;
    } catch (e) {
      return null;
    }
  }

  Future<bool> setUserStrips(StripDetailModel stripDetailModel) async {
    if (stripDetailModel.deviceUUID == "") {
      stripDetailModel.deviceUUID = "no-device";
    }

    try {
      await getIt<ChronicTrackingRepository>()
          .updateUserStrip(stripDetailModel);
      return true;
    } catch (e) {
      return false;
    }
  }

  /* Future<bool> insertNewBloodGlucoseValue(
      BloodGlucoseValue bloodGlucoseValue, GlucoseData glucoseData) async {
    try {
      final response = await getIt<ChronicTrackingRepository>()
          .insertNewBloodGlucoseValue(bloodGlucoseValue);
      glucoseData.measurementId = response.datum;
      await GlucoseRepository().updateGlucoseData(glucoseData, false);
      return true;
    } catch (e) {
      await Future.delayed(Duration(seconds: 1));
      return false;
    }
  } */

  Future<bool> deleteBloodGlucoseValue(
      DeleteBloodGlucoseMeasurementRequest
          deleteBloodGlucoseMeasurementRequest) async {
    try {
      await getIt<ChronicTrackingRepository>()
          .deleteBloodGlucoseValue(deleteBloodGlucoseMeasurementRequest);
      return true;
    } catch (e) {
      await Future.delayed(Duration(seconds: 1));
      return false;
    }
  }

  Future<bool> updateBloodGlucoseValue(
      UpdateBloodGlucoseMeasurementRequest
          updateBloodGlucoseMeasurementRequest) async {
    try {
      await getIt<ChronicTrackingRepository>()
          .updateBloodGlucoseValue(updateBloodGlucoseMeasurementRequest);
      return true;
    } catch (e) {
      await Future.delayed(Duration(seconds: 1));
      return false;
    }
  }

  Future<bool> uploadMeasurementImage(
      String imagePath, int i, int measurementId) async {
    try {
      await getIt<ChronicTrackingRepository>().uploadMeasurementImage(
          imagePath, UserProfilesNotifier().selection.id ?? 0, measurementId);
      return true;
    } catch (e) {
      return false;
    }
  }

  /* Future<bool> addProfile(Person person) async {
    try {
      await getIt<ChronicTrackingRepository>().addProfile(person);
      return true;
    } catch (e) {
      return false;
    }
  } */

  Future<bool> changeProfile(int id) async {
    try {
      await getIt<ChronicTrackingRepository>().changeProfile(id);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addFirebaseToken(AddFirebaseToken addFirebaseToken) async {
    try {
      await getIt<ChronicTrackingRepository>()
          .addFirebaseToken(addFirebaseToken);
      return true;
    } catch (e) {
      return false;
    }
  }

  /*  Future<bool> updateProfile(Person person, int id) async {
    try {
      person.isFirstUser = false;
      person.userId = -1;
      await getIt<ChronicTrackingRepository>().updateProfile(person, person.id);
      return true;
    } catch (e) {
      return false;
    }
  } */

  Future<bool> deleteBloodGlucose(int timeKey) async {
    try {
      //final response = await _baseProvider.deleteBloodGlucose(timeKey) ;
      //bool statusCode = response.statusCode == HttpStatus.ok;
      bool statusCode = true; // TODO Update with the actual deletion server
      if (statusCode) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}

class HbA1cMeasurement {
  double value;
  String note;
}
