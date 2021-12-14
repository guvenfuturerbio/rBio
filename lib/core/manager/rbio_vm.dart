import 'package:flutter/material.dart';

import '../core.dart';

abstract class RbioVm {
  BuildContext mContext;
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
