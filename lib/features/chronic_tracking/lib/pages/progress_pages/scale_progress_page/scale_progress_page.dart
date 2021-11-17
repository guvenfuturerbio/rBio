import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/bottom_actions_of_graph/bottom_actions_of_graph.dart';
import '../../../core/utils/scale_filter_pop_up/scale_filter_pop_up.dart';
import '../../../extension/size_extension.dart';
import '../../../widgets/graph_header_widget.dart';
import '../../../widgets/landscape_graph_widget.dart';
import '../../../widgets/scale_measurement_list.dart';
import 'scale_progress_page_view_model.dart';

class ScaleProgressPage extends StatefulWidget {
  final Function() callBack;

  const ScaleProgressPage({Key key, this.callBack}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ScaleProgressPage();
  }
}

class _ScaleProgressPage extends State<ScaleProgressPage> {
  ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Consumer<ScaleProgressPageViewModel>(
      builder: (context, value, child) {
        return MediaQuery.of(context).orientation == Orientation.portrait
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: context.HEIGHT * .17,
                    ),
                    SizedBox(
                      height: (context.HEIGHT * .38) * context.TEXTSCALE,
                      child: GraphHeader(
                        value: value,
                        callBack: widget.callBack,
                      ),
                    ),
                    BottomActionsOfGraph(
                      value: value,
                    ),
                    Container(
                      height: (context.HEIGHT * .35) * context.TEXTSCALE,
                      margin: EdgeInsets.only(top: 8),
                      child: ScaleMeasurementListWidget(
                        scaleMeasurements: value.scaleMeasurements,
                        scrollController: _controller,
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
                  showDialog(
                      context: context,
                      barrierColor: Colors.black12,
                      builder: (ctx) => ScaleChartFilterPopup(
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
