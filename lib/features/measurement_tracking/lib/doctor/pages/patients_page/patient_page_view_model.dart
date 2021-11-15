import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../../notification_handler.dart';
import '../../models/get_my_patient_filter.dart';
import '../../models/patient.dart';
import '../../services/patient_service.dart';
import '../../utils/gradient_dialog.dart';
import '../../utils/progress/progress_dialog.dart';

enum StateProcess { DONE, LOADING, ERROR }

class PatientPageViewModel extends ChangeNotifier {
  StateProcess _stateProcess;
  List<Patient> _patientList = [];
  BuildContext _context;
  bool _disposed = false;
  ProgressDialog progressDialog;
  String _selectedItem;
  DateTime _startDate, _endDate;
  PatientPageViewModel({BuildContext context}) {
    this._context = context;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setSelectedItem(selectedItem);
    });
    NotificationHandler().addListener(() async {
      setSelectedItem(selectedItem);
    });
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

  Future<void> fetchPatientList(DateTime start, DateTime end) async {
    _stateProcess = StateProcess.LOADING;
    notifyListeners();
    try {
      this._patientList = await PatientService().fetchPatientList(
          getMyPatientFilter: GetMyPatientFilter(
              end: end.toString(),
              start: start.toString(),
              skip: "0",
              take: "500" // TODO
              ));
      _stateProcess = StateProcess.DONE;
      notifyListeners();
    } catch (e) {
      showInformationDialog(LocaleProvider.of(_context).sorry_dont_transaction);
      _stateProcess = StateProcess.ERROR;
      notifyListeners();
    }
  }

  List<Patient> get patientList => this._patientList;
  StateProcess get stateProcess => this._stateProcess;

  showInformationDialog(String text) {
    showDialog(
        context: _context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return GradientDialog(LocaleProvider.current.warning, text);
        });
  }

  List<String> get items => [
        LocaleProvider.of(_context).last_one_hour,
        LocaleProvider.of(_context).last_one_day,
        LocaleProvider.of(_context).last_one_week,
        LocaleProvider.of(_context).last_one_month,
        LocaleProvider.of(_context).specific
      ];

  String get selectedItem => this._selectedItem ?? items[1];

  setSelectedItem(String text) async {
    this._selectedItem = text;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 100));
    if (selectedItem == LocaleProvider.of(_context).last_one_hour) {
      fetchPatientList(
          DateTime.now().subtract(Duration(hours: 1)), DateTime.now());
    } else if (selectedItem == LocaleProvider.of(_context).last_one_day) {
      fetchPatientList(
          DateTime.now().subtract(Duration(days: 1)), DateTime.now());
    } else if (selectedItem == LocaleProvider.of(_context).last_one_week) {
      fetchPatientList(
          DateTime.now().subtract(Duration(days: 7)), DateTime.now());
    } else if (selectedItem == LocaleProvider.of(_context).last_one_month) {
      fetchPatientList(
          DateTime(DateTime.now().year, DateTime.now().month - 1,
              DateTime.now().day),
          DateTime.now());
    }
  }

  DateTime get startDate => _startDate != null
      ? DateTime(_startDate.year, _startDate.month, _startDate.day)
      : DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  DateTime get endDate => _endDate != null
      ? DateTime(_endDate.year, _endDate.month, _endDate.day)
      : DateTime(
          DateTime.now().add(Duration(days: 1)).year,
          DateTime.now().add(Duration(days: 1)).month,
          DateTime.now().add(Duration(days: 1)).day);

  Future<void> setEndDate(DateTime d) async {
    this._endDate = d;
    notifyListeners();
    fetchPatientList(startDate, endDate);
  }

  Future<void> setStartDate(DateTime d) async {
    this._startDate = d;
    notifyListeners();
    fetchPatientList(startDate, endDate);
  }
}
