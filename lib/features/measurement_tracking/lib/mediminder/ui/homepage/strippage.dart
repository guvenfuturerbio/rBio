import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/extension/size_extension.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../helper/extensions/string_extension.dart';
import '../../../helper/resources.dart';
import '../../../notifiers/stripcount_tracker.dart';
import '../../../types/unit.dart';
import '../../../widgets/strip_counter_dialog.dart';
import '../../../widgets/utils.dart';

class StripPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  final TextEditingController alarmController = TextEditingController();
  StripMode modeOfStrip = StripMode.NONE;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ChangeNotifierProvider<StripCountTracker>.value(
          value: StripCountTracker(context),
          child: Consumer<StripCountTracker>(
            builder: (BuildContext context, stripCount, Widget child) {
              alarmController.text = stripCount.alarmCount.toString();
              controller.text = stripCount.stripCount.toString();
              controller.selection = TextSelection.collapsed(
                  offset: stripCount?.stripCount?.toString()?.length ?? 0);
              alarmController.selection = TextSelection.collapsed(
                  offset: stripCount?.alarmCount?.toString()?.length ?? 0);

              return Scaffold(
                  appBar: CustomAppBar(
                      preferredSize: Size.fromHeight(context.HEIGHT * .18),
                      title: TitleAppBarWhite(
                          title: LocaleProvider.current.strip_tracker),
                      leading: InkWell(
                          child: SvgPicture.asset(R.image.back_icon),
                          onTap: () => Navigator.of(context).pop())),
                  extendBodyBehindAppBar: true,
                  body: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                    child: SingleChildScrollView(
                      child: Column(mainAxisSize: MainAxisSize.max, children: [
                        SizedBox(
                          height: context.HEIGHT * .18,
                        ),
                        xstripsusedwidget(context, stripCount),
                        stripcircle_and_add_decrement(
                            stripCount, context, controller),
                        infomessage1(context),
                        Center(
                            child: Text(
                                LocaleProvider.current.when_to_be_notified,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18))),
                        strip_alarm_setter(stripCount, alarmController),
                        Text(
                          LocaleProvider.current.strips_left,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        save_changes_button(context, stripCount),
                        SizedBox(
                          height: 20,
                        ),
                      ]),
                    ),
                  ));
            },
          )),
    );
  }

  Padding strip_alarm_setter(
      StripCountTracker stripCount, TextEditingController alarmController) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Material(
        elevation: 15,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Container(
          width: 350,
          child: TextField(
            controller: alarmController,
            cursorColor: Colors.black,
            textAlign: TextAlign.center,
            maxLength: 3,
            keyboardType: TextInputType.number,
            obscureText: false,
            decoration: new InputDecoration(
                border: InputBorder.none,
                counterText: "",
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                hintText: "Strip number"),
            onChanged: (String value) {
              print("setAlarmCount onChanged");
              stripCount.setAlarmCount((int.parse(value) ?? 30));
            },
          ),
        ),
      ),
    );
  }

  Container save_changes_button(
      BuildContext context, StripCountTracker stripCount) {
    return Container(
      height: 50,
      width: 150,
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: <Color>[R.btnLightBlue, R.btnDarkBlue],
          ),
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  R.image.done_icon,
                  height: 30,
                  width: 30,
                  //      height: 300,
                ),
                Text(LocaleProvider.current.save,
                    style: TextStyle(color: Colors.white)),
              ],
            ),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                stripCount.updateServer();
              }
            }),
      ),
    );
  }

  Padding infomessage1(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Center(
        child: Text(
          LocaleProvider.current.strip_page_info_message,
          style: TextStyle(
              fontWeight: FontWeight.w100, fontSize: 12, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget stripcircle_and_add_decrement(StripCountTracker stripCount,
      BuildContext context, TextEditingController controller) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 40,
          ),
          CircleAvatar(
            backgroundColor: R.btnDarkBlue,
            radius: 85,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 70,
              child: Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Column(
                  children: [
                    Container(
                        width: 70,
                        child: Theme(
                            data: ThemeData(primaryColor: Colors.black),
                            child: TextFormField(
                                controller: controller,
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                maxLength: 3,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  print(value);
                                  stripCount.changeTo(int.parse(value));
                                },
                                decoration: InputDecoration(
                                  counterText: '',
                                  errorStyle: TextStyle(height: 0),
                                ),
                                validator: (input) {
                                  if (input.isNotEmpty)
                                    return null;
                                  else
                                    return "";
                                }))),
                    SizedBox(
                      height: 9,
                    ),
                    Text(
                      LocaleProvider.current.strips,
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          child: Text(LocaleProvider.current.remove_strips,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black)),
                          onPressed: () {
                            modeOfStrip = StripMode.SUBTRACT;
                            showGradientDialog(
                                context,
                                LocaleProvider.current.remove_strips,
                                stripCount,
                                modeOfStrip);
                          }),
                      Icon(
                        Icons.remove,
                        size: 40,
                        color: R.color.black,
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        size: 40,
                        color: R.color.black,
                      ),
                      TextButton(
                          child: Text(LocaleProvider.current.add_strips,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black)),
                          onPressed: () {
                            modeOfStrip = StripMode.ADD;
                            showGradientDialog(
                                context,
                                LocaleProvider.current.add_strips,
                                stripCount,
                                modeOfStrip);
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  showGradientDialog(BuildContext context, String title,
      StripCountTracker stripCounter, StripMode mos) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return StripGradientDialog(title, (val) {
            if (mos == StripMode.ADD) {
              stripCounter.incrementBy(val);
            } else {
              stripCounter.decrementBy(val);
            }
          });
        });
  }

  Container xstripsusedwidget(
      BuildContext context, StripCountTracker stripCount) {
    return Container(
      padding: EdgeInsets.only(left: 24, right: 24, bottom: 16),
      child: Column(
        children: <Widget>[
          Card(
            color: R.color.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 4,
            child: Container(
              padding:
                  EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    height: 20,
                    width: 20,
                    child: SvgPicture.asset(R.image.mark_icon),
                  ),
                  Expanded(
                    child: Text(
                      stripCount.usedStripCount == 0
                          ? LocaleProvider.current.never_used_strip
                          : LocaleProvider.current.strips_used.format(
                              []..add(stripCount.usedStripCount.toString())),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
