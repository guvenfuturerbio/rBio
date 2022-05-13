import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../core.dart';

Future<DateTime?> showRbioDatePicker(
  BuildContext context, {
  required String title,
  required DateTime initialDateTime,
  DateTime? minimumDate,
  DateTime? maximumDate,
  CupertinoDatePickerMode? mode,
}) async {
  final result = await showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: R.sizes.radiusCircular,
      ),
    ),
    builder: (BuildContext builder) {
      return SizedBox(
        height: Atom.height * 0.45,
        child: RbioDatePicker(
          mode: mode ?? CupertinoDatePickerMode.date,
          title: title,
          initialDateTime: initialDateTime,
          minimumDate: minimumDate ?? DateTime(2000),
          maximumDate:
              maximumDate ?? DateTime.now().add(const Duration(days: 365)),
        ),
      );
    },
  );

  return result;
}

class RbioDatePicker extends StatefulWidget {
  final String title;
  final DateTime initialDateTime;
  final DateTime minimumDate;
  final DateTime maximumDate;
  final CupertinoDatePickerMode mode;

  const RbioDatePicker({
    Key? key,
    required this.title,
    required this.initialDateTime,
    required this.minimumDate,
    required this.maximumDate,
    required this.mode,
  }) : super(key: key);

  @override
  State<RbioDatePicker> createState() => _RbioDatePickerState();
}

class _RbioDatePickerState extends State<RbioDatePicker> {
  late DateTime _selectedDate;

  @override
  void initState() {
    _selectedDate = widget.initialDateTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        const Spacer(flex: 10),

        //
        Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: R.sizes.borderRadiusCircular,
          ),
        ),

        //
        const Spacer(flex: 20),

        //
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            widget.title,
            style: context.xHeadline2.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        //
        R.sizes.hSizer8,

        //
        if (widget.mode != CupertinoDatePickerMode.time)
          Text(
            DateFormat("d MMMM yyyy EEEE",
                    context.watch<LocaleNotifier>().current.languageCode)
                .format(_selectedDate),
            style: context.xHeadline4.copyWith(
              fontWeight: FontWeight.w400,
              color: context.xHeadline5.color!.withOpacity(0.75),
            ),
          ),

        //
        const Spacer(flex: 30),

        //
        Expanded(
          flex: 200,
          child: CupertinoDatePicker(
            mode: widget.mode,
            onDateTimeChanged: (value) {
              if (value != _selectedDate) {
                setState(() {
                  _selectedDate = value;
                });
              }
            },
            initialDateTime: _selectedDate,
            minimumDate: widget.minimumDate,
            maximumDate: widget.maximumDate,
            use24hFormat: true,
          ),
        ),

        //
        const Spacer(flex: 30),

        //
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 32),
          child: RbioElevatedButton(
            title: LocaleProvider.current.Ok,
            infinityWidth: true,
            fontWeight: FontWeight.bold,
            onTap: () {
              Navigator.of(context).pop(_selectedDate);
            },
          ),
        ),

        //
        R.sizes.defaultBottomPadding,
      ],
    );
  }
}
