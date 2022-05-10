import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../shared/necessary_identity/necessary_identity_screen.dart';
import '../results.dart';

class EResultScreenVm extends RbioVm {
  @override
  BuildContext mContext;

  late List<VisitResponse> visits;
  VisitRequest? _visitRequestBody;

  DateTime get startDate => _startDate != null
      ? DateTime(_startDate!.year, _startDate!.month, _startDate!.day)
      : DateTime(
          DateTime.now().year - 1, DateTime.now().month, DateTime.now().day);

  DateTime get endDate => _endDate != null
      ? DateTime(_endDate!.year, _endDate!.month, _endDate!.day, 23, 59, 59)
      : DateTime(
          DateTime.now().year + 1, DateTime.now().month, DateTime.now().day);

  DateTime? _startDate, _endDate;
  void setStartDate(DateTime d) {
    _startDate = d;
    fetchVisits();
    notifyListeners();
  }

  void setEndDate(DateTime d) {
    _endDate = d;
    fetchVisits();
    notifyListeners();
  }

  bool hasResult = true;
  void toggleHasResult() {
    hasResult = !hasResult;
    fetchVisits();
    notifyListeners();
  }

  EResultScreenVm(this.mContext) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      try {
        if (getIt<UserNotifier>().canAccessHospital()) {
          await fetchVisits();
        } else {
          await showNecessary();
        }
      } catch (e) {
        LoggerUtils.instance.wtf(e);
      }
    });
  }

  Future<void> showNecessary() async {
    final result = await Atom.show(
      const NecessaryIdentityScreen(),
      barrierDismissible: false,
    );

    if ((result ?? false) == true) {
      fetchVisits();
    } else {
      Atom.historyBack();
    }
  }

  VisitRequest get visitRequestBody =>
      _visitRequestBody ??
      VisitRequest(
          from: startDate.toString(),
          to: endDate.toString(),
          isForeignPatient:
              getIt<UserNotifier>().getPatient().nationalityId == 213
                  ? 0
                  : 1, // 213 - Türk
          hasResults: hasResult == false ? 0 : 1,
          identityNumber:
              getIt<UserNotifier>().getPatient().nationalityId == 213
                  ? getIt<UserNotifier>().getPatient().identityNumber
                  : getIt<UserNotifier>().getPatient().passportNumber);

  Future<void> fetchVisits() async {
    progress = LoadingProgress.loading;
    notifyListeners();
    try {
      visits = await getIt<Repository>().getVisits(visitRequestBody);
      visits.sort((a, b) {
        final aOpeningDate = a.openingDate;
        final bOpeningDate = b.openingDate;

        if (aOpeningDate != null && bOpeningDate != null) {
          return DateTime.parse(bOpeningDate).compareTo(
            DateTime.parse(aOpeningDate),
          );
        }

        return -1;
      });

      progress = LoadingProgress.done;
      notifyListeners();
    } catch (e) {
      progress = LoadingProgress.error;
      showInfoDialog(
        LocaleProvider.current.warning,
        LocaleProvider.current.sorry_dont_transaction,
      );
      notifyListeners();
    }
  }
}
