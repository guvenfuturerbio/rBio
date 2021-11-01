import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../shared/necessary_identity/necessary_identity_screen.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';

class EResultScreenVm extends ChangeNotifier {
  LoadingProgress _progress;
  BuildContext mContext;
  List<VisitResponse> _visits;
  VisitRequest _visitRequestBody;
  DateTime _startDate, _endDate;
  bool _hasResult;

  EResultScreenVm({BuildContext context}) {
    this.mContext = context;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (getIt<UserInfo>().canAccessHospital()) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          await fetchVisits();
        });
      } else {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          await showNecessary();
        });
      }
    });
  }

  showNecessary() async {
    await showDialog(
      context: mContext,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return NecessaryIdentityScreen();
      },
    ).then((value) async {
      if ((value ?? false) == true) {
        fetchVisits();
      } else {
        Navigator.of(mContext).pop();
      }
    });
  }

  setVisitRequestBody({
    String from,
    String to,
    int hasResult,
    int isForeignPatient,
    String identityNumber,
  }) {
    this._visitRequestBody = VisitRequest(
      from: from,
      hasResults: hasResult,
      identityNumber: identityNumber,
      isForeignPatient: isForeignPatient,
      to: to,
    );
    notifyListeners();
  }

  DateTime get startDate => _startDate != null
      ? DateTime(_startDate.year, _startDate.month, _startDate.day)
      : DateTime(
          DateTime.now().year - 1, DateTime.now().month, DateTime.now().day);

  void setStartDate(DateTime d) {
    this._startDate = d;
    fetchVisits();
    notifyListeners();
  }

  DateTime get endDate => _endDate != null
      ? DateTime(_endDate.year, _endDate.month, _endDate.day, 23, 59, 59)
      : DateTime(
          DateTime.now().year + 1, DateTime.now().month, DateTime.now().day);

  void setEndDate(DateTime d) {
    this._endDate = d;
    fetchVisits();
    notifyListeners();
  }

  bool get hasResult => this._hasResult ?? true;

  toggleHasResult() {
    this._hasResult = !hasResult;
    fetchVisits();
    notifyListeners();
  }

  VisitRequest get visitRequestBody =>
      this._visitRequestBody ??
      VisitRequest(
          from: startDate.toString(),
          to: endDate.toString(),
          isForeignPatient: PatientSingleton().getPatient().nationalityId == 213
              ? 0
              : 1, // 213 - Türk
          hasResults: hasResult == false ? 0 : 1,
          identityNumber: PatientSingleton().getPatient().nationalityId == 213
              ? PatientSingleton().getPatient().identityNumber
              : PatientSingleton().getPatient().passportNumber);

  LoadingProgress get progress => this._progress ?? LoadingProgress.LOADING;

  Future<void> fetchVisits() async {
    this._progress = LoadingProgress.LOADING;
    notifyListeners();
    try {
      this._visits = await getIt<Repository>().getVisits(visitRequestBody);
      _visits.sort((a, b) => DateTime.parse(b.openingDate)
          .compareTo(DateTime.parse(a.openingDate)));
      this._progress = LoadingProgress.DONE;
      notifyListeners();
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      print("getVisits exception" + e.toString());
      showGradientDialog(mContext, LocaleProvider.current.warning,
          LocaleProvider.current.sorry_dont_transaction);
      this._progress = LoadingProgress.ERROR;
      notifyListeners();
    }
  }

  List<VisitResponse> get visits => this._visits;

  void showGradientDialog(BuildContext context, String title, String text) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return WarningDialog(title, text);
      },
    );
  }
}
