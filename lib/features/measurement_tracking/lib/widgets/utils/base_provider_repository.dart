import 'dart:convert';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onedosehealth/database/datamodels/glucose_data.dart';
import 'package:onedosehealth/database/repository/glucose_repository.dart';
import 'package:onedosehealth/models/bg_measurement/blood_glucose_report_body.dart';
import 'package:onedosehealth/models/bg_measurement/blood_glucose_value_model.dart';
import 'package:onedosehealth/models/bg_measurement/delete_bg_measurement_request.dart';
import 'package:onedosehealth/models/bg_measurement/get_blood_glucose_data_of_person.dart';
import 'package:onedosehealth/models/bg_measurement/get_hba1c_measurement_list.dart';
import 'package:onedosehealth/models/bg_measurement/update_bg_measurement_request.dart';
import 'package:onedosehealth/models/firebase/add_firebase_body.dart';
import 'package:onedosehealth/models/notification/strip_detail_model.dart';
import 'package:onedosehealth/models/user_profiles/person.dart';
import 'package:onedosehealth/notifiers/user_profiles_notifier.dart';
import 'package:onedosehealth/pages/signup&login/token_provider.dart';
import 'package:onedosehealth/services/base_provider.dart';
import 'package:path_provider/path_provider.dart';

class BaseProviderRepository with ChangeNotifier {
  static final BaseProviderRepository _instance =
      BaseProviderRepository._internal();

  factory BaseProviderRepository() {
    return _instance;
  }

  static const int TIMEOUT_DURATION = 15;
  BaseProvider _baseProvider;

  BaseProvider get baseProvider => _baseProvider;
  BaseProviderRepository._internal() {
    refreshProvider();
  }

  refreshProvider() {
    _baseProvider = BaseProvider.create(TokenProvider().authToken);
  }

  getDatumFromResponse(Response response) {}

  /// EXAMPLE USAGE OF THIS REPOSITORY CLASS
  /// This class should act as an interface between base_provider and ui pages
  /// Expected result or an error should be returned to the calling function
  /// BaseProvider class should not be referenced outside this class
  Future<List<HbA1cMeasurement>> getHba1cMeasurementList(
      GetHba1cMeasurementListModel getHba1cMeasurementListModel,
      String entegrationId) async {
    refreshProvider();

    try {
      final response = await _baseProvider.getHba1cMeasurementList(
          getHba1cMeasurementListModel, entegrationId);
      if (response.statusCode == HttpStatus.ok) {
        // 200
        final datum = getDatumFromResponse(response);
        if (datum != null) {
          return (datum as List);
        } else {
          return null;
        }
      } else {
        // else
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<int>> getBloodGlucoseReport(int type) async {
    refreshProvider();

    try {
      BloodGlucoseReportBody bloodGlucoseReportBody =
          new BloodGlucoseReportBody(
              start: "2010-09-10T00:00:00",
              end: "2022-09-10T00:00:00",
              reportType: type,
              userId: UserProfilesNotifier().selection?.id ??
                  0); // Report Type 1 -> Excel
      final response =
          await _baseProvider.getBloodGlucoseReport(bloodGlucoseReportBody);

      if (response.isSuccessful) {
        var documentBody = jsonDecode(utf8.decode(response.bodyBytes));
        var datum = documentBody["datum"];
        var bytes = base64.decode(datum);
        return bytes;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> uploadProfilePicture(String path) async {
    refreshProvider();

    int entegrationId = UserProfilesNotifier().selection.id ?? 0;
    try {
      final response =
          await _baseProvider.uploadProfilePicture(path, entegrationId);

      if (response.isSuccessful) {
        for (Person p in UserProfilesNotifier().profiles.person) {
          if (p.id == entegrationId) {
            p.profileImage = new File(path);
          }
        }
        UserProfilesNotifier().selection.profileImage = new File(path);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<File> getProfilePictureOfCurrentUser() async {
    refreshProvider();

    int entegrationId = UserProfilesNotifier().selection.id ?? 0;
    try {
      final response = await _baseProvider.getProfilePicture(entegrationId);
      print(response);
      if (response.statusCode == HttpStatus.ok) {
        var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
        var datum = responseBody["datum"];

        var bytes = base64.decode(datum);

        String fileName =
            "profile_picture_onedosehealth_${entegrationId.toString()}";

        String dir = (await getApplicationDocumentsDirectory()).path;
        File file = new File('$dir/$fileName');

        await file.writeAsBytes(bytes);
        return file;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<File> getProfilePictureOfProfile(int entegrationId) async {
    refreshProvider();

    try {
      final response = await _baseProvider.getProfilePicture(entegrationId);
      print(response);
      if (response.statusCode == HttpStatus.ok) {
        var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
        var datum = responseBody["datum"];

        var bytes = base64.decode(datum);

        String fileName =
            "profile_picture_onedosehealth_${entegrationId.toString()}";

        String dir = (await getApplicationDocumentsDirectory()).path;
        File file = new File('$dir/$fileName');

        await file.writeAsBytes(bytes);
        return file;
      } else if (response.statusCode == 204) {
        return new File(""); // no image has been uploaded yet
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> deleteProfilePictureOfCurrentUser() async {
    refreshProvider();

    int entegrationId = UserProfilesNotifier().selection.id ?? 0;
    try {
      final response = await _baseProvider.deleteProfilePicture(entegrationId);

      if (response.statusCode == HttpStatus.ok) {
        for (Person p in UserProfilesNotifier().profiles.person) {
          if (p.id == entegrationId) {
            p.profileImage = new File("");
          }
        }
        UserProfilesNotifier().selection.profileImage = new File("");
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> deleteProfilePictureOfProfile(int entegrationId) async {
    refreshProvider();

    try {
      final response = await _baseProvider.deleteProfilePicture(entegrationId);

      if (response.statusCode == HttpStatus.ok) {
        for (Person p in UserProfilesNotifier().profiles.person) {
          if (p.id == entegrationId) {
            p.profileImage = new File("");
          }
        }
        if (entegrationId == UserProfilesNotifier().selection.id) {
          UserProfilesNotifier().selection.profileImage = new File("");
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<StripDetailModel> getUserStrips(
      int entegrationId, String deviceUUID) async {
    refreshProvider();

    try {
      final response = await _baseProvider.getUserStrip(
          entegrationId, deviceUUID == "" ? "no-device" : deviceUUID);

      if (response.statusCode == HttpStatus.ok) {
        var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
        StripDetailModel stripDetailModel =
            StripDetailModel.fromJson(responseBody["datum"]);
        return stripDetailModel;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> setUserStrips(StripDetailModel stripDetailModel) async {
    if (stripDetailModel.deviceUUID == "") {
      stripDetailModel.deviceUUID = "no-device";
    }
    refreshProvider();

    try {
      final response = await _baseProvider.updateUserStrip(stripDetailModel);

      if (response.statusCode == HttpStatus.ok) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> insertNewBloodGlucoseValue(
      BloodGlucoseValue bloodGlucoseValue, GlucoseData glucoseData) async {
    refreshProvider();
    try {
      final response =
          await _baseProvider.insertNewBloodGlucoseValue(bloodGlucoseValue);
      if (response.statusCode == HttpStatus.ok) {
        glucoseData.measurementId = response.body['datum'];
        await GlucoseRepository().updateGlucoseData(glucoseData, false);
        return true;
      } else {
        await Future.delayed(Duration(seconds: 1));
        insertNewBloodGlucoseValue(bloodGlucoseValue, glucoseData);
        //return false;
      }
    } catch (e) {
      await Future.delayed(Duration(seconds: 1));
      insertNewBloodGlucoseValue(bloodGlucoseValue, glucoseData);
    }
  }

  deleteBloodGlucoseValue(
      DeleteBloodGlucoseMeasurementRequest
          deleteBloodGlucoseMeasurementRequest) async {
    refreshProvider();
    try {
      final response = await _baseProvider
          .deleteBloodGlucoseValue(deleteBloodGlucoseMeasurementRequest);
      if (response.statusCode == HttpStatus.ok) {
        return true;
      } else {
        await Future.delayed(Duration(seconds: 1));
        deleteBloodGlucoseValue(deleteBloodGlucoseMeasurementRequest);
        //return false;
      }
    } catch (e) {
      await Future.delayed(Duration(seconds: 1));
      deleteBloodGlucoseValue(deleteBloodGlucoseMeasurementRequest);
    }
  }

  updateBloodGlucoseValue(
      UpdateBloodGlucoseMeasurementRequest
          updateBloodGlucoseMeasurementRequest) async {
    refreshProvider();
    try {
      final response = await _baseProvider
          .updateBloodGlucoseValue(updateBloodGlucoseMeasurementRequest);
      if (response.statusCode == HttpStatus.ok) {
        return true;
      } else {
        await Future.delayed(Duration(seconds: 1));
        updateBloodGlucoseValue(updateBloodGlucoseMeasurementRequest);
        //return false;
      }
    } catch (e) {
      await Future.delayed(Duration(seconds: 1));
      updateBloodGlucoseValue(updateBloodGlucoseMeasurementRequest);
    }
  }

  Future<bool> uploadMeasurementImage(
      String imagePath, int i, int measurementId) async {
    refreshProvider();

    try {
      final response = await _baseProvider.uploadMeasurementImage(
          imagePath, UserProfilesNotifier().selection.id ?? 0, measurementId);

      if (response.statusCode == HttpStatus.ok) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<List<GlucoseData>> getBloodGlucoseDataOfPerson(Person pd) async {
    refreshProvider();

    try {
      GetBloodGlucoseDataOfPerson getBloodGlucoseDataOfPerson =
          new GetBloodGlucoseDataOfPerson(
              id: pd.id, start: "01.01.2011", end: "01.01.2025");
      final response = await baseProvider
          .getBloodGlucoseDataOfPerson(getBloodGlucoseDataOfPerson);

      if (response.statusCode == HttpStatus.ok) {
        var profilesBody = jsonDecode(utf8.decode(response.bodyBytes));
        List datum = profilesBody["datum"]["blood_glucose_measurement_details"];
        print(datum);
        List<GlucoseData> glucoseDataList = new List();
        for (var bgMeasurement in datum) {
          //BloodGlucoseValue
          print(bgMeasurement);
          int time = DateTime.parse(bgMeasurement["detail"]["occurrence_time"])
              .millisecondsSinceEpoch;
          String level = bgMeasurement["blood_glucose_measurement"]["value"];
          String note =
              bgMeasurement["blood_glucose_measurement"]["value_note"];
          int tag = bgMeasurement["tag"]["id"];
          bool manual = bgMeasurement["is_manuel"];
          int measurementId = bgMeasurement["id"];

          GlucoseData glucoseData = new GlucoseData(
              time: time,
              userId: pd.id,
              level: level,
              note: note,
              tag: tag,
              manual: manual,
              measurementId: measurementId,
              device: 103);
          glucoseDataList.add(glucoseData);
        }

        return glucoseDataList;
      } else {
        return new List();
      }
    } catch (e) {
      print(e.toString());
      return new List();
    }
  }

  Future<bool> addProfile(Person person) async {
    refreshProvider();

    try {
      final response = await _baseProvider.addProfile(person);

      if (response.statusCode == HttpStatus.ok) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> changeProfile(int id) async {
    refreshProvider();

    try {
      final response = await _baseProvider.changeProfile(id);

      if (response.statusCode == HttpStatus.ok) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> addFirebaseToken(AddFirebaseToken addFirebaseToken) async {
    refreshProvider();

    try {
      final response = await _baseProvider.addFirebaseToken(addFirebaseToken);

      if (response.statusCode == HttpStatus.ok) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> updateProfile(Person person, int id) async {
    refreshProvider();

    try {
      person.isFirstUser = false;
      person.userId = -1;
      final response = await _baseProvider.updateProfile(person, person.id);

      if (response.statusCode == HttpStatus.ok) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> deleteBloodGlucose(int timeKey) async {
    refreshProvider();

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
