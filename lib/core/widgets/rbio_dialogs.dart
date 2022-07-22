import 'package:flutter/material.dart';

import '../core.dart';

class RbioBaseDialog extends StatelessWidget {
  final Widget child;

  const RbioBaseDialog({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor:
          getIt<IAppConfig>().theme.dialogTheme.backgroundColor(context),
      shape: R.sizes.defaultShape,
      child: Container(
        width: context.width > 500 ? 500 : context.width - 50,
        padding: const EdgeInsets.all(20),
        child: child,
      ),
    );
  }

  static Widget verticalGap() => R.widgets.hSizer32;
}

class RbioBaseGreyDialog extends StatelessWidget {
  final Widget child;

  const RbioBaseGreyDialog({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor:
          getIt<IAppConfig>().theme.dialogTheme.backgroundColor(context),
      shape: R.sizes.defaultShape,
      child: Container(
        width: context.width > 500 ? 500 : context.width - 50,
        padding: const EdgeInsets.all(20),
        child: child,
      ),
    );
  }

  static Widget verticalGap() => R.widgets.hSizer32;
}

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
    return RbioBaseGreyDialog(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          Text(
            LocaleProvider.current.warning,
            style: getIt<IAppConfig>().theme.dialogTheme.title(context),
          ),

          //
          RbioBaseDialog.verticalGap(),

          //
          _buildContainer(context, description),

          //
          RbioBaseDialog.verticalGap(),

          //
          RbioSmallDialogButton.main(
            context: context,
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
    );
  }

  Widget _buildContainer(BuildContext context, String description) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final TextSpan _textSpan = TextSpan(
          text: description,
          style: getIt<IAppConfig>().theme.dialogTheme.description(context),
        );

        final TextPainter _textPainter = TextPainter(
          text: _textSpan,
          textDirection: TextDirection.ltr,
          maxLines: 10,
        );

        _textPainter.layout(
          maxWidth: (context.width > 500 ? 500 : context.width - 50) - 40,
        );

        if (_textPainter.didExceedMaxLines) {
          return SizedBox(
            height: 0.35 * context.height,
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: getIt<IAppConfig>()
                          .theme
                          .dialogTheme
                          .description(context),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                description,
                textAlign: TextAlign.center,
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
                style:
                    getIt<IAppConfig>().theme.dialogTheme.description(context),
              ),
            ],
          );
        }
      },
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

  factory RbioSmallDialogButton.main({
    required BuildContext context,
    required String? title,
    required void Function()? onPressed,
  }) {
    return RbioSmallDialogButton(
      backgroundColor: context.xPrimaryColor,
      textColor: getIt<IAppConfig>().theme.white,
      title: title,
      onPressed: onPressed,
    );
  }

  factory RbioSmallDialogButton.red(
    BuildContext context, {
    required String? title,
    required void Function()? onPressed,
  }) {
    return RbioSmallDialogButton(
      backgroundColor: context.xAppColors.punch,
      textColor: getIt<IAppConfig>().theme.white,
      title: title,
      onPressed: onPressed,
    );
  }

  factory RbioSmallDialogButton.white(
    BuildContext context, {
    required String? title,
    required void Function()? onPressed,
  }) {
    return RbioSmallDialogButton(
      backgroundColor: context.xCardColor,
      textColor: context.xTextInverseColor,
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
      shape: R.sizes.defaultShape,
      padding: const EdgeInsets.symmetric(
        horizontal: 35,
        vertical: 5,
      ),
      child: Text(
        title ?? '',
        textAlign: TextAlign.left,
        style: context.xHeadline4.copyWith(
          color: textColor ?? context.xTextColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
