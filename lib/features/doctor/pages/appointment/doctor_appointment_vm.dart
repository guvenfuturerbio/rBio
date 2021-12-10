import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

import '../../../../core/data/repository/doctor_repository.dart';
import '../../../../core/enums/shared_preferences_keys.dart';
import '../../../../core/locator.dart';
import '../../../../core/manager/shared_preferences_manager.dart';
import '../../../../core/utils/jwt_token_parser.dart';
import '../../../../generated/l10n.dart';
import '../../../../model/model.dart';
import '../../utils/gradient_dialog.dart';
import '../../utils/hypo_hyper_edit/hypo_hyper_edit_view_model.dart';

class DoctorAppointmentVm extends ChangeNotifier {
  StateProcess _stateProcess = StateProcess.LOADING;
  BuildContext context;
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  bool _disposed = false;

  DoctorAppointmentVm({BuildContext context}) {
    this.context = context;
    setYearlyAppointments(
      AppointmentFilter(
        start: formatter.format(now.subtract(Duration(days: 14))),
        end: formatter.format(now.add(Duration(days: 14))),
        type: "c",
      ),
    );
    setDailyAppointments(
      AppointmentFilter(
        type: "d",
        start: formatter.format(now),
        end: formatter.format(now),
      ),
    );
  }

  List<Appointment> _dailyAppointments;
  List<Appointment> _yearlyAppointments;
  Map<DateTime, List> _calendarEvents;

  StateProcess get stateProcess => this._stateProcess;

  Map<DateTime, List> get calendarEvents => this._calendarEvents;

  List<Appointment> get dailyAppointments =>
      this._dailyAppointments ?? <Appointment>[];

  /// MG18
  setDailyAppointments(AppointmentFilter appointmentFilter) async {
    this._stateProcess = StateProcess.LOADING;
    notifyListeners();
    try {
      this._dailyAppointments =
          await getIt<DoctorRepository>().getAllAppointment(appointmentFilter);
      this._stateProcess = StateProcess.DONE;
      notifyListeners();
    } catch (e) {
      this._stateProcess = StateProcess.ERROR;
      notifyListeners();
    }
  }

  List<Appointment> get yearlyAppointments =>
      this._yearlyAppointments ?? <Appointment>[];
  setYearlyAppointments(AppointmentFilter appointmentFilter) async {
    this._yearlyAppointments =
        await getIt<DoctorRepository>().getAllAppointment(appointmentFilter);
    setCalendarEvents(yearlyAppointments);
  }

  setCalendarEvents(List<Appointment> appointments) {
    Map<DateTime, List> mapFetch = {};
    if (appointments != null) {
      for (int i = 0; i < appointments.length; i++) {
        var createTime = DateTime.parse(
            appointments[i].availability.dateTime.substring(0, 10));
        var original = mapFetch[createTime];
        if (original == null) {
          mapFetch[createTime] = [
            DateTime.parse(
                appointments[i].availability.dateTime.substring(0, 10))
          ];
        } else {
          mapFetch[createTime] = List.from(original)
            ..addAll([
              DateTime.parse(
                  appointments[i].availability.dateTime.substring(0, 10))
            ]);
        }
      }
      print(mapFetch);
      this._calendarEvents = mapFetch;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  Future<void> startAppointments(String webConsultantId) async {
    try {
      var options = JitsiMeetingOptions(room: webConsultantId)
        ..serverURL = "https://stream.guven.com.tr/"
        ..subject = " "
        ..userDisplayName = parseJwtPayLoad(getIt<ISharedPreferencesManager>()
                .getString(SharedPreferencesKeys.DOCTOR_TOKEN))['name'] ??
            parseJwtPayLoad(getIt<ISharedPreferencesManager>()
                .getString(SharedPreferencesKeys.DOCTOR_TOKEN))['fullname'] ??
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
    } catch (e) {
      showInformationDialog(LocaleProvider.current.sorry_dont_transaction);
    }
  }

  showInformationDialog(String text) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return GradientDialog(LocaleProvider.current.warning, text);
      },
    );
  }
}
