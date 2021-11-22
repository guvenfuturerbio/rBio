import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../common/mediminder_common.dart';

class MedicationPeriodSelectionScreen extends StatefulWidget {
  DrugResultModel drugResult;
  Remindable remindable;

  MedicationPeriodSelectionScreen({
    Key key,
    this.drugResult,
    this.remindable,
  }) : super(key: key);

  @override
  _MedicationPeriodSelectionScreenState createState() =>
      _MedicationPeriodSelectionScreenState();
}

class _MedicationPeriodSelectionScreenState
    extends State<MedicationPeriodSelectionScreen> {
  @override
  Widget build(BuildContext context) {
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
          child: Text(
            LocaleProvider.current.medicine_how_often_message,
            style: TextStyle(fontSize: 16),
          ),
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
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MedicationDateScreen(
                      medicinePeriod: periodList[index],
                      remindable: widget.remindable,
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
}
