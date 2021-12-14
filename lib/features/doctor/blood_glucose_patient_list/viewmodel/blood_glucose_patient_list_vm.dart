import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../core/core.dart';
import '../../../../core/data/repository/doctor_repository.dart';
import '../../../../model/model.dart';

enum DoctorPatientListSortType {
  criticalMetrics,
  fromNewest,
  fromOldest,
}

class BloodGlucosePatientListVm extends ChangeNotifier with RbioVm {
  @override
  BuildContext mContext;

  List<DoctorPatientModel> _patientList = [];
  List<DoctorPatientModel> filterList = [];

  BloodGlucosePatientListVm(this.mContext) {
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
      _patientList = await getIt<DoctorRepository>().getMySugarPatient(
        GetMyPatientFilter(
          end: DateTime.now().subtract(Duration(days: 30)).toIso8601String(),
          start: DateTime.now().toIso8601String(),
          skip: 0,
          take: 500,
        ),
      );
      filterList = _patientList;
      progress = LoadingProgress.DONE;
    } catch (e, stackTrace) {
      progress = LoadingProgress.ERROR;
      Sentry.captureException(e, stackTrace: stackTrace);
      showGradientDialog(
        LocaleProvider.current.warning,
        LocaleProvider.current.sorry_dont_transaction,
        true,
      );
    }
  }

  void textOnChanged(String text) {
    if (text == null || text == '') {
      filterList = _patientList;
      notifyListeners();
    } else {
      filterList = _patientList
          .where((item) => item.name.toLowerCase().contains(text.toLowerCase()))
          .toList();
      notifyListeners();
    }
  }

  void sortList(DoctorPatientListSortType type) {
    switch (type) {
      case DoctorPatientListSortType.criticalMetrics:
        filterList = filterList.sortedBy((it) => it.name);
        break;

      case DoctorPatientListSortType.fromNewest:
        filterList = filterList.sortedBy((it) => it.normalMin);
        break;

      case DoctorPatientListSortType.fromOldest:
        filterList = filterList.sortedBy((it) => it.normalMax);
        break;
    }

    notifyListeners();
  }
}

extension MyIterable<E> on Iterable<E> {
  Iterable<E> sortedBy(Comparable key(E e)) =>
      toList()..sort((a, b) => key(a).compareTo(key(b)));
}
