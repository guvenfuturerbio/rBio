import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onedosehealth/generated/l10n.dart';
import 'package:onedosehealth/helper/resources.dart';
import 'package:onedosehealth/types/unit.dart';

class StripGradientDialog extends StatefulWidget {
  StripGradientDialog(this.title, this.callback);
  final String title;
  final Function(int) callback;
  @override
  State<StatefulWidget> createState() {
    return new _StripGradientDialogState();
  }
}

class _StripGradientDialogState extends State<StripGradientDialog> {
  TextEditingController stripController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Widget okButton = FlatButton(
      child: Text(LocaleProvider.current.Ok),
      textColor: R.color.black,
      onPressed: () {
        widget.callback(int.parse(stripController.text));
        Navigator.of(context).pop();
      },
    );

    return AlertDialog(
      backgroundColor: R.color.bg_gray,
      title: Text(
        widget.title,
        style: TextStyle(
            fontSize: 32, fontWeight: FontWeight.w700, color: R.color.black),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      actions: [
        okButton,
      ],
      content: Container(
        padding: const EdgeInsets.all(16.0),
        child: new Column(
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
                          left: 15, bottom: 11, top: 11, right: 15),
                      hintText: "Strip number"),
                ),
              ),
            ),
          ],
        ),
      ),
      contentPadding: EdgeInsets.all(0.0),
    );
  }
}
