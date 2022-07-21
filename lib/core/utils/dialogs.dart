import 'dart:io';

import 'package:flutter/material.dart';

import '../../features/shared/do_not_show_again_dialog.dart';
import '../core.dart';

Future<void> showOptionalUpdateDialog({
  required Function()? onPressed,
  context,
  String? message,
}) async {
  await showDialog<String>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      String title = LocaleProvider.of(context).app_update_available;
      String btnLabel = LocaleProvider.of(context).update_now;
      String btnLabelCancel = LocaleProvider.of(context).later;
      String btnLabelDontAskAgain = LocaleProvider.of(context).dont_ask_again;

      return DoNotAskAgainDialog(
        title: title,
        subTitle: message ?? "No message",
        positiveButtonText: btnLabel,
        negativeButtonText: btnLabelCancel,
        onPositiveButtonClicked: onPressed,
        doNotAskAgainText: Platform.isIOS
            ? btnLabelDontAskAgain
            : LocaleProvider.of(context).never_ask_again,
      );
    },
  );
}

Future<void> showCompulsoryUpdateDialog({
  required VoidCallback onPressed,
  required BuildContext context,
  required String message,
}) async {
  await showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return RbioBaseGreyDialog(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              Center(
                child: Text(
                  LocaleProvider.current.app_update_available,
                  style: getIt<IAppConfig>().theme.dialogTheme.title(context),
                  textAlign: TextAlign.center,
                ),
              ),

              //
              R.widgets.hSizer32,

              //
              Center(
                child: Text(
                  LocaleProvider.current.force_update_message,
                  style: getIt<IAppConfig>()
                      .theme
                      .dialogTheme
                      .description(context),
                  textAlign: TextAlign.center,
                ),
              ),

              //
              R.widgets.hSizer32,

              //
              Center(
                child: RbioSmallDialogButton.main(
                  context: context,
                  title: LocaleProvider.current.update_now,
                  onPressed: onPressed,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void showConfirmationAlertDialog(
  BuildContext context,
  String title,
  String text,
  Widget okButton,
) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return GuvenAlert(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        actions: [
          okButton,
        ],
        content: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                text,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Roboto',
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
