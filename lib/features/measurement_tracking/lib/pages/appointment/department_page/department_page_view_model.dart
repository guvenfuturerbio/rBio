import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../../models/appointment_models/Department.dart';
import '../../../services/appointment_service.dart';
import '../../../widgets/gradient_dialog.dart';
import '../appointment_page/appointment_page_view_model.dart';

class DepartmentPageViewModel with ChangeNotifier {
  BuildContext context;
  List<Department> _departmentList = [];
  Stage _stage;

  DepartmentPageViewModel({BuildContext context}) {
    this.context = context;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await fetchDepartments();
    });
  }

  Future<void> fetchDepartments() async {
    this._stage = Stage.LOADING;
    notifyListeners();
    try {
      this._departmentList =
          await AppointmentService().fetchOnlineAppointmentDepartment();
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

  List<Department> get departments => this._departmentList;

  Stage get stage => this._stage;
}
