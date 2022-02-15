import 'package:flutter/material.dart';

import '../core.dart';

abstract class RbioVm extends ChangeNotifier {
  BuildContext get mContext;

  LoadingProgress? _progress;
  LoadingProgress? get progress => _progress;
  set progress(LoadingProgress? value) {
    _progress = value;
    notifyListeners();
  }

  void showDefaultErrorDialog(
    dynamic throwable,
    dynamic stackTrace, [
    String? title,
    String? description,
  ]) {
    showGradientDialog(
      title ?? LocaleProvider.current.warning,
      description ?? LocaleProvider.current.sorry_dont_transaction,
      false,
    );
  }

  void showDelayedErrorDialog(
    dynamic throwable,
    dynamic stackTrace, [
    VoidCallback? voidCallback,
    String? title,
    String? description,
  ]) {
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        if (voidCallback != null) {
          voidCallback();
        }
        showInfoDialog(
          title ?? LocaleProvider.of(mContext).warning,
          description ?? LocaleProvider.of(mContext).sorry_dont_transaction,
        );
      },
    );
  }

  void showGradientDialog(
    String title,
    String text,
    bool closeAfter,
  ) {
    showDialog(
      context: mContext,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return WarningDialog(title, text);
      },
    ).then(
      (value) async {
        if (closeAfter) {
          Atom.to(PagePaths.main, isReplacement: true);
        }
      },
    );
  }

  void showInfoDialog(String title, String text, [BuildContext? context]) {
    showDialog(
      context: context ?? mContext,
      barrierDismissible: true,
      builder: (BuildContext context) => WarningDialog(title, text),
    );
  }
}
