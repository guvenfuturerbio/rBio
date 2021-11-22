import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../common/mediminder_common.dart';

class StripGradientDialog extends StatefulWidget {
  final String title;
  final Function(int) callback;

  StripGradientDialog(
    this.title,
    this.callback,
  );

  @override
  _StripGradientDialogState createState() => _StripGradientDialogState();
}

class _StripGradientDialogState extends State<StripGradientDialog> {
  TextEditingController stripController;

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
    Widget okButton = FlatButton(
      child: Text(LocaleProvider.current.Ok),
      textColor: Mediminder.instance.black,
      onPressed: () {
        widget.callback(int.parse(stripController.text));
        Navigator.of(context).pop();
      },
    );

    return AlertDialog(
      backgroundColor: Mediminder.instance.bg_gray,
      contentPadding: EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      title: Text(
        widget.title,
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: Mediminder.instance.black,
        ),
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
              child: Container(
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
                  decoration: new InputDecoration(
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
