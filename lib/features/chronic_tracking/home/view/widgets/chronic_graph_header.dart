import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import 'date_range_picker/date_range_picker.dart';

class ChronicGraphHeader extends StatelessWidget {
  final dynamic value;
  final Function() callBack;

  const ChronicGraphHeader({
    Key? key,
    this.value,
    required this.callBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: DateRangePicker(
            endDate: value.endDate,
            startDate: value.startDate,
            nextDate: value.nextDate,
            previousDate: value.previousDate,
            selected: value.selected,
            setSelectedItem: value.setSelectedItem,
            setEndDate: value.setEndDate,
            setStartDate: value.setStartDate,
          ),
        ),

        //
        Flexible(
          child: _graph(context),
        ),
      ],
    );
  }

  Widget _graph(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: R.sizes.borderRadiusCircular,
        color: context.xAppColors.iron,
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          //
          value.currentGraph,

          //
          GestureDetector(
            onTap: () => callBack(),
            child: Icon(
              Icons.keyboard_arrow_up,
              size: 52 * context.textScale,
            ),
          )
        ],
      ),
    );
  }
}
