import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../core/core.dart';

class StripGradientDialog extends StatefulWidget {
  final String title;
  final void Function(int) callback;

  const StripGradientDialog({
    Key? key,
    required this.title,
    required this.callback,
  }) : super(key: key);

  @override
  _StripGradientDialogState createState() => _StripGradientDialogState();
}

class _StripGradientDialogState extends State<StripGradientDialog> {
  late TextEditingController stripController;

  @override
  void initState() {
    stripController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    stripController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget okButton = TextButton(
      child: Text(LocaleProvider.current.Ok),
      style: TextButton.styleFrom(
        textStyle: context.xHeadline3.copyWith(
          color: getIt<ITheme>().textColorSecondary,
        ),
      ),
      onPressed: () {
        widget.callback(int.parse(stripController.text));
        Navigator.of(context).pop();
      },
    );

    return AlertDialog(
      backgroundColor: getIt<ITheme>().grey,
      contentPadding: const EdgeInsets.all(0.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      title: Text(
        widget.title,
        style: context.xHeadline1.copyWith(
            color: getIt<ITheme>().textColorSecondary,
            fontWeight: FontWeight.w700),
      ),
      content: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Material(
              elevation: 15,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: SizedBox(
                width: 350,
                child: TextField(
                  controller: stripController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  cursorColor: Colors.black,
                  textAlign: TextAlign.center,
                  maxLength: 3,
                  obscureText: false,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    counterText: "",
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                      left: 15,
                      bottom: 11,
                      top: 11,
                      right: 15,
                    ),
                    hintText: "Strip number",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        okButton,
      ],
    );
  }
}
