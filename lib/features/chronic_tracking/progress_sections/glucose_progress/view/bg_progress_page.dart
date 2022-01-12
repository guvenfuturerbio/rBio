import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/core.dart';
import '../../../utils/bottom_actions_of_graph/bottom_actions_of_graph.dart';
import '../../utils/chart_filter_pop_up.dart';
import '../../utils/graph_header_widget.dart';
import '../../utils/landscape_graph_widget.dart';
import '../utils/bg_measurement_list.dart';
import '../utils/custom_bar_pie.dart';
import '../view_model/bg_progress_page_view_model.dart';

/// MG19
class BgProgressPage extends StatefulWidget {
  final Function() callBack;

  const BgProgressPage({Key key, this.callBack}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BgProgressPage();
  }
}

class _BgProgressPage extends State<BgProgressPage> {
  ScrollController _controller = ScrollController();
  /*  Future<void> goPdfPage(String img64) async {
    BloodGlucoseReportBody bloodGlucoseReportBody = new BloodGlucoseReportBody(
        start: "2010-09-10T00:00:00",
        end: "2022-09-10T00:00:00",
        reportType: 2,
        userId:
            UserProfilesNotifier().selection?.id ?? 0); // Report Type 2 -> PDF
    final response = await getIt<ChronicTrackingRepository>()
        .getBloodGlucoseReport(bloodGlucoseReportBody);
    var datum = response.datum;
    var bytes = base64.decode(datum);

    File file = new File("");

    String fileName = LocaleProvider.current.pdf_filename;
    String dir = (await getApplicationDocumentsDirectory()).path;
    file = new File('$dir/$fileName');
    await file.writeAsBytes(bytes);

    Navigator.of(context).pop();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FullPdfViewerScreen(
            file.path,
            _getFormattedDate(DateTime.now().toString()),
          ),
        ));
  }
 */
  /* String _getFormattedDate(String date) {
    var parsedDate = DateTime.parse(date);
    String textDate = new DateFormat("d MMMM yyyy").format(parsedDate);
    return textDate;
  } */

  @override
  Widget build(BuildContext context) {
    var value = Provider.of<BgProgressPageViewModel>(context);
    return MediaQuery.of(context).orientation == Orientation.portrait ||
            Atom.isWeb
        ? SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (value.isChartShow) ...[
                  SizedBox(
                      height: (context.HEIGHT * .4) * context.TEXTSCALE,
                      child: GraphHeader(
                        value: value,
                        callBack: widget.callBack,
                      )),
                  BottomActionsOfGraph(
                    value: value,
                  ),
                  LayoutBuilder(builder: (context, constraints) {
                    return Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: Colors.black.withAlpha(20),
                            blurRadius: 5,
                            spreadRadius: 0,
                            offset: Offset(5, 5))
                      ]),
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CustomBarPie(
                          width: constraints.maxWidth,
                          height: (context.HEIGHT * .05) * context.TEXTSCALE,
                        ),
                      ),
                    );
                  }),
                ],
                if (!value.isChartShow)
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: context.HEIGHT * .02),
                    child: RbioElevatedButton(
                      title: LocaleProvider.current.open_chart,
                      onTap: value.changeChartShowStatus,
                    ),
                  ),
                SizedBox(
                  height: value.isChartShow
                      ? context.HEIGHT * .4
                      : context.HEIGHT * .8,
                  child: BgMeasurementListWidget(
                    bgMeasurements: value.bgMeasurements,
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
              Atom.show(
                  BGChartFilterPopUp(
                    height: context.HEIGHT * .9,
                    width: context.WIDTH * .3,
                  ),
                  barrierColor: Colors.black12);
            },
            changeGraphAction: () => value.changeGraphType(),
          );
  }
}
