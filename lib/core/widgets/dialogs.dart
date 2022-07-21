import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../core.dart';

class ProgressDialog extends StatefulWidget {
  static late _ProgressDialogState state;

  const ProgressDialog({Key? key}) : super(key: key);

  bool isShowing() {
    return state.mounted;
  }

  @override
  _ProgressDialogState createState() => state = _ProgressDialogState();
}

class _ProgressDialogState extends State<ProgressDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.all(10),
      content: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: 150,
            height: 150,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: R.sizes.borderRadiusCircular,
              gradient: blueGradient(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                progress(),
                JumpingText((LocaleProvider.current.loading))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget progress({
    Key? key,
    double? value,
    Color? backgroundColor,
    Animation? valueColor,
    String? semanticsLabel,
    String? semanticsValue,
  }) =>
      ShakeAnimatedWidget(
        enabled: true,
        duration: const Duration(milliseconds: 1500),
        shakeAngle: Rotation.deg(z: 10),
        curve: Curves.linear,
        child: SizedBox(
          width: 80,
          height: 80,
          child: SvgPicture.asset(R.image.stethoscope),
        ),
      );

  Gradient blueGradient() => const LinearGradient(
        colors: [
          Colors.black12,
          Colors.black12,
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.centerRight,
      );
}

class GradientDialog extends StatefulWidget {
  final String? title;
  final String? text;

  const GradientDialog({Key? key, required this.title, required this.text})
      : super(key: key);

  @override
  _GradientDialogState createState() => _GradientDialogState();
}

class _GradientDialogState extends State<GradientDialog> {
  @override
  Widget build(BuildContext context) {
    Widget okButton = TextButton(
      style: TextButton.styleFrom(primary: getIt<IAppConfig>().theme.textColor),
      child: Text(LocaleProvider.current.ok),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    return AlertDialog(
      backgroundColor: context.xPrimaryColor,
      contentPadding: EdgeInsets.zero,
      title: Text(
        widget.title ?? '',
        style: context.xHeadline1.copyWith(
            fontWeight: FontWeight.w700,
            color: getIt<IAppConfig>().theme.textColor),
      ),
      shape: R.sizes.defaultShape,
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
              widget.text ?? '',
              style: context.xHeadline3.copyWith(
                color: getIt<IAppConfig>().theme.textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
