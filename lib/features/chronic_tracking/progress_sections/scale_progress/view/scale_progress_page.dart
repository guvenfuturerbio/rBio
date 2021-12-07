import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/core.dart';
import '../../../../../core/extension/build_context_extension.dart';
import '../../../utils/bottom_actions_of_graph/bottom_actions_of_graph.dart';
import '../../utils/graph_header_widget.dart';
import '../../utils/landscape_graph_widget.dart';
import '../utils/scale_filter_pop_up/scale_filter_pop_up.dart';
import '../utils/scale_measurement_list.dart';
import '../view_model/scale_progress_page_view_model.dart';

class ScaleProgressPage extends StatefulWidget {
  final Function() callBack;

  const ScaleProgressPage({Key key, this.callBack}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ScaleProgressPage();
  }
}

class _ScaleProgressPage extends State<ScaleProgressPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ScaleProgressPageViewModel>(
      builder: (context, value, child) {
        return MediaQuery.of(context).orientation == Orientation.portrait ||
                Atom.isWeb
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: (context.HEIGHT * .4) * context.TEXTSCALE,
                      child: GraphHeader(
                        value: value,
                        callBack: widget.callBack,
                      ),
                    ),
                    BottomActionsOfGraph(
                      value: value,
                    ),
                    Container(
                      height: (context.HEIGHT * .5) * context.TEXTSCALE,
                      margin: EdgeInsets.only(top: 8),
                      child: ScaleMeasurementListWidget(
                        scaleMeasurements: value.scaleMeasurements,
                        scrollController: value.controller,
                        useStickyGroupSeparatorsValue: true,
                      ),
                    )
                  ],
                ),
              )
            : LandScapeGraphWidget(
                graph: value.currentGraph,
                value: value,
                filterAction: () {
                  Atom.show(ScaleChartFilterPopup(
                    height: context.HEIGHT * .9,
                    width: context.WIDTH * .3,
                  ));
                },
                changeGraphAction: () => value.changeGraphType(),
              );
      },
    );
  }
}
