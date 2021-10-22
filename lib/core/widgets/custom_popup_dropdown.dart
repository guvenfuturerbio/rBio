import 'package:flutter/material.dart';

import '../../model/model.dart';
import '../core.dart';

class CustomPopUpDropDown extends StatefulWidget {
  final List<TranslatorResponse> translators;
  final String title;
  final ValueChanged<int> onChange;

  const CustomPopUpDropDown({
    Key key,
    this.title,
    this.onChange,
    this.translators,
  });

  @override
  _CustomPopUpDropDownState createState() => _CustomPopUpDropDownState();
}

class _CustomPopUpDropDownState extends State<CustomPopUpDropDown> {
  @override
  Widget build(BuildContext context) {
    Widget okButton = FlatButton(
      child: Text(LocaleProvider.of(context).btn_cancel.toUpperCase()),
      textColor: Colors.white,
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    return GuvenAlert(
      backgroundColor: R.color.online_appointment,
      title: Text(
        widget.title,
        style: TextStyle(
            fontSize: 32, fontWeight: FontWeight.w700, color: Colors.white),
        textAlign: TextAlign.center,
      ),
      actions: [
        okButton,
      ],
      content: Container(
        margin: EdgeInsets.all(30),
        height: 200,
        decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(50), gradient: BlueGradient()),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(widget.translators.length, (index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  widget.onChange(index);
                },
                child: Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.translators[index].language,
                        style: TextStyle(color: R.color.white),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Gradient BlueGradient() => LinearGradient(
      colors: [R.color.online_appointment, R.color.light_online_appointment],
      begin: Alignment.bottomLeft,
      end: Alignment.centerRight);
}
