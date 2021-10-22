import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../model/model.dart';

class RateDialogVm extends ChangeNotifier {
  BuildContext mContext;
  int _availabilityId;
  int _videoQuality;
  int _doctorQuality;
  bool _showLoadingOverLay;
  LoadingDialog loadingDialog;
  GetAvailabilityRateResponse _getAvailabilityRateResponse;

  RateDialogVm({BuildContext context, int availabilityId}) {
    this.mContext = context;
    this._availabilityId = availabilityId;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await fetchAvailabilityRate(availabilityId);
    });
  }

  fetchAvailabilityRate(int availabilityId) async {
    showLoadingDialog(mContext);
    try {
      this._getAvailabilityRateResponse = await getIt<Repository>()
          .getAvailabilityRate(
              GetAvailabilityRateRequest(availabilityId: availabilityId));
      notifyListeners();
      hideDialog(mContext);
    } catch (e) {
      hideDialog(mContext);
    }
  }

  setVideoQuality(int value) {
    this._videoQuality = value;
    notifyListeners();
  }

  setDoctorQuality(int value) {
    this._doctorQuality = value;
    notifyListeners();
  }

  int get videoQuality => this._videoQuality ?? 1;

  int get doctorQuality => this._doctorQuality ?? 1;

  bool get showLoadingOverlay => this._showLoadingOverLay ?? false;

  int get availabilityId => this._availabilityId;

  GetAvailabilityRateResponse get getAvailabilityRateResponse =>
      this._getAvailabilityRateResponse;

  Future rateAppointment(String comment) async {
    showLoadingDialog(mContext);
    await Future.delayed(Duration(milliseconds: 300));
    try {
      await getIt<Repository>().rateOnlineCall(CallRateRequest(
          availabilityId: availabilityId,
          suggestionAndRequest: comment,
          doctorRate: doctorQuality,
          videoConferanceRate: videoQuality));
      hideDialog(mContext);
      showGradientDialog(LocaleProvider.current.info,
          LocaleProvider.current.suggestion_thanks_message);
    } catch (e) {
      hideDialog(mContext);
      print("rateAppointment Error " + e.toString());
      Navigator.pop(mContext);
      this._showLoadingOverLay = false;
      notifyListeners();
    }
  }

  showGradientDialog(String title, String text) {
    showDialog(
        context: mContext,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return GradientDialog(title, text);
        }).then((value) {
      Navigator.pop(mContext);
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
    if (loadingDialog != null && loadingDialog.isShowing()) {
      Navigator.of(context).pop();
      loadingDialog = null;
    }
  }
}
