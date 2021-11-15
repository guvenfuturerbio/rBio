import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onedosehealth/extension/size_extension.dart';
import 'package:onedosehealth/generated/l10n.dart';
import 'package:onedosehealth/helper/resources.dart';

class CustomDialog extends StatelessWidget {
  final initalItem;
  final List<Widget> children;
  final Function(dynamic) onSelectedItemChanged;
  final Function pick;
  final String type;
  const CustomDialog({
    Key key,
    @required this.onSelectedItemChanged,
    @required this.children,
    @required this.initalItem,
    @required this.pick,
    this.type = 'standart',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(children);

    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: context.HEIGHT * .4,
            child: CupertinoPicker(
                scrollController:
                    FixedExtentScrollController(initialItem: initalItem),
                backgroundColor: Colors.white,
                onSelectedItemChanged: onSelectedItemChanged,
                itemExtent: 50.0,
                children: children),
          ),
          GestureDetector(
              child: Container(
                padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: R.color.defaultBlue,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                      bottomRight: Radius.circular(32.0)),
                ),
                child: Text(
                  LocaleProvider.current.save,
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              onTap: pick),
        ],
      ),
    );
  }
}
