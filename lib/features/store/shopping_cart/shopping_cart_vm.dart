import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class ShoppingCartScreenVm extends ChangeNotifier {
  ShoppingCartScreenVm(BuildContext context) {
    this.mContext = context;
  }

  BuildContext mContext;

  LoadingProgress _progress;

  LoadingProgress get progress => this._progress;

  getCartItems() async {
    try {
      this._progress = LoadingProgress.LOADING;
      notifyListeners();
      this._progress = LoadingProgress.DONE;
      notifyListeners();
    } catch (e) {
      this._progress = LoadingProgress.ERROR;
      showGradientDialog(mContext, LocaleProvider.current.warning,
          LocaleProvider.current.sorry_dont_transaction);
      notifyListeners();
    }
  }

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
