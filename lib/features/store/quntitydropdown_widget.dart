import 'package:flutter/material.dart';

import '../../core/core.dart';

/// This is the stateful widget that the main application instantiates.
class QuantityDropdownWidget extends StatefulWidget {
  @override
  State<QuantityDropdownWidget> createState() => _QuantityDropdownWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _QuantityDropdownWidgetState extends State<QuantityDropdownWidget> {
  String dropdownValue = '1';
  final TextEditingController quantity = new TextEditingController(text: '1');

  @override
  Widget build(BuildContext context) {
    return dropdownValue != '10+'
        ? DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.black),
            underline: Container(
              height: 2,
              color: getIt<ITheme>().mainColor,
            ),
            onChanged: (String newValue) {
              setState(() {
                dropdownValue = newValue;
              });
            },
            items: <String>['1', '2', '3', '4', '5', '6', '7', '8', '9', '10+']
                .map<DropdownMenuItem<String>>(
              (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              },
            ).toList(),
          )
        : Row(
            children: [
              Text("Adet: "),
              Container(
                constraints: BoxConstraints(maxHeight: 50, maxWidth: 50),
                child: TextFormField(
                  controller: quantity,
                  style: Utils.instance.inputTextStyle(),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(),
                ),
                margin: EdgeInsets.only(bottom: 20),
              ),

              //
              SizedBox(
                width: 5,
              ),

              //
              Utils.instance.button(text: "Update", width: 30, height: 12)
            ],
          );
  }
}
