import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../core/core.dart';
import '../../../../core/data/repository/doctor_repository.dart';
import '../../../../model/model.dart';
import '../model/patient_list_model.dart';

enum DoctorPatientListSortType {
  //
  criticalMetrics,
  fromNewest,
  fromOldest,

  //
}

class DoctorPatientListVm extends ChangeNotifier with RbioVm {
  @override
  BuildContext mContext;
  PatientType type;

  PatientListModel listModel;

  DoctorPatientListVm(this.mContext, this.type) {
    fetchAll();
  }

  LoadingProgress _progress;
  LoadingProgress get progress => _progress;
  set progress(LoadingProgress value) {
    _progress = value;
    notifyListeners();
  }

  Future<void> fetchAll() async {
    try {
      progress = LoadingProgress.LOADING;
      listModel = await _getAllByType();
      progress = LoadingProgress.DONE;
    } catch (e, stackTrace) {
      log(e.toString());
      debugPrintStack(stackTrace: stackTrace);
      progress = LoadingProgress.ERROR;
      Sentry.captureException(e, stackTrace: stackTrace);
      showGradientDialog(
        LocaleProvider.current.warning,
        LocaleProvider.current.sorry_dont_transaction,
        true,
      );
    }
  }

  // #region _getAllByType
  Future<PatientListModel<dynamic>> _getAllByType() async {
    switch (type) {
      case PatientType.Sugar:
        {
          return PatientBloodGlucoseListModel(
            mContext,
            await getIt<DoctorRepository>().getMySugarPatient(
              GetMyPatientFilter(
                skip: 0,
                take: 500,
              ),
            ),
          );
        }

      case PatientType.BMI:
        {
          return PatientBMIListModel(
            mContext,
            await getIt<DoctorRepository>().getMyBMIPatient(
              GetMyPatientFilter(
                skip: 0,
                take: 500,
              ),
            ),
          );
        }

      case PatientType.Bp:
        {
          return PatientBloodPressureListModel(
            mContext,
            await getIt<DoctorRepository>().getMyBpPatient(
              GetMyPatientFilter(
                skip: 0,
                take: 500,
              ),
            ),
          );
        }

      default:
        return Future.error(Exception('Undefined Type'));
    }
  }
  // #endregion

  List<PatientListItemModel> get getList => listModel.getList;
  int get getitemCount => listModel.getitemCount;

  void textOnChanged(String text) {
    listModel.textOnChanged(text);
    notifyListeners();
  }

  List<Widget> getPopupWidgets() {
    return listModel.getPopupWidgets(
      onSelect: (sortType) {
        sortList(sortType);
      },
    );
  }

  void sortList(DoctorPatientListSortType sortType) {
    listModel.filterList(sortType);
    notifyListeners();
  }

  Color getBackColor(String text, dynamic model) =>
      listModel.getBackColor(text, model);

  void itemOnTap(dynamic model) => listModel.itemOnTap(model);
}
