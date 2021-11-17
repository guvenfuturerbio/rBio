import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../extension/size_extension.dart';

class CustomBottomSheet extends StatelessWidget {
  final initalItem;
  final String type;
  final List<Widget> children;
  final Function(dynamic) onSelectedItemChanged;
  final Function pick;
  const CustomBottomSheet(
      {Key key,
      @required this.onSelectedItemChanged,
      @required this.children,
      @required this.initalItem,
      @required this.pick,
      this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.HEIGHT * .4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: context.HEIGHT * .1,
            child: Card(
              child: _actionOnPicker(context),
            ),
          ),
          Expanded(
            child: type == 'picker'
                ? CupertinoPicker(
                    scrollController: FixedExtentScrollController(
                      initialItem: initalItem,
                    ),
                    backgroundColor: Colors.grey[400],
                    onSelectedItemChanged: onSelectedItemChanged,
                    itemExtent: 50.0,
                    children: children)
                : CupertinoDatePicker(
                    onDateTimeChanged: onSelectedItemChanged,
                    initialDateTime: initalItem,
                    use24hFormat: true,
                    maximumDate: DateTime.now(),
                    minimumYear: 1920,
                    maximumYear: DateTime.now().year,
                    minuteInterval: 1,
                    mode: CupertinoDatePickerMode.date,
                  ),
          ),
        ],
      ),
    );
  }

  Row _actionOnPicker(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(LocaleProvider.current.cancel)),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: GestureDetector(
              onTap: pick, child: Text(LocaleProvider.current.pick)),
        )
      ],
    );
  }
}
