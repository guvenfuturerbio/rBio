import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:onedosehealth/core/widgets/loading_dialog.dart';
import 'package:onedosehealth/generated/l10n.dart';

import '../../models/drug_result.dart';
import '../homepage/selectedremindable.dart';
import 'scheduler_page/medicine_date_page.dart';

/// MG11
class MedicinePeriodSelection extends StatefulWidget {
  final DrugResult drugResult;
  final Remindable selectedRemindable;

  MedicinePeriodSelection({this.drugResult, this.selectedRemindable});
  @override
  _PageState createState() => _PageState();
}

enum MedicinePeriod { EVERY_DAY, SPECIFIC_DAYS, INTERMITTENT_DAYS }

extension ParseToString on MedicinePeriod {
  String toShortString() {
    switch (this) {
      case MedicinePeriod.EVERY_DAY:
        return LocaleProvider().every_day;
        break;
      case MedicinePeriod.SPECIFIC_DAYS:
        return LocaleProvider().specific_days;
        break;
      case MedicinePeriod.INTERMITTENT_DAYS:
        return LocaleProvider().intermittent_days;
        break;
      default:
        throw Exception('toShprtString');
    }
  }
}

enum UsageType { HUNGRY, FULL, IRRELEVANT }

class _PageState extends State<MedicinePeriodSelection> {
  LoadingDialog loadingDialog;
  BaseProvider baseProvider;
  List names = [];
  List<String> filteredNames = [];

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: RbioAppBar(
        title: getTitleBar(context),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 15),
            child: Text(
              LocaleProvider.current.medicine_how_often_message,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            child: _buildList(),
          ),
        ],
      ),
    );
  }

  Widget getTitleBar(BuildContext context) {
    return TitleAppBarWhite(title: widget.drugResult.name);
  }

  /// MGD3
  Widget _buildList() {
    List<MedicinePeriod> periodList = [];
    periodList.addAll(MedicinePeriod.values);
    periodList
        .removeWhere((element) => element == MedicinePeriod.INTERMITTENT_DAYS);
    return ListView.builder(
      itemCount: periodList.length,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
            child: ListTile(
              title: Text(
                UtilityManager()
                    .getMedicinePeriodName(context, periodList[index]),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MedicineDatePage(
                      medicinePeriod: periodList[index],
                      selectedRemindable: widget.selectedRemindable,
                    ),
                    settings: RouteSettings(name: 'NewEntry'),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  showGradientDialog(BuildContext context, String title, String text) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return GuvenAlert(
              title: GuvenAlert.buildTitle(title),
              content: GuvenAlert.buildDescription(text));
        });
  }

  void showLoadingDialog(BuildContext context) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) =>
            loadingDialog = loadingDialog ?? LoadingDialog());
  }

  hideDialog(BuildContext context) {
    if (loadingDialog != null && loadingDialog.isShowing()) {
      Navigator.of(context).pop();
      loadingDialog = null;
    }
  }
}
