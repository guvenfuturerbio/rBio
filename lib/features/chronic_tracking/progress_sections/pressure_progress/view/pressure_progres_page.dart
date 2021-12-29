import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:onedosehealth/features/chronic_tracking/progress_sections/pressure_progress/utils/bp_chart_filter/bp_chart_filter_pop_up.dart';
import 'package:onedosehealth/features/chronic_tracking/progress_sections/pressure_progress/utils/bp_measurement_list.dart';
import 'package:onedosehealth/features/chronic_tracking/progress_sections/utils/landscape_graph_widget.dart';
import 'package:provider/provider.dart';

import '../../../../../core/core.dart';
import '../../../lib/widgets/utils/time_period_filters.dart';
import '../../../utils/bottom_actions_of_graph/bottom_actions_of_graph.dart';
import '../../utils/graph_header_widget.dart';
import '../../utils/progress_page_model.dart';
import '../../utils/small_widget_card.dart';
import '../utils/line_chart.dart';
import '../utils/pressure_tagger/pressure_tagger.dart';
import '../view_model/pressure_measurement_view_model.dart';

part '../view_model/pressure_progres_view_model.dart';

class BpProgressPage extends StatelessWidget {
  const BpProgressPage({Key key, this.callback}) : super(key: key);
  final Function() callback;

  @override
  Widget build(BuildContext context) {
    return Consumer<BpProgressPageVm>(
      builder: (_, value, __) =>
          MediaQuery.of(context).orientation == Orientation.portrait ||
                  Atom.isWeb
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: (context.HEIGHT * .4) * context.TEXTSCALE,
                        child: GraphHeader(
                          value: value,
                          callBack: callback,
                        ),
                      ),
                      SizedBox(
                        height: context.HEIGHT * .1,
                        child: Row(
                          children: [
                            Spacer(),
                            _infoSection(context),
                            Spacer(flex: 9),
                            ElevatedButton(
                              onPressed: () => value.showFilter(context),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                shadowColor: Colors.black.withAlpha(50),
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(context.HEIGHT),
                                ),
                              ),
                              child: AutoSizeText(
                                '${LocaleProvider.current.filter_graphs}',
                                maxLines: 1,
                                style: context.xHeadline5.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: (context.HEIGHT * .4) * context.TEXTSCALE,
                        child: BpMeasurementList(
                          bpMeasurements: value.bpMeasurements,
                          scrollController: value.controller,
                        ),
                      )
                    ],
                  ),
                )
              : LandScapeGraphWidget(
                  graph: value.currentGraph,
                  value: value,
                  filterAction: () => Atom.show(BpChartFilterPopUp(
                    height: context.HEIGHT * .9,
                    width: context.WIDTH * .3,
                  )),
                ),
    );
  }

  Column _infoSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: context.WIDTH * .06,
              child: Divider(
                thickness: 3,
                color: Colors.red[900],
              ),
            ),
            SizedBox(width: context.WIDTH * .02),
            Text(LocaleProvider.current.sys)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: context.WIDTH * .06,
              child: Divider(
                thickness: 3,
                color: Colors.amber,
              ),
            ),
            SizedBox(width: context.WIDTH * .02),
            Text(LocaleProvider.current.dia)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: context.WIDTH * .06,
              child: Divider(
                thickness: 3,
                color: Colors.lime[800],
              ),
            ),
            SizedBox(width: context.WIDTH * .02),
            Text(LocaleProvider.current.pulse)
          ],
        ),
      ],
    );
  }
}
