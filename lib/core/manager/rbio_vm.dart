import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../core.dart';

abstract class RbioVm {
  BuildContext get mContext;

  void showDefaultErrorDialog(dynamic throwable, dynamic stackTrace) {
    Sentry.captureException(throwable, stackTrace: stackTrace);
    showGradientDialog(
      LocaleProvider.current.warning,
      LocaleProvider.current.sorry_dont_transaction,
      false,
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
          Atom.to(PagePaths.MAIN, isReplacement: true);
        }
      },
    );
  }
}
