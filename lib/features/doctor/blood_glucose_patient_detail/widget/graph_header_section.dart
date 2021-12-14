import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/core.dart';
import '../../../chronic_tracking/lib/widgets/utils/time_period_filters.dart';
import '../../../chronic_tracking/progress_sections/utils/date_range_picker/date_range_picker.dart';
import '../../../chronic_tracking/utils/bottom_actions_of_graph/bottom_actions_of_graph.dart';
import '../viewmodel/blood_glucose_patient_detail_vm.dart';
import '../../utils/custom_bar_pie.dart';

class BgGraphHeaderSection extends StatelessWidget {
  final BloodGlucosePatientDetailVm value;
  final ScrollController controller;

  const BgGraphHeaderSection({
    Key key,
    this.value,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        //
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: DateRangePicker(
            endDate: value.endDate,
            startDate: value.startDate,
            nextDate: value.nextDate,
            previousDate: value.previousDate,
            selected: value.selected.fromString,
            setSelectedItem: (val) {
              return value.setSelectedItem(val.toShortString());
            },
            setEndDate: value.setStartDate,
            setStartDate: value.setEndDate,
          ),
        ),

        //
        Container(
          height: context.HEIGHT * .45,
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            gradient: LinearGradient(
              colors: [
                Color(0xFFE0E0E0),
                Color(0xFFE0E0E0),
              ],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(50),
                blurRadius: 15,
                spreadRadius: 0,
                offset: Offset(5, 10),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              value.currentGraph,
              IgnorePointer(
                child: Padding(
                  padding: EdgeInsets.only(left: 40, top: 45),
                  child: SvgPicture.asset(
                    R.image.grafik_arkasi,
                    alignment: Alignment.centerRight,
                  ),
                ),
              ),
            ],
          ),
        ),

        //
        BottomActionsOfGraph(
          value: value,
        ),

        //
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withAlpha(20),
                  blurRadius: 5,
                  spreadRadius: 0,
                  offset: Offset(5, 5))
            ],
          ),
          padding: EdgeInsets.all(4),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CustomBarPie(
              width: MediaQuery.of(context).size.width * 0.90,
              height: (context.HEIGHT * 0.06) * context.TEXTSCALE,
            ),
          ),
        ),
      ],
    );
  }
}
