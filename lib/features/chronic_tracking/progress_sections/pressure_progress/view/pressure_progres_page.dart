import 'package:flutter/material.dart';
import 'package:onedosehealth/features/chronic_tracking/progress_sections/pressure_progress/utils/bp_measurement_list.dart';
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
      builder: (_, value, __) => SingleChildScrollView(
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
              height: context.HEIGHT * .4,
              child: BpMeasurementList(
                bpMeasurements: value.bpMeasurements,
                scrollController: value.controller,
              ),
            )
          ],
        ),
      ),
    );
  }
}
