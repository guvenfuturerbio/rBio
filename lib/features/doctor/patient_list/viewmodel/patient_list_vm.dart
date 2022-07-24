import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../../model/model.dart';
import '../model/patient_list_model.dart';

enum DoctorPatientListSortType {
  //
  criticalMetrics,
  fromNewest,
  fromOldest,

  //
}

class DoctorPatientListVm extends RbioVm {
  @override
  BuildContext mContext;
  PatientType? type;

  late PatientListModel listModel;

  DoctorPatientListVm(this.mContext, this.type) {
    fetchAll();
  }

  Future<void> fetchAll() async {
    try {
      progress = LoadingProgress.loading;
      listModel = await _getAllByType();
      progress = LoadingProgress.done;
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      log(e.toString());
      debugPrintStack(stackTrace: stackTrace);
      progress = LoadingProgress.error;
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
      case PatientType.bg:
        {
          return BgPatientListModel(
            mContext,
            await getIt<DoctorRepository>().getMySugarPatient(
              GetMyPatientFilter(
                skip: 0,
                take: 500,
              ),
            ),
          );
        }

      case PatientType.scale:
        {
          return ScalePatientListModel(
            mContext,
            await getIt<DoctorRepository>().getMyBMIPatient(
              GetMyPatientFilter(
                skip: 0,
                take: 500,
              ),
            ),
          );
        }

      case PatientType.bp:
        {
          return BpPatientListModel(
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
