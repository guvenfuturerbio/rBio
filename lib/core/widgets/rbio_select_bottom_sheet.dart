import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core.dart';

class RbioSelectBottomSheet<T> extends StatelessWidget {
  final initalItem;
  final List<Widget> children;
  final Function(dynamic) onSelectedItemChanged;
  final Function pick;

  const RbioSelectBottomSheet({
    Key key,
    @required this.onSelectedItemChanged,
    @required this.children,
    @required this.initalItem,
    @required this.pick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: Atom.height * 0.35,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          _buildHeader(context),

          //
          Divider(
            color: Colors.black26,
            height: 0,
          ),

          //
          Expanded(
            child: CupertinoPicker(
              scrollController: FixedExtentScrollController(
                initialItem: initalItem,
              ),
              backgroundColor: Colors.white,
              onSelectedItemChanged: onSelectedItemChanged,
              itemExtent: 45.0,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Text(
              LocaleProvider.current.cancel,
              style: context.xHeadline2,
            ),
          ),

          //
          GestureDetector(
            onTap: pick,
            child: Text(
              LocaleProvider.current.pick,
              style: context.xHeadline2,
            ),
          )
        ],
      ),
    );
  }
}
