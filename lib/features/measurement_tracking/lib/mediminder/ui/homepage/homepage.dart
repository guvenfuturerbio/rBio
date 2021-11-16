import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/extension/size_extension.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../helper/resources.dart';
import '../../../widgets/utils.dart';
import '../../global_bloc.dart';
import 'remindablescard.dart';
import 'selectedremindable.dart';

class HomePageMediminder extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePageMediminder> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);

    return Scaffold(
      appBar: CustomAppBar(
          preferredSize: Size.fromHeight(context.HEIGHT * .18),
          title: TitleAppBarWhite(title: LocaleProvider.current.reminders),
          leading: InkWell(
              child: SvgPicture.asset(R.image.back_icon),
              onTap: () => Navigator.of(context).pop())),
      body: Provider<GlobalBloc>.value(
        child: BottomContainer(),
        value: _globalBloc,
      ),
    );
  }

  // Helper Components

  Widget getWeekdays(BuildContext context) {
    var daysOfTheWeek = [
      LocaleProvider.current.weekdays_monday,
      LocaleProvider.current.weekdays_tuesday,
      LocaleProvider.current.weekdays_wednesday,
      LocaleProvider.current.weekdays_thursday,
      LocaleProvider.current.weekdays_friday,
      LocaleProvider.current.weekdays_saturday,
      LocaleProvider.current.weekdays_sunday,
    ];
    DateTime date = DateTime.now();
    List<String> dayNumbers = [];
    List<String> dayNames = [];

    for (var i = 0; i < 7; i++) {
      DateTime currentDate = date.add(new Duration(days: i));
      dayNames.add(daysOfTheWeek[currentDate.weekday - 1]);
      dayNumbers.add(currentDate.day.toString());
    }

    return new Flexible(
      flex: 1,
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          child: new ListView.builder(
              itemCount: dayNumbers.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext ctxt, int index) {
                return new Padding(
                  padding: EdgeInsets.only(right: 5, left: 5),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text(dayNames[index]),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        child: Text(dayNumbers[index],
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24)),
                        decoration: BoxDecoration(
                            gradient: index == 0
                                ? LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.topRight,
                                    colors: [
                                        R.color.defaultBlue,
                                        R.color.defaultBlue
                                      ])
                                : LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.topRight,
                                    colors: [
                                        R.color.light_blue,
                                        R.color.light_blue
                                      ]),
                            shape: BoxShape.circle,
                            color: R.color.defaultBlue),
                      )
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}

class BottomContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      padding: EdgeInsets.only(top: 6),
      children: [
        RemindableCard(R.image.blood_icon_black, Remindable.BloodGlucose),
        RemindableCard(R.image.strip_icon_black, Remindable.Strip),
        RemindableCard(R.image.medicine_icon_black, Remindable.Medication),
        RemindableCard(R.image.hba1c_icon_black, Remindable.HbA1c),
      ],
    );
  }
}

/*


  // Helper functions
  showConfirmationAlertDialog(
      BuildContext context, String title, String text, Widget okButton) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: R.color.blue,
            title: Text(
              title,
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            actions: [
              okButton,
            ],
            content: Container(
              padding: const EdgeInsets.all(16.0),
              /*decoration: new BoxDecoration(
            gradient: BlueGradient()),*/
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Text(text,
                      style: new TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Roboto',
                        color: Colors.white,
                      )),
                ],
              ),
            ),
            contentPadding: EdgeInsets.all(0.0),
          );
        });
  }

  void deleteMedicine(BuildContext context, Medicine medicine) {
    final GlobalBloc _globalBloc =
        Provider.of<GlobalBloc>(context, listen: false);
    _globalBloc.removeMedicine(medicine);
    Navigator.of(context).pop();
  }
}*/
