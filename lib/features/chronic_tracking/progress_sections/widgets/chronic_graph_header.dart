import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/core.dart';
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
        color: R.color.chart_gray,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            blurRadius: 5,
            spreadRadius: 0,
            offset: const Offset(5, 4),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          //
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              value.currentGraph,
              IgnorePointer(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.slowMiddle,
                  margin: const EdgeInsets.only(left: 40, top: 45),
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: SvgPicture.asset(
                    R.image.grafikArkasi,
                    alignment: Alignment.centerRight,
                  ),
                ),
              ),
            ],
          ),

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
