import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../core/core.dart';
import '../../../../core/data/repository/doctor_repository.dart';
import '../../../../model/model.dart';

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

  List _patientList = [];
  List filterList = [];

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
      switch (type) {
        case PatientType.BloodGlucose:
          {
            _patientList = await getIt<DoctorRepository>().getMySugarPatient(
              GetMyPatientFilter(
                skip: 0,
                take: 500,
              ),
            );

            break;
          }

        case PatientType.Weight:
          {
            _patientList = await getIt<DoctorRepository>().getMyBMIPatient(
              GetMyPatientFilter(
                skip: 0,
                take: 500,
              ),
            );

            break;
          }

        case PatientType.BloodPressure:
          {
            break;
          }
      }

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

  void sortList(DoctorPatientListSortType sortType) {
    switch (type) {
      case PatientType.BloodGlucose:
        {
          switch (sortType) {
            case DoctorPatientListSortType.criticalMetrics:
              filterList = _patientList
                  .sortedBy((it) => (it as DoctorGlucosePatientModel).name);
              break;

            case DoctorPatientListSortType.fromNewest:
              filterList = _patientList.sortedBy(
                  (it) => (it as DoctorGlucosePatientModel).normalMin);
              break;

            case DoctorPatientListSortType.fromOldest:
              filterList = _patientList.sortedBy(
                  (it) => (it as DoctorGlucosePatientModel).normalMax);
              break;
          }

          break;
        }

      case PatientType.Weight:
        {
          switch (sortType) {
            case DoctorPatientListSortType.fromNewest:
              filterList = _patientList.sortedBy((it) =>
                  (it as DoctorBMIPatientModel)
                      .bmiMeasurements
                      .first
                      .occurrenceTime);
              break;

            case DoctorPatientListSortType.fromOldest:
              filterList = _patientList.sortedBy((it) =>
                  (it as DoctorBMIPatientModel).bmiMeasurements.first.weight);
              break;

            default:
              break;
          }

          break;
        }

      case PatientType.BloodPressure:
        // TODO: Handle this case.
        break;
    }

    notifyListeners();
  }

  List<Widget> getFilterPopupList(
    DoctorPatientListVm vm,
    BuildContext _context,
  ) {
    switch (vm.type) {
      case PatientType.BloodGlucose:
        return [
          GestureDetector(
            child: Container(
              color: getIt<ITheme>().scaffoldBackgroundColor,
              padding: EdgeInsets.all(12),
              child: Text(
                LocaleProvider.of(_context).critical_metrics,
                style: _context.xHeadline4.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            onTap: () {
              Navigator.of(_context).pop();
              vm.sortList(DoctorPatientListSortType.criticalMetrics);
            },
          ),
          GestureDetector(
            child: Container(
              color: getIt<ITheme>().scaffoldBackgroundColor,
              padding: EdgeInsets.all(12),
              child: Text(
                LocaleProvider.of(_context).from_newest,
                style: _context.xHeadline4.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            onTap: () {
              Navigator.of(_context).pop();
              vm.sortList(DoctorPatientListSortType.fromNewest);
            },
          ),
          GestureDetector(
            child: Container(
              color: getIt<ITheme>().scaffoldBackgroundColor,
              padding: EdgeInsets.all(12),
              child: Text(
                LocaleProvider.of(_context).from_oldest,
                style: _context.xHeadline4.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            onTap: () {
              Navigator.of(_context).pop();
              vm.sortList(DoctorPatientListSortType.fromOldest);
            },
          ),
        ];

      case PatientType.Weight:
        return [
          GestureDetector(
            child: Container(
              color: getIt<ITheme>().scaffoldBackgroundColor,
              padding: EdgeInsets.all(12),
              child: Text(
                LocaleProvider.of(_context).from_newest,
                style: _context.xHeadline4.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            onTap: () {
              Navigator.of(_context).pop();
              vm.sortList(DoctorPatientListSortType.fromNewest);
            },
          ),
          GestureDetector(
            child: Container(
              color: getIt<ITheme>().scaffoldBackgroundColor,
              padding: EdgeInsets.all(12),
              child: Text(
                LocaleProvider.of(_context).from_oldest,
                style: _context.xHeadline4.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            onTap: () {
              Navigator.of(_context).pop();
              vm.sortList(DoctorPatientListSortType.fromOldest);
            },
          ),
        ];

      case PatientType.BloodPressure:
        return [];

      default:
        return [];
    }
  }
}

extension MyIterable<E> on Iterable<E> {
  Iterable<E> sortedBy(Comparable key(E e)) =>
      toList()..sort((a, b) => key(a).compareTo(key(b)));
}
