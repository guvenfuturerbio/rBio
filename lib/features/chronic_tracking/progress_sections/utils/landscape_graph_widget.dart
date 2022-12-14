import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/core.dart';
import '../../utils/bottom_actions_of_graph/bottom_actions_of_graph.dart';
import 'date_range_picker/date_range_picker.dart';

class LandScapeGraphWidget extends StatelessWidget {
  const LandScapeGraphWidget({
    Key? key,
    required this.graph,
    required this.filterAction,
    this.value,
  }) : super(key: key);
  final dynamic value;
  final Widget graph;
  final Function() filterAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: DateRangePicker(
              height: (context.width * .039) * context.textScale,
              endDate: value.endDate,
              startDate: value.startDate,
              nextDate: value.nextDate,
              previousDate: value.previousDate,
              selected: value.selected,
              setSelectedItem: value.setSelectedItem,
              setEndDate: value.changeEndDate,
              setStartDate: value.changeStartDate,
            )),
        Flexible(
          flex: 6,
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                color: R.color.chart_gray,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withAlpha(50),
                      blurRadius: 5,
                      spreadRadius: 0,
                      offset: const Offset(5, 5))
                ]),
            child: Stack(
              children: [
                graph,
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                      alignment: Alignment.bottomRight,
                      margin: const EdgeInsets.only(left: 40, top: 45),
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: SvgPicture.asset(
                        R.image.grafikArkasi,
                      )),
                ),
              ],
            ),
          ),
        ),
        BottomActionsOfGraph(
          value: value,
        ),
      ],
    );
  }
}
