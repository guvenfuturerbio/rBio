import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helper/resources.dart';
import '../../pages/progress_pages/bg_progress_page/bg_progress_page_view_model.dart';
import '../utils/glucose_margins_filter.dart';

class ColorInfoWidget extends StatelessWidget {
  final Map<Color, GlucoseMarginsFilter> values;
  final List<GlucoseMarginsFilter> states;
  ColorInfoWidget({this.values, this.states});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildRowList(values, context),
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _buildRowList2(states, context),
          ),
        ),
      ],
    );
  }
}

List<Widget> _buildRowList2(
    List<GlucoseMarginsFilter> states, BuildContext context) {
  List<Widget> generatedList = [];
  for (int i = 0; i < states.length; i++) {
    generatedList.add(Consumer<BgProgressPageViewModel>(
      builder: (context, value, child) {
        return InkWell(
          onTap: () {
            value.setFilterState(states[i]);
          },
          child: Container(
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape:
                        i == 0 || i == 1 ? BoxShape.circle : BoxShape.rectangle,
                    color: i == 0 ? Colors.transparent : R.color.state_color,
                    border: Border.all(
                      color: R.color.state_color,
                      width: 2.0,
                    ),
                  ),
                ),
                Text(
                  states[i].toShortString(),
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.024,
                      decoration: value.isFilterSelected(states[i])
                          ? TextDecoration.none
                          : TextDecoration.lineThrough),
                )
              ],
            ),
          ),
        );
      },
    ));
  }
  return generatedList;
}

List<Widget> _buildRowList(
    Map<Color, GlucoseMarginsFilter> values, BuildContext context) {
  List<Widget> generatedList = [];
  for (var data in values.keys) {
    generatedList.add(Consumer<BgProgressPageViewModel>(
      builder: (context, value, child) {
        return InkWell(
          onTap: () {
            value.setFilterState(values[data]);
          },
          child: Container(
            margin: EdgeInsets.all(8),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: data, borderRadius: BorderRadius.circular(20)),
                ),
                Text(
                  values[data].toShortString(),
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.024,
                      decoration: value.isFilterSelected(values[data])
                          ? TextDecoration.none
                          : TextDecoration.lineThrough),
                )
              ],
            ),
          ),
        );
      },
    ));
  }
  return generatedList;
}
