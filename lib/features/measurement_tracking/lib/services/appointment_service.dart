import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

import '../helper/jwt_token_parser.dart';
import '../models/appointment_models/AppointedDoctor.dart';
import '../models/appointment_models/Appointment.dart';
import '../models/appointment_models/ClosestAppointment.dart';
import '../models/appointment_models/Department.dart';
import '../models/appointment_models/Filter.dart';
import '../models/appointment_models/PatientAppointment.dart';
import '../models/appointment_models/doctor.dart';
import '../models/body_pages/body_pages_model.dart';
import '../models/payment/payment.dart';
import '../models/payment/payment_response.dart';
import '../pages/signup&login/token_provider.dart';
import 'base_provider.dart';

class AppointmentService {
  String token = TokenProvider().authToken;
  Future<List<Department>> fetchOnlineAppointmentDepartment() async {
    var response =
        await BaseProvider.create(token).getOnlineDoctorDepartments();
    if (response.statusCode == HttpStatus.ok) {
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      if (responseBody['is_successful'] == true) {
        List<Department> departmentList = [];
        var body = responseBody['datum'];
        for (var data in body) {
          departmentList.add(Department.fromJson(data));
        }
        return departmentList;
      } else {
        throw Exception('Response is_successfull = ' +
            responseBody['is_successful'].toString());
      }
    } else {
      throw Exception('response code ' + response.statusCode.toString());
    }
  }

  Future<List<Doctor>> fetchDoctors(String id) async {
    var response =
        await BaseProvider.create(token).getOnlineDoctorByDepartments(id);
    if (response.statusCode == HttpStatus.ok) {
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      if (responseBody['is_successful'] == true) {
        List<Doctor> doctors = [];
        var body = responseBody['datum'];
        for (var data in body) {
          doctors.add(Doctor.fromJson(data));
        }
        return doctors;
      } else {
        throw Exception('Response is_successfull = ' +
            responseBody['is_successful'].toString());
      }
    } else {
      throw Exception('response code ' + response.statusCode.toString());
    }
  }

  Future<List<Appointment>> fetchDoctorsAppointment(
      String id, String date, List<Filter> filters) async {
    var response = await BaseProvider.create(TokenProvider().authToken)
        .getAllDoctorAppointment(id, date, filters);
    if (response.statusCode == HttpStatus.ok) {
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      if (responseBody['is_successful'] == true) {
        List<Appointment> appointments = [];
        var body = responseBody['datum'];
        for (var data in body) {
          if (Appointment.fromJson(data).dateTime.substring(0, 10) ==
              date.toString().substring(0, 10)) {
            appointments.add(Appointment.fromJson(data));
          }
        }
        return appointments;
      } else {
        throw Exception('Response is_successfull = ' +
            responseBody['is_successful'].toString());
      }
    } else {
      throw Exception('response code ' + response.statusCode.toString());
    }
  }

  Future<List<ClosestAppointment>> fetchClosestAppointments(String id) async {
    final response = await BaseProvider.create(token).getClosestAppointment(id);
    if (response.statusCode == HttpStatus.ok) {
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      if (responseBody['is_successful'] == true) {
        var datum = responseBody["datum"];
        List<ClosestAppointment> cAppointments = <ClosestAppointment>[];
        for (var data in datum) {
          if (data['date'] != null && data['hospital_id'] == 0) {
            cAppointments.add(new ClosestAppointment.fromJson(data));
          }
        }
        return cAppointments;
      } else {
        throw Exception('Response is_successfull = ' +
            responseBody['is_successful'].toString());
      }
    } else {
      throw Exception('response code ' + response.statusCode.toString());
    }
  }

  Future<List<PatientAppointment>> fetchPatientAppointment(
      int count, BodyPages bodyPages, var entegrationId) async {
    final response = await BaseProvider.create(token)
        .getAllPatientAppointment(entegrationId, count, bodyPages);
    if (response.statusCode == HttpStatus.ok) {
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      if (responseBody['is_successful'] == true) {
        var datum = responseBody["datum"];
        var dataList = datum['data'];
        print(dataList);
        List<PatientAppointment> appointments = [];
        for (var data in dataList) {
          appointments.add(PatientAppointment.fromJson(data));
        }
        return appointments;
      } else {
        throw Exception('Response is_successfull = ' +
            responseBody['is_successful'].toString());
      }
    } else {
      throw Exception('response code ' + response.statusCode.toString());
    }
  }

  Future<AppointedDoctor> fetchAppointedDoctor(
      var dep_id, var entegration_id) async {
    final response = await BaseProvider.create(token)
        .getPatientAppointmentDoctor(dep_id, entegration_id);
    if (response.statusCode == HttpStatus.ok) {
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      if (responseBody['is_successful'] == true) {
        var datum = responseBody["datum"];
        return AppointedDoctor.fromJson(datum);
      } else {
        throw Exception('Response is_successfull = ' +
            responseBody['is_successful'].toString());
      }
    } else {
      throw Exception('response code ' + response.statusCode.toString());
    }
  }

  Future<PaymentResponse> doPayment(Payment payment) async {
    final response = await BaseProvider.create(token).doPayment(payment);
    if (response.statusCode == HttpStatus.ok) {
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      if (responseBody['is_successful'] == true) {
        PaymentResponse paymentResponse =
            PaymentResponse.fromJson(responseBody);
        return paymentResponse;
      } else {
        throw Exception('Response is_successfull = ' +
            responseBody['is_successful'].toString());
      }
    } else {
      throw Exception('response code ' + response.statusCode.toString());
    }
  }

  /// MG15 - Patient Video communication methode
  startAppointments(String webConsultantId) async {
    try {
      var options = JitsiMeetingOptions(room: webConsultantId)
        ..serverURL = "https://stream.guven.com.tr/"
        ..subject = " "
        ..userDisplayName = parseJwtPayLoad(token)['name'] ??
            parseJwtPayLoad(token)['fullname'] ??
            "-"
        ..userEmail = " "
        ..audioOnly = false
        ..audioMuted = false
        ..videoMuted = false;

      await JitsiMeet.joinMeeting(options,
          listener: JitsiMeetingListener(onConferenceWillJoin: (message) {
            debugPrint("${options.room} will join with message: $message");
          }, onConferenceJoined: (message) {
            debugPrint("${options.room} joined with message: $message");
          }, onConferenceTerminated: (message) {
            debugPrint("${options.room} terminated with message: $message");
          }));
    } catch (error) {
      debugPrint("error: $error");
      throw Exception(error);
    }
  }

  Future<List<String>> fetchAppointmentFiles(
      var entegrationId, var webAppointmentId) async {
    final response = await BaseProvider.create(token)
        .getAppointmentFiles(entegrationId, webAppointmentId);
    if (response.statusCode == HttpStatus.ok) {
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      if (responseBody['is_successful'] == true) {
        var datum = responseBody['datum'];
        List<String> files = [];
        for (var data in datum) {
          files.add(data);
        }
        return files;
      } else {
        throw Exception('Response is_successfull = ' +
            responseBody['is_successful'].toString());
      }
    } else {
      throw Exception('response code ' + response.statusCode.toString());
    }
  }

  Future<bool> uploadFileToAppointment(
      var entegrationId, var webAppointmentId, var file) async {
    final response = await BaseProvider.create(token)
        .uploadFileToAppointment(entegrationId, webAppointmentId, file);
    if (response.statusCode == HttpStatus.ok) {
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      if (responseBody['is_successful'] == true) {
        var datum = responseBody['datum'];
        if (datum == true) {
          return true;
        } else {
          return false;
        }
      } else {
        throw Exception('Response is_successfull = ' +
            responseBody['is_successful'].toString());
      }
    } else {
      throw Exception('response code ' + response.statusCode.toString());
    }
  }

  Future<Uint8List> downloadFile(
      var entegration_id, var webAppointmentId, var fileName) async {
    final response = await BaseProvider.create(token)
        .downloadAppointmentFile(entegration_id, webAppointmentId, fileName);
    if (response.statusCode == HttpStatus.ok) {
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      if (responseBody['is_successful'] == true) {
        var bytes = base64.decode(responseBody['datum']);
        return bytes;
      } else {
        throw Exception('Response is_successfull = ' +
            responseBody['is_successful'].toString());
      }
    } else {
      throw Exception('response code ' + response.statusCode.toString());
    }
  }

  Future<bool> deleteFile(
      var entegration_id, var webAppointmentId, var fileName) async {
    final response = await BaseProvider.create(token)
        .deleteAppointmentFile(entegration_id, webAppointmentId, fileName);
    if (response.statusCode == HttpStatus.ok) {
      final responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      if (responseBody['is_successful']) {
        if (responseBody['datum'] == true) {
          return true;
        } else {
          return false;
        }
      } else {
        throw Exception('Response is_successfull = ' +
            responseBody['is_successful'].toString());
      }
    } else {
      throw Exception('response code ' + response.statusCode.toString());
    }
  }
}
