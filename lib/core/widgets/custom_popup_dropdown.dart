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
    return GuvenAlert(
      backgroundColor: Colors.white,
      title: GuvenAlert.buildTitle(widget.title),
      actions: [
        GuvenAlert.buildMaterialAction(
          LocaleProvider.of(context).btn_cancel.toUpperCase(),
          () {
            Navigator.of(context).pop();
          },
        ),
      ],

      //
      content: Container(
        height: 200,
        margin: EdgeInsets.all(30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              widget.translators.length,
              (index) {
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
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
