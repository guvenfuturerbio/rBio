import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core.dart';

Future<dynamic> showRbioSelectBottomSheet<T>(
  BuildContext context, {
  required String title,
  required dynamic initialItem,
  required List<Widget> children,
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
        child: RbioSelectBottomSheet<T>(
          title: title,
          children: children,
          initialItem: initialItem,
        ),
      );
    },
  );

  return result;
}

class RbioSelectBottomSheet<T> extends StatefulWidget {
  final String title;
  final dynamic initialItem;
  final List<Widget> children;

  const RbioSelectBottomSheet({
    Key? key,
    required this.title,
    required this.children,
    required this.initialItem,
  }) : super(key: key);

  @override
  State<RbioSelectBottomSheet<T>> createState() =>
      _RbioSelectBottomSheetState<T>();
}

class _RbioSelectBottomSheetState<T> extends State<RbioSelectBottomSheet<T>> {
  late dynamic _currentValue;

  @override
  void initState() {
    _currentValue = widget.initialItem;
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
        const Spacer(flex: 30),

        //
        Expanded(
          flex: 200,
          child: CupertinoPicker(
            scrollController: FixedExtentScrollController(
              initialItem: widget.initialItem ?? 0,
            ),
            backgroundColor: Colors.transparent,
            onSelectedItemChanged: (val) {
              _currentValue = val;
            },
            itemExtent: 45.0,
            children: widget.children,
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
              Navigator.of(context).pop(_currentValue);
            },
          ),
        ),

        //
        R.sizes.defaultBottomPadding,
      ],
    );
  }
}
