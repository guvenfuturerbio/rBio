import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../model/model.dart';

class RateDialogVm extends ChangeNotifier {
  BuildContext? mContext;
  int? availabilityIdVm;
  int? videoQuality;
  int? doctorQuality;
  bool? showLoadingOverLay;
  LoadingDialog? loadingDialog;
  GetAvailabilityRateResponse? getAvailabilityRateResponse;

  RateDialogVm({required BuildContext context, required int availabilityId}) {
    mContext = context;
    availabilityIdVm = availabilityId;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await fetchAvailabilityRate(availabilityId);
    });
  }

  fetchAvailabilityRate(int availabilityId) async {
    showLoadingDialog(mContext!);
    try {
      getAvailabilityRateResponse = await getIt<Repository>()
          .getAvailabilityRate(
              GetAvailabilityRateRequest(availabilityId: availabilityId));
      notifyListeners();
      hideDialog(mContext!);
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      hideDialog(mContext!);
    }
  }

  setVideoQuality(int value) {
    videoQuality = value;
    notifyListeners();
  }

  setDoctorQuality(int value) {
    doctorQuality = value;
    notifyListeners();
  }

/*
  int get videoQuality => _videoQuality;

  int get doctorQuality => _doctorQuality;

  bool get showLoadingOverlay => _showLoadingOverLay;

  int get availabilityId => _availabilityId;

  GetAvailabilityRateResponse get getAvailabilityRateResponse =>
      _getAvailabilityRateResponse;

*/
  Future rateAppointment(String comment) async {
    showLoadingDialog(mContext!);
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      await getIt<Repository>().rateOnlineCall(CallRateRequest(
          availabilityId: availabilityIdVm,
          suggestionAndRequest: comment,
          doctorRate: doctorQuality,
          videoConferanceRate: videoQuality));
      hideDialog(mContext!);
      showGradientDialog(LocaleProvider.current.info,
          LocaleProvider.current.suggestion_thanks_message);
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      hideDialog(mContext!);
      LoggerUtils.instance.i("rateAppointment Error " + e.toString());
      Navigator.pop(mContext!);
      showLoadingOverLay = false;
      notifyListeners();
    }
  }

  void showGradientDialog(String title, String text) {
    showDialog(
        context: mContext!,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return RbioMessageDialog(
            description: text,
            buttonTitle: LocaleProvider.current.ok,
            isAtom: false,
          );
        }).then((value) {
      Atom.to(PagePaths.main, isReplacement: true);
    });
  }

  void showLoadingDialog(BuildContext context) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) =>
            loadingDialog = loadingDialog ?? LoadingDialog());
  }

  void hideDialog(BuildContext context) {
    if (loadingDialog != null && loadingDialog!.isShowing()) {
      Navigator.of(context).pop();
      loadingDialog = null;
    }
  }
}
