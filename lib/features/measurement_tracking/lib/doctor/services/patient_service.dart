import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/blood_glucose.dart';
import '../models/get_my_patient_filter.dart';
import '../models/patient.dart';
import '../models/patientDetail.dart';
import '../models/update_my_patient_limit.dart';
import '../notifiers/user_notifiers.dart';
import 'api_service.dart';

class PatientService {
  Future<List<Patient>> fetchPatientList(
      {@required GetMyPatientFilter getMyPatientFilter}) async {
    FlutterSecureStorage storage = FlutterSecureStorage();
    final token = await storage.read(key: UserNotifiers.JWT_TOKEN);
    final response =
        await BaseProvider.create(token).getMyPatients(getMyPatientFilter);

    if (response.statusCode == HttpStatus.ok) {
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      if (responseBody['is_successful'] == true) {
        var datum = responseBody["datum"];
        List<Patient> patientList = [];
        for (var data in datum) {
          patientList.add(Patient.fromJson(data));
        }
        return patientList;
      } else {
        throw Exception('Response is_successfull = ' +
            responseBody['is_successful'].toString());
      }
    } else {
      throw Exception('response code ' + response.statusCode.toString());
    }

    /* Patient patient = Patient(
        name: "kadir kanak",
        id: 123,
        diabetType: DiabetType(id: 1, name: "Type 1"),
        entegrationId: 1,
        hyper: "185",
        hypo: "47",
        lastBg: "124",
        type1Count: 2,
        type2Count: 4,
        type3Count: 1,
        alertMax: 210,
        alertMin: 60,
        normalMax: 176,
        normalMin: 120);

    Patient patient2 = Patient(
        name: "mert kanak",
        id: 124,
        diabetType: DiabetType(id: 2, name: "Type 2"),
        entegrationId: 2,
        hyper: "235",
        hypo: "97",
        lastBg: "154",
        type1Count: 2,
        type2Count: 5,
        type3Count: 2,
        alertMax: 210,
        alertMin: 60,
        normalMax: 116,
        normalMin: 100);

    List<Patient> patientList =[];
    await Future.delayed(Duration(seconds: 3));
    patientList.add(patient);
    patientList.add(patient2);
    return patientList; */
  }

  Future<PatientDetail> fetchPatientDetail({@required int id}) async {
    FlutterSecureStorage storage = FlutterSecureStorage();
    final token = await storage.read(key: UserNotifiers.JWT_TOKEN);
    final response = await BaseProvider.create(token).getMyPatientDetail(id);

    if (response.statusCode == HttpStatus.ok) {
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      if (responseBody['is_successful'] == true) {
        var datum = responseBody["datum"];
        PatientDetail patientDetail = PatientDetail();
        patientDetail = PatientDetail.fromJson(datum);
        return patientDetail;
      } else {
        throw Exception('Response is_successfull = ' +
            responseBody['is_successful'].toString());
      }
    } else {
      throw Exception('response code ' + response.statusCode.toString());
    }

    /*   PatientDetail patientDetail = PatientDetail(
        hypo: 65,
        hyper: 135,
        entegrationId: 1,
        diabetType: DiabetType(id: 1, name: "Type 1"),
        name: "kadir kanak",
        id: 123,
        height: "190cm",
        weight: "95kg",
        birthDay: "1995-09-30",
        deviceUuid: "1",
        gender: "man",
        rangeMax: 130,
        rangeMin: 90,
        smoker: true,
        stripCount: 156,
        yearOfDiagnosis: 2015);
    await Future.delayed(Duration(seconds: 2));
    return patientDetail; */
  }

  Future<bool> updatePatientLimit(
      {@required int patientId,
      @required UpdateMyPatientLimit updateMyPatientLimit}) async {
    FlutterSecureStorage storage = FlutterSecureStorage();
    final token = await storage.read(key: UserNotifiers.JWT_TOKEN);
    final response = await BaseProvider.create(token)
        .updateMyPatientLimit(patientId, updateMyPatientLimit);

    if (response.statusCode == HttpStatus.ok) {
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      if (responseBody['is_successful'] == true) {
        var datum = responseBody["datum"];
        return datum;
      } else {
        throw Exception('Response is_successfull = ' +
            responseBody['is_successful'].toString());
      }
    } else {
      throw Exception('response code ' + response.statusCode.toString());
    }
  }

  Future<List<BloodGlucose>> getPatientBloodGlucose(
      {@required int patientId,
      @required GetMyPatientFilter getMyPatientFilter}) async {
    FlutterSecureStorage storage = FlutterSecureStorage();
    final token = await storage.read(key: UserNotifiers.JWT_TOKEN);
    final response = await BaseProvider.create(token)
        .getMyPatientBloodGlucose(patientId, getMyPatientFilter);

    if (response.statusCode == HttpStatus.ok) {
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      if (responseBody['is_successful'] == true) {
        var datum = responseBody["datum"];
        List<BloodGlucose> bloodGlucoseList = [];
        for (var data in datum) {
          bloodGlucoseList.add(BloodGlucose.fromJson(data));
        }
        return bloodGlucoseList;
      } else {
        throw Exception('Response is_successfull = ' +
            responseBody['is_successful'].toString());
      }
    } else {
      throw Exception('response code ' + response.statusCode.toString());
    }
  }
}
