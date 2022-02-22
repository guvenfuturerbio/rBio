import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core.dart';

Future<DateTime?> showGuvenDatePicker(
  BuildContext context,
  DateTime firstDate,
  DateTime lastDate,
  DateTime initialDate,
  String helpText,
) async {
  final result = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
    helpText: helpText,
    cancelText: LocaleProvider.of(context).btn_cancel,
    confirmText: LocaleProvider.of(context).btn_confirm,
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light(
            primary: getIt<ITheme>().mainColor,
          ),
          buttonTheme: const ButtonThemeData(
            textTheme: ButtonTextTheme.primary,
          ),
        ),
        child: child ?? const SizedBox(),
      );
    },
  );

  if (result != null) {
    if (initialDate.xIsSameDate(result)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            LocaleProvider.current.appointment_datepicker_warning,
            style: context.xHeadline3.copyWith(
              color: getIt<ITheme>().textColor,
            ),
          ),
        ),
      );
    }
  }

  return result;
}

void showCupertinoGuvenDatePicker({
  required BuildContext context,
  required DateTime firstDate,
  required DateTime lastDate,
  required DateTime initialDate,
  required void Function(DateTime date) onCompleted,
}) async {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext builder) {
      return RbioCupertinoPicker(
        firstDate: firstDate,
        lastDate: lastDate,
        initialDate: initialDate,
        onCompleted: onCompleted,
      );
    },
  );
}

class RbioCupertinoPicker extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime initialDate;
  final void Function(DateTime date) onCompleted;

  const RbioCupertinoPicker({
    Key? key,
    required this.firstDate,
    required this.lastDate,
    required this.initialDate,
    required this.onCompleted,
  }) : super(key: key);

  @override
  _RbioCupertinoPickerState createState() => _RbioCupertinoPickerState();
}

class _RbioCupertinoPickerState extends State<RbioCupertinoPicker> {
  late DateTime currentDate;

  @override
  void initState() {
    currentDate = widget.initialDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: CupertinoTheme.of(context).copyWith(
        textTheme: CupertinoTheme.of(context).textTheme.copyWith(
              dateTimePickerTextStyle: context.xHeadline3,
            ),
      ),
      child: Container(
        color: getIt<ITheme>().cardBackgroundColor,
        constraints: BoxConstraints(
          maxHeight: (Atom.height * 0.4 > 300 ? 300 : Atom.height * 0.4) +
              Atom.safeBottom,
        ),
        child: Column(
          children: [
            //
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                //
                CupertinoButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    LocaleProvider.current.btn_cancel,
                    style: context.xHeadline4.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                //
                const Spacer(),

                //
                CupertinoButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (!currentDate.xIsSameDate(widget.initialDate)) {
                      widget.onCompleted(currentDate);
                    }
                  },
                  child: Text(
                    LocaleProvider.current.ok,
                    style: context.xHeadline4.copyWith(
                      color: getIt<ITheme>().mainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            //
            const Divider(height: 0),

            //
            Expanded(
              child: CupertinoDatePicker(
                initialDateTime: widget.initialDate,
                use24hFormat: true,
                maximumDate: widget.lastDate,
                minimumDate: widget.firstDate,
                minuteInterval: 1,
                mode: CupertinoDatePickerMode.date,
                backgroundColor: getIt<ITheme>().cardBackgroundColor,
                onDateTimeChanged: (DateTime date) {
                  setState(() {
                    currentDate = date;
                  });
                },
              ),
            ),

            //
            R.sizes.defaultBottomPadding,
          ],
        ),
      ),
    );
  }
}
