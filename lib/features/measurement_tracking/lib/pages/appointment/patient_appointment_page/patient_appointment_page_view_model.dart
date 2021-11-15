import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../../models/appointment_models/PatientAppointment.dart';
import '../../../models/body_pages/body_pages_columns.dart';
import '../../../models/body_pages/body_pages_model.dart';
import '../../../models/body_pages/body_pages_order.dart';
import '../../../models/body_pages/body_pages_search.dart';
import '../../../notifiers/user_profiles_notifier.dart';
import '../../../services/appointment_service.dart';
import '../../../widgets/gradient_dialog.dart';
import '../appointment_page/appointment_page_view_model.dart';

class PatientAppointmentPageViewModel with ChangeNotifier {
  BuildContext context;
  List<PatientAppointment> _appointmentList = [];
  Stage _stage;

  PatientAppointmentPageViewModel({BuildContext context}) {
    this.context = context;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await fetchDepartments();
    });
  }

  BodyPages _getBodyPages() {
    BodyPages bodyPages = new BodyPages();
    bodyPages.draw = 1;
    Search search = new Search();
    search.value = "";
    search.regex = false;
    List<Columns> columns = [];
    Columns column = new Columns();
    column.data = "appointment_type_category.appointment_type.name";
    column.name = "co";
    column.searchable = true;
    column.orderable = true;
    column.search = search;
    columns.add(column);
    Columns column1 = new Columns();
    column1.data = "date";
    column1.name = "null";
    column1.searchable = true;
    column1.orderable = true;
    column1.search = search;
    columns.add(column1);
    Columns column2 = new Columns();
    column2.data = "doctor";
    column2.name = "null";
    column2.searchable = true;
    column2.orderable = true;
    column2.search = search;
    columns.add(column2);
    Columns column3 = new Columns();
    column3.data = "info";
    column3.name = "null";
    column3.searchable = true;
    column3.orderable = true;
    column3.search = search;
    columns.add(column3);
    Columns column4 = new Columns();
    column4.data = "link";
    column4.name = "null";
    column4.searchable = true;
    column4.orderable = true;
    column4.search = search;
    columns.add(column4);
    List<Order> orderList = [];
    Order order = new Order();
    order.column = 1;
    order.dir = "asc";
    orderList.add(order);
    bodyPages.order = orderList;
    bodyPages.columns = columns;
    bodyPages.start = 0;
    bodyPages.length = "150";
    bodyPages.search = search;
    return bodyPages;
  }

  Future<void> fetchDepartments() async {
    this._stage = Stage.LOADING;
    notifyListeners();
    try {
      this._appointmentList = await AppointmentService()
          .fetchPatientAppointment(
              0, _getBodyPages(), UserProfilesNotifier().selection.id);
      this._stage = Stage.DONE;
      notifyListeners();
    } catch (e) {
      print(e);
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

  List<PatientAppointment> get appointments => this._appointmentList;

  Stage get stage => this._stage;

  startAppointment(String webConsultantId) async {
    try {
      await AppointmentService().startAppointments(webConsultantId);
    } catch (e) {
      showInformationDialog();
    }
  }
}
