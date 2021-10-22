import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:turkish/turkish.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';

class DepartmentListScreenVm extends ChangeNotifier {
  List<FilterDepartmentsResponse> _filterDepartmentsResponse;
  BuildContext mContext;
  LoadingProgress _progress;

  DepartmentListScreenVm({
    BuildContext context,
    int tenantId,
    bool fromOnlineSelection,
  }) {
    this.mContext = context;
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        fromOnlineSelection
            ? await fetchOnlineDepartments(
                FilterOnlineDepartmentsRequest(
                  appointmentType:
                      R.dynamicVar.onlineAppointmentType.toString(),
                  tenantId: R.dynamicVar.tenantAyranciId,
                ),
              )
            : await fetchDepartments(
                FilterDepartmentsRequest(
                  search: null,
                  tenantId: tenantId,
                ),
              );
      },
    );
  }

  List<FilterDepartmentsResponse> get filterDepartmentResponse =>
      this._filterDepartmentsResponse;

  LoadingProgress get progress => this._progress;

  Future<void> fetchDepartments(
      FilterDepartmentsRequest filterDepartmentsRequest) async {
    try {
      this._progress = LoadingProgress.LOADING;
      notifyListeners();
      List<String> string = [];

      this._filterDepartmentsResponse =
          await getIt<Repository>().filterDepartments(filterDepartmentsRequest);
      this._filterDepartmentsResponse.forEach((element) {
        string.add(element.title);
      });
      string = string..sort(turkish.comparator);
      List<FilterDepartmentsResponse> temp = [];
      string.forEach((element) {
        _filterDepartmentsResponse.forEach((element2) {
          if (element == element2.title && !temp.contains(element2)) {
            temp.add(element2);
          }
        });
      });
      _filterDepartmentsResponse = temp;
      this._progress = LoadingProgress.DONE;
      notifyListeners();
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      print("fetch Departments error " + e.toString());
      showGradientDialog(mContext, LocaleProvider.current.warning,
          LocaleProvider.current.sorry_dont_transaction);
      this._progress = LoadingProgress.ERROR;
      notifyListeners();
    }
  }

  Future<void> fetchOnlineDepartments(
      FilterOnlineDepartmentsRequest filterOnlineDepartmentsRequest) async {
    try {
      this._progress = LoadingProgress.LOADING;
      notifyListeners();
      this._filterDepartmentsResponse = await getIt<Repository>()
          .fetchOnlineDepartments(filterOnlineDepartmentsRequest);
      List<String> string = [];

      this._filterDepartmentsResponse.forEach((element) {
        string.add(element.title);
      });
      string = string..sort(turkish.comparator);
      List<FilterDepartmentsResponse> temp = [];
      string.forEach((element) {
        _filterDepartmentsResponse.forEach((element2) {
          if (element == element2.title && !temp.contains(element2)) {
            temp.add(element2);
          }
        });
      });
      _filterDepartmentsResponse = temp;
      this._progress = LoadingProgress.DONE;
      notifyListeners();
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      showGradientDialog(mContext, LocaleProvider.current.warning,
          LocaleProvider.current.sorry_dont_transaction);
      this._progress = LoadingProgress.ERROR;
      notifyListeners();
    }
  }

  showGradientDialog(BuildContext context, String title, String text) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return GradientDialog(title, text);
        });
  }
}
