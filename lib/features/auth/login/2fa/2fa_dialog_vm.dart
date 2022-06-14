// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../../../core/core.dart';

enum TwoFaStates {
  idle,
  loading,
}

class TwoFaVm extends ChangeNotifier {
  BuildContext context;
  TwoFaVm(this.context);

  TwoFaStates progress = TwoFaStates.idle;

  bool resendButtonEnabled = false;

  Future<void> verifyCode(String smsCode, int userId) async {
    if (progress == TwoFaStates.loading) return;
    progress = TwoFaStates.loading;
    resendButtonEnabled = false;
    notifyListeners();
    try {
      final response =
          await getIt<Repository>().verifyConfirmation2fa(smsCode, userId);
      if (response.datum == true && response.isSuccessful == true) {
        // İşlem Başarılı
        Navigator.of(context).pop(true);
      } else {
        // İşlem Başarısız
        resendButtonEnabled = true;
        notifyListeners();
      }
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return RbioMessageDialog(
            description: LocaleProvider.current.wrong_username_password,
            isAtom: false,
          );
        },
      );
    } finally {
      progress = TwoFaStates.idle;
      notifyListeners();
    }
  }

  Future<void> resendCode() async {
    Navigator.of(context).pop(false);
  }
}
