import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onedosehealth/doctor/models/appointment.dart';
import 'package:onedosehealth/doctor/models/appointment_filter.dart';
import 'package:onedosehealth/doctor/pages/patients_page/patient_page_view_model.dart';
import 'package:onedosehealth/doctor/services/appointment_service.dart';
import 'package:onedosehealth/doctor/utils/gradient_dialog.dart';
import 'package:onedosehealth/generated/l10n.dart';

class AppointmentPageViewModel extends ChangeNotifier {
  StateProcess _stateProcess = StateProcess.LOADING;
  BuildContext context;
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  bool _disposed = false;
  AppointmentPageViewModel({BuildContext context}) {
    this.context = context;
    setYearlyAppointments(AppointmentFilter(
        start: formatter.format(now.subtract(Duration(days: 14))),
        end: formatter.format(now.add(Duration(days: 14))),
        type: "c"));
    setDailyAppointments(AppointmentFilter(
        type: "d", start: formatter.format(now), end: formatter.format(now)));
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
          await AppointmentService().fetchAppointments(appointmentFilter);
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
        await AppointmentService().fetchAppointments(appointmentFilter);
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

  startAppointments(String webConsultantId) async {
    try {
      await AppointmentService().startAppointments(webConsultantId);
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
        });
  }
}
