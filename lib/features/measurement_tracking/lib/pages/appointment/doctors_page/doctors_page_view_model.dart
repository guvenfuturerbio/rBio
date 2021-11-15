import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../../helper/resources.dart';
import '../../../models/appointment_models/AppointedDoctor.dart';
import '../../../models/appointment_models/doctor.dart';
import '../../../notifiers/user_profiles_notifier.dart';
import '../../../services/appointment_service.dart';
import '../../../widgets/gradient_dialog.dart';
import '../../../widgets/question_dialog.dart';
import '../appointment_page/appointment_page_view_model.dart';

class DoctorsPageViewModel with ChangeNotifier {
  BuildContext context;
  List<Doctor> _doctorList = [];
  Stage _stage;
  AppointedDoctor _appointedDoctor;
  String departmentId;
  DoctorsPageViewModel({BuildContext context, String id}) {
    this.context = context;
    this.departmentId = id;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await fetchDoctors(id);
      await fetchAppointedDoctor(id, UserProfilesNotifier().selection.id);
    });
  }

  Future<void> fetchDoctors(String id) async {
    this._stage = Stage.LOADING;
    notifyListeners();
    try {
      this._doctorList = await AppointmentService().fetchDoctors(id);
      this._stage = Stage.DONE;
      notifyListeners();
    } catch (e) {
      this._stage = Stage.ERROR;
      showInformationDialog();
      notifyListeners();
    }
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

  Stage get stage => this._stage;

  List<Doctor> get doctors => this._doctorList;

  AppointedDoctor get appointedDoctor => this._appointedDoctor;

  Future<void> fetchAppointedDoctor(var dep_id, var entegration_id) async {
    this._stage = Stage.LOADING;
    notifyListeners();
    try {
      this._appointedDoctor = await AppointmentService()
          .fetchAppointedDoctor(dep_id, entegration_id);
      this._stage = Stage.DONE;
      notifyListeners();
    } catch (e) {
      print(e);
      this._stage = Stage.ERROR;
      showInformationDialog();
      notifyListeners();
    }
  }

  checkAppointedDoctor(Doctor doctor) {
    if (appointedDoctor.lastDoctorIdOfPatientAppointment != null) {
      if (appointedDoctor.lastDoctorIdOfPatientAppointment == doctor.id) {
        Navigator.of(context).pushNamed(Routes.APPOINTMENT, arguments: doctor);
      } else {
        showQuestionDialog(doctor);
      }
    } else {
      Navigator.of(context).pushNamed(Routes.APPOINTMENT, arguments: doctor);
    }
  }

  showQuestionDialog(Doctor doctor) {
    String text = LocaleProvider.current.last_appointment_doctor + ":" + "\n";
    text +=
        (appointedDoctor?.lastDoctorNameOfPatientAppointment?.toUpperCase()) ??
            " ";
    text += "\n" + LocaleProvider.current.the_doctor_u_chose + ":" + "\n";
    text += doctor?.employee?.user?.name?.toUpperCase() ?? " ";
    text += "\n${LocaleProvider.current.do_u_want_continue}";
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return QuestionDialog(LocaleProvider.current.warning, text);
        }).then((value) {
      if (value ?? false) {
        Navigator.of(context).pushNamed(Routes.APPOINTMENT, arguments: doctor);
      }
    });
  }
}
