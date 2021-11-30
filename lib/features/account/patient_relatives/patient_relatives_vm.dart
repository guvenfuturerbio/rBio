import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../core/core.dart';
import '../../../model/model.dart';

enum LoadingStatus { done, loading }

class PatientRelativesScreenVm with ChangeNotifier {
  LoadingDialog loadingDialog;
  LoadingStatus status = LoadingStatus.loading;
  BuildContext context;
  PatientRelativesScreenVm(this.context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _fetchRelatives();
    });
  }

  final homeKey = GlobalKey<ScaffoldState>();
  UserAccount userAccount;
  PatientRelativeInfoResponse patientRelativeInfo;
  int selectedGender = 1;

  Future _fetchRelatives() async {
    try {
      userAccount = await getIt<Repository>().getUserProfile();
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      print(e.toString());
      showGradientDialog(
          context, "Error", LocaleProvider.of(context).no_network_connection);
    }

    GetAllRelativesRequest bodyPages = GetAllRelativesRequest();
    bodyPages.draw = 1;
    bodyPages.start = 0;
    bodyPages.length = "100";

    SearchObject searchObject = SearchObject();
    searchObject.value = "";
    searchObject.regex = false;
    bodyPages.search = SearchObject();
    bodyPages.search = searchObject;

    bodyPages.columns = <ColumnsObject>[];
    ColumnsObject columnsObject = new ColumnsObject();
    columnsObject.search = searchObject;
    columnsObject.orderable = true;
    columnsObject.name = "null";
    columnsObject.data = "patient.user.name";
    columnsObject.searchable = true;
    bodyPages.columns.add(columnsObject);

    bodyPages.order = <OrderObject>[];
    OrderObject orderObject = new OrderObject();
    orderObject.column = 0;
    orderObject.dir = "desc";
    bodyPages.order.add(orderObject);

    try {
      var response = await getIt<Repository>().getAllRelatives(bodyPages);
      setPatientRelativeInfo(response);
      if (patientRelativeInfo == null ||
          patientRelativeInfo.patientRelatives == []) {
        setPatientRelativeInfo(PatientRelativeInfoResponse([]));
      }
    } catch (e) {
      showGradientDialog(
          context, "Error", LocaleProvider.of(context).no_network_connection);
    }

    status = LoadingStatus.done;
    notifyListeners();
  }

  void showLoadingDialog(BuildContext context) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) =>
            loadingDialog = loadingDialog ?? LoadingDialog());
    notifyListeners();
  }

  void setPatientRelativeInfo(PatientRelativeInfoResponse info) {
    patientRelativeInfo = info;
    notifyListeners();
  }

  void hideDialog(BuildContext context) {
    if (loadingDialog != null && loadingDialog.isShowing()) {
      Navigator.of(context).pop();
      loadingDialog = null;
    }
    notifyListeners();
  }

  Future<void> changeUserToRelative(
      PatientRelative patientRelativeInfo, BuildContext context) async {
    showLoadingDialog(context);
    try {
      final response = await getIt<Repository>().getRelativeRelationships();
      var patientUserRelationships =
          response.datum["patient_user_relationships"];

      for (var pur in patientUserRelationships) {
        if (pur["patient"]["id"].toString() == patientRelativeInfo.id) {
          // Selected relative
          await getIt<Repository>()
              .changeActiveUserToRelative(pur["patient"]["user_id"].toString());
          hideDialog(context);
          AnalyticsManager().sendEvent(ChangeToRelativeSuccessEvent(
              patientRelativeInfo.name + " " + patientRelativeInfo.surname));
          Atom.to(PagePaths.MAIN, isReplacement: true);
          return;
        }
      }

      hideDialog(context);
      Navigator.pop(context);
    } catch (error, stackTrace) {
      Sentry.captureException(error, stackTrace: stackTrace);
      AnalyticsManager().sendEvent(new ChangeToRelativeFailEvent(
          patientRelativeInfo.name + " " + patientRelativeInfo.surname));
      Future.delayed(const Duration(milliseconds: 500), () {
        print(error);
        hideDialog(context);
        showGradientDialog(
            context,
            LocaleProvider.of(context).warning,
            error.toString() == "network"
                ? LocaleProvider.of(context).no_network_connection
                : LocaleProvider.of(context).sorry_dont_transaction);
      });
    }
  }

  void showGradientDialog(BuildContext context, String title, String text) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return WarningDialog(title, text);
      },
    );
  }

  // Relative Operations
  Future<void> deleteRelative(
      PatientRelative patientRelativeInfo, BuildContext context) async {
    try {
      final response = await getIt<Repository>()
          .removePatientRelative(patientRelativeInfo.id);
      var isSuccess = response.datum;
      if (isSuccess) {
        AnalyticsManager().sendEvent(DeleteRelativeSuccessEvent(
            patientRelativeInfo.name + " " + patientRelativeInfo.surname));
        await _fetchRelatives();
      } else {
        AnalyticsManager().sendEvent(DeleteRelativeFailEvent(
            patientRelativeInfo.name + " " + patientRelativeInfo.surname));
      }

      Navigator.pop(context);
    } catch (error, stackTrace) {
      Sentry.captureException(error, stackTrace: stackTrace);
      Future.delayed(const Duration(milliseconds: 500), () {
        AnalyticsManager().sendEvent(DeleteRelativeFailEvent(
            patientRelativeInfo.name + " " + patientRelativeInfo.surname));
        print(error);
        showGradientDialog(
            context,
            LocaleProvider.of(context).warning,
            error.toString() == "network"
                ? LocaleProvider.of(context).no_network_connection
                : LocaleProvider.of(context).sorry_dont_transaction);
      });
    }
  }
}
