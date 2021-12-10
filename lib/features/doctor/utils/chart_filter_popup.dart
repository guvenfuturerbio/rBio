import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/core.dart';
import '../../chronic_tracking/utils/glucose_margins_filter.dart';
import '../pages/patient_detail_page/patient_detail_page_view_model.dart';

class ChartFilterPopUp extends StatelessWidget {
  final double width;
  final double height;
  const ChartFilterPopUp({Key key, @required this.width, @required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(10),
        elevation: 0,
        child: Consumer<PatientDetailPageViewModel>(builder: (_, value, __) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: context.WIDTH * .03),
            child: SizedBox(
              height: height,
              width: width,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: context.HEIGHT * .01),
                      child: Column(
                        children: value.colorInfo.keys
                            .map((color) => _colorFilterItem(
                                text: value.colorInfo[color].toShortString(),
                                status: value
                                    .isFilterSelected(value.colorInfo[color]),
                                color: color,
                                size: 15,
                                statCallback: (_) => value
                                    .setFilterState(value.colorInfo[color]),
                                isHungry: false))
                            .toList(),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: context.HEIGHT * .01),
                      child: Column(
                        children: value.states
                            .map((state) => _colorFilterItem(
                                text: state.toShortString(),
                                status: value.isFilterSelected(state),
                                color: R.color.state_color,
                                size: 15,
                                style: state == LocaleProvider.current.full ||
                                        state == LocaleProvider.current.hungry
                                    ? BoxShape.circle
                                    : BoxShape.rectangle,
                                statCallback: (_) =>
                                    value.setFilterState(state),
                                isHungry:
                                    state == LocaleProvider.current.hungry))
                            .toList(),
                      ),
                    ),
                    TextButton(
                        onPressed: () => value.resetFilterValues(),
                        child: Text(
                            '${LocaleProvider.current.reset_filter_value}',
                            style: TextStyle(
                                decoration: TextDecoration.underline)))
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Padding _colorFilterItem(
      {double size,
      String text,
      Color color,
      bool status,
      BoxShape style,
      Function(bool) statCallback,
      bool isHungry}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25),
            height: size,
            width: size,
            decoration: BoxDecoration(
              shape: style ?? BoxShape.circle,
              color: isHungry ? Colors.transparent : color,
              border: Border.all(
                color: color,
                width: 2.0,
              ),
            ),
          ),
          Expanded(flex: 2, child: Text('$text')),
          //TODO: will be change to Sinem's design
          Expanded(
              child: SizedBox(
                  height: size,
                  width: size,
                  child: Checkbox(value: status, onChanged: statCallback)))
        ],
      ),
    );
  }
}
