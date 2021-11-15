import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/bottom_actions_of_graph/bottom_actions_of_graph.dart';
import '../../../extension/size_extension.dart';
import '../../../generated/l10n.dart';
import '../../../models/bg_measurement/blood_glucose_report_body.dart';
import '../../../notifiers/user_profiles_notifier.dart';
import '../../../services/base_provider.dart';
import '../../../widgets/bg_measurement_list.dart';
import '../../../widgets/custom_bar_pie.dart';
import '../../../widgets/graph_header_widget.dart';
import '../../../widgets/landscape_graph_widget.dart';
import '../../../widgets/utils/chart_filter_pop_up.dart';
import '../../signup&login/token_provider.dart';
import 'bg_progress_page_view_model.dart';
import 'fullpdfviewerscreen.dart';

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
    BaseProvider bp = BaseProvider.create(TokenProvider().authToken);
    final response = await bp.getBloodGlucoseReport(bloodGlucoseReportBody);
    if (response.isSuccessful) {
      var documentBody = jsonDecode(utf8.decode(response.bodyBytes));
      var datum = documentBody["datum"];
      var bytes = base64.decode(datum);

      File file = new File("");

      String fileName = LocaleProvider.current.pdf_filename;
      String dir = (await getApplicationDocumentsDirectory()).path;
      file = new File('$dir/$fileName');
      await file.writeAsBytes(bytes);

      List<String> fileNameSplit = fileName.split(".");
      String mimeType = fileNameSplit[fileNameSplit.length - 1];

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
  }

  String _getFormattedDate(String date) {
    var parsedDate = DateTime.parse(date);
    String textDate = new DateFormat("d MMMM yyyy").format(parsedDate);
    return textDate;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BgProgressPageViewModel>(
      builder: (context, value, child) {
        return MediaQuery.of(context).orientation == Orientation.portrait
            ? SingleChildScrollView(
                physics: ClampingScrollPhysics(),
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
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: Colors.black.withAlpha(20),
                            blurRadius: 5,
                            spreadRadius: 0,
                            offset: Offset(5, 5))
                      ]),
                      padding: EdgeInsets.all(4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CustomBarPie(
                          width: MediaQuery.of(context).size.width * 0.95,
                          height: (context.HEIGHT * 0.06) * context.TEXTSCALE,
                        ),
                      ),
                    ),
                    Container(
                      height: (context.HEIGHT * .35) * context.TEXTSCALE,
                      margin: EdgeInsets.only(top: 8),
                      //margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
                      child: BgMeasurementListWidget(
                        bgMeasurements: value.bgMeasurements,
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
                      builder: (ctx) => BGChartFilterPopUp(
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
