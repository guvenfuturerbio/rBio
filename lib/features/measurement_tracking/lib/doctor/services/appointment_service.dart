import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/doctor/helper/jwt_token_parser.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/doctor/models/appointment.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/doctor/models/appointment_filter.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/doctor/notifiers/user_notifiers.dart';

import 'api_service.dart';

class AppointmentService {
  fetchAppointments(AppointmentFilter appointmentFilter) async {
    FlutterSecureStorage storage = FlutterSecureStorage();
    final token = await storage.read(key: UserNotifiers.JWT_TOKEN);
    final response =
        await BaseProvider.create(token).getAllAppointment(appointmentFilter);
    if (response.statusCode == HttpStatus.ok) {
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      if (responseBody['is_successful'] == true) {
        var data = responseBody["datum"];
        List<Appointment> appointments = <Appointment>[];
        for (var data1 in data) {
          appointments.add(new Appointment.fromJson(data1));
        }
        return appointments;
      } else {
        throw Exception(response.statusCode);
      }
    }
  }

  startAppointments(String webConsultantId) async {
    try {
      FlutterSecureStorage storage = FlutterSecureStorage();
      final token = await storage.read(key: UserNotifiers.JWT_TOKEN);
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
}
