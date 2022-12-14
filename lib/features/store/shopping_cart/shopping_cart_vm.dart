import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class ShoppingCartScreenVm extends ChangeNotifier {
  ShoppingCartScreenVm(BuildContext context) {
    mContext = context;
  }

  BuildContext? mContext;

  LoadingProgress? progress;

  getCartItems() async {
    try {
      progress = LoadingProgress.loading;
      notifyListeners();
      progress = LoadingProgress.done;
      notifyListeners();
    } catch (e) {
      progress = LoadingProgress.error;
      showGradientDialog(mContext!, LocaleProvider.current.warning,
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
