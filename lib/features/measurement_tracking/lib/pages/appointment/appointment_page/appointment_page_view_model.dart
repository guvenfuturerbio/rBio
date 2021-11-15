import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../../models/appointment_models/Appointment.dart';
import '../../../models/appointment_models/ClosestAppointment.dart';
import '../../../models/appointment_models/Filter.dart';
import '../../../services/appointment_service.dart';
import '../../../widgets/gradient_dialog.dart';

enum Stage { ERROR, LOADING, DONE }

class AppointmentPageViewModel with ChangeNotifier {
  BuildContext context;
  List<Appointment> _appointmentList = [];
  List<ClosestAppointment> _closestAppointments = [];
  String _doctorId, _date;
  List<Filter> _filter = [];
  Stage _stage;

  AppointmentPageViewModel({BuildContext context, String id}) {
    this.context = context;
    this._doctorId = id;
    this._date = DateTime.now().toString();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await fetchAppointments();
    });
  }

  Stage get stage => this._stage;

  Future<void> fetchAppointments() async {
    this._stage = Stage.LOADING;
    notifyListeners();
    try {
      this._appointmentList = await AppointmentService()
          .fetchDoctorsAppointment(doctorId, date, filter);
      if (appointments.length > 0) {
        this._stage = Stage.DONE;
        notifyListeners();
      } else {
        fetchClosestAppointments();
      }
    } catch (e) {
      this._stage = Stage.ERROR;
      showInformationDialog();
      notifyListeners();
    }
  }

  List<Appointment> get appointments => this._appointmentList;

  Future<void> fetchClosestAppointments() async {
    this._closestAppointments =
        await AppointmentService().fetchClosestAppointments(doctorId);
    this._stage = Stage.DONE;
    notifyListeners();
  }

  List<ClosestAppointment> get closestAppointments => this._closestAppointments;

  String get doctorId => this._doctorId;

  void setDoctorId(String id) {
    this._doctorId = id;
    notifyListeners();
  }

  String get date => this._date;

  void setDate(String date) {
    this._date = date;
    fetchAppointments();
  }

  List<Filter> get filter => this._filter;

  void setFilter() {
    Filter filter = Filter(id: 11, type: "appointment_type");
    this._filter.add(filter);
    notifyListeners();
  }

  showInformationDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return GradientDialog(LocaleProvider.current.warning,
              LocaleProvider.current.sorry_dont_transaction);
        });
  }
}
