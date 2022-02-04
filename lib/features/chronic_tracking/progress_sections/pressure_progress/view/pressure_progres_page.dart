import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/core.dart';
import '../../../utils/bottom_actions_of_graph/bottom_actions_of_graph.dart';
import '../../utils/graph_header_widget.dart';
import '../../utils/landscape_graph_widget.dart';
import '../../utils/progress_page_model.dart';
import '../../utils/small_widget_card.dart';
import '../utils/bp_chart_filter/bp_chart_filter_pop_up.dart';
import '../utils/bp_measurement_list.dart';
import '../utils/line_chart.dart';
import '../utils/pressure_tagger/pressure_tagger.dart';
import '../view_model/pressure_measurement_view_model.dart';

part '../view_model/pressure_progres_view_model.dart';

class BpProgressPage extends StatefulWidget {
  const BpProgressPage({Key? key, this.callback}) : super(key: key);
  final Function()? callback;

  @override
  State<BpProgressPage> createState() => _BpProgressPageState();
}

class _BpProgressPageState extends State<BpProgressPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BpProgressPageVm>(
      builder: (_, value, __) =>
          MediaQuery.of(context).orientation == Orientation.portrait ||
                  Atom.isWeb
              ? RbioStackedScaffold(
                  appbar: RbioAppBar(
                    title: RbioAppBar.textTitle(
                      context,
                      LocaleProvider.current.bg_measurement_tracking,
                    ),
                  ),
                  body: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: R.sizes.stackedTopPaddingValue(context) + 8,
                        ),
                        if (value.isChartShow) ...getGraph(context, value),
                        if (!value.isChartShow)
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: context.height * .02),
                            child: RbioElevatedButton(
                              title: LocaleProvider.current.open_chart,
                              onTap: () => context
                                  .read<BpProgressPageVm>()
                                  .changeChartShowStatus(),
                            ),
                          ),
                        SizedBox(
                          height: value.isChartShow
                              ? (context.height * .4) * context.textScale
                              : (context.height * .8),
                          child: BpMeasurementList(
                            bpMeasurements: value.bpMeasurements,
                            scrollController: value.controller,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : LandScapeGraphWidget(
                  graph: value.currentGraph,
                  value: value,
                  filterAction: () => Atom.show(BpChartFilterPopUp(
                    width: context.width * .3,
                  )),
                ),
    );
  }

  SizedBox _infoSection(BuildContext context) {
    return SizedBox(
      width: context.width * .3 * context.textScale,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: context.width * .06,
                child: Divider(
                  thickness: 3,
                  color: Colors.red[900],
                ),
              ),
              SizedBox(width: context.width * .02),
              Text(LocaleProvider.current.sys)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: context.width * .06,
                child: const Divider(
                  thickness: 3,
                  color: Colors.amber,
                ),
              ),
              SizedBox(width: context.width * .02),
              Text(LocaleProvider.current.dia)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: context.width * .06,
                child: Divider(
                  thickness: 3,
                  color: Colors.lime[800],
                ),
              ),
              SizedBox(width: context.width * .02),
              Text(LocaleProvider.current.pulse)
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> getGraph(BuildContext context, BpProgressPageVm value) {
    return [
      SizedBox(
        height: (context.height * .4) * context.textScale,
        child: GraphHeader(
          value: value,
          callBack: widget.callback ??
              () {
                LoggerUtils.instance.i('Graph');
              },
        ),
      ),
      SizedBox(
        height: context.height * .1,
        child: Wrap(
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          runSpacing: 25,
          spacing: 25,
          children: [
            _infoSection(context),
            ElevatedButton(
              onPressed: () => value.showFilter(context),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                shadowColor: Colors.black.withAlpha(50),
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.height),
                ),
              ),
              child: AutoSizeText(
                LocaleProvider.current.filter_graphs,
                maxLines: 1,
                style: context.xHeadline5.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => value.changeChartShowStatus(),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                shadowColor: Colors.black.withAlpha(50),
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.height),
                ),
              ),
              child: AutoSizeText(
                LocaleProvider.current.close_chart,
                maxLines: 1,
                style: context.xHeadline5.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    ];
  }
}
