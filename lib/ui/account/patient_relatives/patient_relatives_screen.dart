import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/src/core/extended_context.dart';

import '../../../core/core.dart';
import '../../../model/model.dart';
import 'patient_relatives_vm.dart';

class PatientRelativesScreen extends StatelessWidget {
  final focus = FocusNode();

  final TextEditingController relativeTcNo = new TextEditingController();
  final TextEditingController relativeName = new TextEditingController();
  final TextEditingController relativeSurname = new TextEditingController();

  DateTime selectedDate = DateTime.now();

  // Main Components
  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics().setCurrentScreen(screenName: 'patient_relative_add');

    return ChangeNotifierProvider<PatientRelativesScreenVm>(
      create: (context) => PatientRelativesScreenVm(context),
      child: Consumer<PatientRelativesScreenVm>(
        builder: (context, vm, child) {
          return Scaffold(
            appBar: MainAppBar(
              context: context,
              title: getTitleBar(context),
              leading: ButtonBackWhite(context),
            ),
            body: _builBody(context, vm),
          );
        },
      ),
    );
  }

  Widget _builBody(BuildContext context, PatientRelativesScreenVm vm) {
    if (vm.status == LoadingStatus.done) {
      return _buildRelatives(context, vm.userAccount, vm);
    } else {
      // Show a loading indicator while waiting for the posts
      return Center(
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(R.color.dark_blue),
        ),
      );
    }
  }

  Widget _buildRelatives(BuildContext context, UserAccount userAccount,
      PatientRelativesScreenVm vm) {
    return SafeArea(
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Atom.to(PagePaths.ADDPATIENTRELATIVES);
              },
              backgroundColor: R.color.blue,
              child: Icon(
                Icons.add,
                color: R.color.white,
              ),
            ),
            body: new Container(
              // TAB RIGHT
              margin: EdgeInsets.only(left: 10, right: 10),
              child: KeyboardAvoider(
                autoScroll: true,
                child: Column(
                  children: <Widget>[
                    for (var i in vm.patientRelativeInfo.patientRelatives)
                      this.buildRelativeCardContainer(context, i, vm)
                  ],
                ),
              ),
            )));
  }

  Widget buildRelativeCardContainer(BuildContext context,
      PatientRelative patientRelative, PatientRelativesScreenVm vm) {
    return GestureDetector(
      onTap: () => showConfirmationAlertDialog(
          context,
          LocaleProvider.of(context).warning,
          LocaleProvider.of(context).relative_change_message,
          FlatButton(
            child: Text(LocaleProvider.of(context).Ok),
            textColor: Colors.white,
            onPressed: () {
              vm.changeUserToRelative(patientRelative, context);
            },
          )),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 10),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Card(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              vm.userAccount.nationality == "TC"
                                  ? LocaleProvider.of(context)
                                      .tc_identity_number
                                  : LocaleProvider.of(context).passport_number,
                              style:
                                  TextStyle(color: R.color.grey, fontSize: 16),
                            ),
                            GestureDetector(
                              onTap: () => showConfirmationAlertDialog(
                                  context,
                                  LocaleProvider.of(context)
                                      .delete_relative_title,
                                  LocaleProvider.of(context)
                                      .delete_relative_confirm_message,
                                  FlatButton(
                                    child: Text(LocaleProvider.of(context).Ok),
                                    textColor: Colors.white,
                                    onPressed: () {
                                      vm.deleteRelative(
                                          patientRelative, context);
                                    },
                                  )),
                              child: SvgPicture.asset(R.image.ic_delete_red),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.zero,
                          child: Text(
                            patientRelative.tcNo,
                            style:
                                TextStyle(color: R.color.black, fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  LocaleProvider.of(context).name,
                                  style: TextStyle(
                                      color: R.color.grey, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.zero,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  patientRelative.name +
                                      " " +
                                      patientRelative.surname,
                                  style: TextStyle(
                                      color: R.color.black, fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 10),
                            child: button(
                                text:
                                    LocaleProvider.of(context).select_relative,
                                onPressed: () {
                                  showConfirmationAlertDialog(
                                      context,
                                      LocaleProvider.of(context).warning,
                                      LocaleProvider.of(context)
                                          .relative_change_message,
                                      FlatButton(
                                        child:
                                            Text(LocaleProvider.of(context).Ok),
                                        textColor: Colors.white,
                                        onPressed: () {
                                          vm.changeUserToRelative(
                                              patientRelative, context);
                                        },
                                      ));
                                })),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
  // END Main Components

  // Helper Components
  Widget getTitleBar(BuildContext context) {
    return TitleAppBarWhite(title: LocaleProvider.of(context).saved_relatives);
  }

  void showConfirmationAlertDialog(
    BuildContext context,
    String title,
    String text,
    Widget okButton,
  ) {
    Widget cancelBtn = FlatButton(
      child: Text(LocaleProvider.of(context).btn_cancel),
      textColor: Colors.white,
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return GuvenAlert(
            title: Text(
              title,
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
            actions: [
              cancelBtn,
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
          );
        });
  }

  Gradient BlueGradient() => LinearGradient(
      colors: [R.color.blue, R.color.light_blue],
      begin: Alignment.bottomLeft,
      end: Alignment.centerRight);
  // END Helper Components

  /*
  static const platform = const MethodChannel('samples.flutter.dev/battery');
  String _batteryLevel = 'Unknown battery level.';

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel', {"isDebug": true});
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    print("BATTERY LEVEL => " + batteryLevel);
    setState(() {
      _batteryLevel = batteryLevel;
    });
  }
  */

  // END Relative Operations
}
