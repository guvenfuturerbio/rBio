import 'package:flutter/material.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../model/call_rate_request.dart';
import '../model/get_availability_rate_request.dart';
import '../model/get_availability_rate_response.dart';

class RateDialogVm extends ChangeNotifier {
  BuildContext? mContext;
  int? availabilityIdVm;
  int videoQuality = 3;
  int doctorQuality = 3;
  bool? showLoadingOverLay;
  LoadingDialog? loadingDialog;

  bool firstLoad = false;
  GetAvailabilityRateResponse? getAvailabilityRateResponse;

  RateDialogVm({required BuildContext context, required int availabilityId}) {
    mContext = context;
    availabilityIdVm = availabilityId;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await fetchAvailabilityRate(availabilityId);
    });
  }

  Future<void> fetchAvailabilityRate(int availabilityId) async {
    showLoadingDialog(mContext!);
    try {
      getAvailabilityRateResponse =
          await getIt<Repository>().getAvailabilityRate(
        GetAvailabilityRateRequest(availabilityId: availabilityId),
      );
      firstLoad = true;
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

  void setVideoQuality(int value) {
    videoQuality = value;
    notifyListeners();
  }

  void setDoctorQuality(int value) {
    doctorQuality = value;
    notifyListeners();
  }

  Future<void> rateAppointment(String comment) async {
    showLoadingDialog(mContext!);
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      await getIt<Repository>().rateOnlineCall(
        CallRateRequest(
          availabilityId: availabilityIdVm,
          suggestionAndRequest: comment,
          doctorRate: doctorQuality,
          videoConferanceRate: videoQuality,
        ),
      );
      hideDialog(mContext!);
      showGradientDialog(
        LocaleProvider.current.info,
        LocaleProvider.current.suggestion_thanks_message,
      );
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      hideDialog(mContext!);
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
      },
    ).then((value) {
      // Atom.to(PagePaths.main, isReplacement: true);
      Navigator.pop(mContext!);
    });
  }

  void showLoadingDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) =>
          loadingDialog = loadingDialog ?? LoadingDialog(),
    );
  }

  void hideDialog(BuildContext context) {
    if (loadingDialog != null && loadingDialog!.isShowing()) {
      Navigator.of(context).pop();
      loadingDialog = null;
    }
  }
}
