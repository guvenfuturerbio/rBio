import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:onedosehealth/generated/l10n.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../core/data/imports/cronic_tracking.dart';
import '../../../../../core/locator.dart';
import '../../../lib/core/utils/bottom_actions_of_graph/bottom_actions_of_graph.dart';
import '../../../lib/extension/size_extension.dart';
import '../../../lib/models/bg_measurement/blood_glucose_report_body.dart';
import '../../../lib/notifiers/user_profiles_notifier.dart';
import '../utils/bg_measurement_list.dart';
import '../utils/custom_bar_pie.dart';
import '../../utils/graph_header_widget.dart';
import '../../utils/landscape_graph_widget.dart';
import '../../utils/chart_filter_pop_up.dart';
import '../view_model/bg_progress_page_view_model.dart';
import '../../../lib/pages/progress_pages/bg_progress_page/fullpdfviewerscreen.dart';

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
  Future<void> goPdfPage(String img64) async {
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

  String _getFormattedDate(String date) {
    var parsedDate = DateTime.parse(date);
    String textDate = new DateFormat("d MMMM yyyy").format(parsedDate);
    return textDate;
  }

  @override
  Widget build(BuildContext context) {
    var value = Provider.of<BgProgressPageViewModel>(context);
    return MediaQuery.of(context).orientation == Orientation.portrait ||
            Atom.isWeb
        ? Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                      height: (context.HEIGHT * 0.06) * context.TEXTSCALE,
                    ),
                  ),
                );
              }),
              Expanded(
                child: BgMeasurementListWidget(
                  bgMeasurements: value.bgMeasurements,
                  scrollController: _controller,
                  useStickyGroupSeparatorsValue: true,
                ),
              )
            ],
          )
        : LandScapeGraphWidget(
            graph: value.currentGraph,
            value: value,
            filterAction: () {
              showDialog(
                  context: context,
                  barrierColor: Colors.black12,
                  builder: (ctx) => BGChartFilterPopUp(
                        height: context.HEIGHT * .9,
                        width: context.WIDTH * .3,
                      ));
            },
            changeGraphAction: () => value.changeGraphType(),
          );
  }
}
