import 'dart:convert';

import 'package:flutter/material.dart';
import '../../../../../core/core.dart';
import '../../../../../core/enums/medicine_period.dart';
import '../../../../../core/enums/remindable.dart';
import '../../../../../model/mediminder/drug_result_model.dart';

import '../medication_date/view/medication_date_screen.dart';

class MedicationPeriodSelectionScreen extends StatefulWidget {
  DrugResultModel drugResult;
  Remindable remindable;
  @override
  _MedicationPeriodSelectionScreenState createState() =>
      _MedicationPeriodSelectionScreenState();
}

class _MedicationPeriodSelectionScreenState
    extends State<MedicationPeriodSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    widget.drugResult = DrugResultModel.fromJson(
        jsonDecode(Atom.queryParameters['drugResult']));
    widget.remindable = Atom.queryParameters['remindable'].toRemindable();

    return RbioScaffold(
      appbar: RbioAppBar(
        title: RbioAppBar.textTitle(
          context,
          widget.drugResult.name,
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        //
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 15),
          child: Text(LocaleProvider.current.medicine_how_often_message,
              style: context.xHeadline3),
        ),

        //
        Expanded(
          child: _buildList(),
        ),
      ],
    );
  }

  Widget _buildList() {
    List<MedicinePeriod> periodList = [];
    periodList.addAll(MedicinePeriod.values);
    periodList
        .removeWhere((element) => element == MedicinePeriod.INTERMITTENT_DAYS);

    return ListView.builder(
      padding: EdgeInsets.all(8),
      physics: BouncingScrollPhysics(),
      itemCount: periodList.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
            child: ListTile(
              title: Text(
                periodList[index].toShortString(),
                style: context.xHeadline3.copyWith(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Atom.to(PagePaths.MEDICATION_DATE, queryParameters: {
                  'remindable': widget.remindable.toParseableString(),
                  'medicinePeriod':
                      periodList[index].toParseableStringMedicine()
                });

                /*Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MedicationDateScreen(
                      medicinePeriod: periodList[index],
                      remindable: widget.remindable,
                    ),
                    settings: RouteSettings(name: 'NewEntry'),
                  ),
                );*/
              },
            ),
          ),
        );
      },
    );
  }
}
