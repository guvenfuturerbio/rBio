import 'package:flutter/material.dart';

import '../core.dart';

class RbioMessageDialog extends StatelessWidget {
  final String description;
  final String? buttonTitle;
  final bool? isAtom;

  const RbioMessageDialog({
    Key? key,
    required this.description,
    this.buttonTitle,
    this.isAtom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: getIt<IAppConfig>().theme.dialogTheme.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: R.sizes.borderRadiusCircular,
      ),
      child: Container(
        width: context.width - 50,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            Text(
              LocaleProvider.current.warning,
              style: getIt<IAppConfig>().theme.dialogTheme.title(context),
            ),

            //
            R.sizes.hSizer32,

            //
            Text(
              description,
              textAlign: TextAlign.center,
              style: getIt<IAppConfig>().theme.dialogTheme.description(context),
            ),

            //
            R.sizes.hSizer32,

            //
            RbioSmallDialogButton.green(
              title: buttonTitle ?? LocaleProvider.current.Ok,
              onPressed: () {
                if (isAtom == true) {
                  Atom.dismiss();
                } else {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class RbioSmallDialogButton extends StatelessWidget {
  final Color? backgroundColor;
  final Color? textColor;
  final String? title;
  final void Function()? onPressed;

  const RbioSmallDialogButton({
    Key? key,
    this.backgroundColor,
    this.textColor,
    this.title,
    this.onPressed,
  }) : super(key: key);

  factory RbioSmallDialogButton.green({
    required String? title,
    required void Function()? onPressed,
  }) {
    return RbioSmallDialogButton(
      backgroundColor: getIt<IAppConfig>().theme.mainColor,
      textColor: getIt<IAppConfig>().theme.textColor,
      title: title,
      onPressed: onPressed,
    );
  }

  factory RbioSmallDialogButton.red({
    required String? title,
    required void Function()? onPressed,
  }) {
    return RbioSmallDialogButton(
      backgroundColor: getIt<IAppConfig>().theme.darkRed,
      textColor: getIt<IAppConfig>().theme.textColor,
      title: title,
      onPressed: onPressed,
    );
  }

  factory RbioSmallDialogButton.white({
    required String? title,
    required void Function()? onPressed,
  }) {
    return RbioSmallDialogButton(
      backgroundColor: getIt<IAppConfig>().theme.cardBackgroundColor,
      textColor: getIt<IAppConfig>().theme.textColorSecondary,
      title: title,
      onPressed: onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return RbioTextButton(
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(borderRadius: R.sizes.borderRadiusCircular),
      padding: const EdgeInsets.symmetric(
        horizontal: 35,
        vertical: 5,
      ),
      child: Text(
        title ?? '',
        textAlign: TextAlign.left,
        style: context.xHeadline4.copyWith(
          color: textColor ?? getIt<IAppConfig>().theme.textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
