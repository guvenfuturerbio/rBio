import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:onedosehealth/extension/size_extension.dart';
import 'package:onedosehealth/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:provider/provider.dart';

import '../../../doctor/utils/progress/progress_dialog.dart';
import '../../../generated/l10n.dart';
import '../../../helper/resources.dart';
import '../../../widgets/gradient_dialog.dart';
import '../../../widgets/utils.dart';
import '../../models/hba1c_for_schedule.dart';
import 'hba1c_vm.dart';
import 'selectedremindable.dart';

class HbA1cPage extends StatelessWidget {
  HbA1cPage({Key key, this.hba1cIdForNotification, this.remindable})
      : super(key: key);
  final int hba1cIdForNotification;
  final Remindable remindable;
  static ProgressDialog progressDialog;
  TextEditingController controller = TextEditingController();
  Hba1CForSchedule currentHbaModel;

  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Hba1cViewModel>.value(
      value: Hba1cViewModel(context, this.remindable),
      child: Consumer<Hba1cViewModel>(
        builder: (BuildContext context, hba1cVM, Widget child) {
          return Scaffold(
              backgroundColor: Colors.grey[300],
              appBar: CustomAppBar(
                  preferredSize: Size.fromHeight(context.HEIGHT * .18),
                  title: TitleAppBarWhite(
                      title: LocaleProvider.current.hbA1c_measurement),
                  leading: InkWell(
                      child: SvgPicture.asset(R.image.back_icon),
                      onTap: () => Navigator.of(context).pop())),
              body: Container(
                width: double.infinity,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.WIDTH * .03,
                        ),
                        child: Container(
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: R.color.white,
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () {
                              hba1cVM.setLastMeasurementDate(
                                  DateTime.now().toString());
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext builder) {
                                    return Container(
                                      height: 300,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 40,
                                            child: Card(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                            LocaleProvider.of(
                                                                    context)
                                                                .cancel)),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8.0),
                                                    child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                            LocaleProvider.of(
                                                                    context)
                                                                .pick)),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                              height: 260,
                                              child: CupertinoDatePicker(
                                                mode: CupertinoDatePickerMode
                                                    .date,
                                                initialDateTime: DateTime.now()
                                                    .add(Duration(minutes: 5)),
                                                onDateTimeChanged:
                                                    (DateTime newDate) {
                                                  hba1cVM
                                                      .setLastMeasurementDate(
                                                          newDate.toString());
                                                },
                                                use24hFormat: true,
                                                maximumDate: DateTime.now()
                                                    .add(Duration(minutes: 5)),
                                                minuteInterval: 1,
                                              )),
                                        ],
                                      ),
                                    );
                                  });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(LocaleProvider.current.last_test_date,
                                    style: TextStyle(color: R.grey)),
                                Text(
                                  hba1cVM.lastMeasurementDate == ""
                                      ? ""
                                      : hba1cVM.lastMeasurementDate
                                          .substring(0, 10),
                                  style: TextStyle(color: R.color.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: context.HEIGHT * .03,
                          horizontal: context.WIDTH * .03,
                        ),
                        child: Container(
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: R.color.white,
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () {
                              controller = TextEditingController(text: "");
                              showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                          title: Text(
                                              '${LocaleProvider.current.test_result}'),
                                          content: TextFormField(
                                            controller: controller,
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'^(\d+)?\.?\d{0,2}'))
                                            ],
                                            textAlign: TextAlign.center,
                                            keyboardType: TextInputType.number,
                                          ),
                                          actions: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25.0),
                                                gradient: LinearGradient(
                                                  begin: Alignment.bottomRight,
                                                  end: Alignment.topLeft,
                                                  colors: <Color>[
                                                    R.btnLightBlue,
                                                    R.btnDarkBlue
                                                  ],
                                                ),
                                              ),
                                              child: TextButton(
                                                  style: TextButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25.0),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      SvgPicture.asset(
                                                        R.image.done_icon,
                                                        height: 30,
                                                        width: 30,
                                                        //      height: 300,
                                                      ),
                                                      Text(
                                                          LocaleProvider
                                                              .current.done,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
                                                    ],
                                                  ),
                                                  onPressed: () {
                                                    if (controller.text.length >
                                                        0)
                                                      hba1cVM.setPreviousResult(
                                                          double.parse(
                                                              controller.text));
                                                    Navigator.pop(context);
                                                  }),
                                            )
                                          ]));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(LocaleProvider.current.last_result,
                                    style: TextStyle(color: R.grey)),
                                Text(
                                    (Intl.getCurrentLocale() == "tr"
                                            ? "% ${hba1cVM.previousResult.toString()}"
                                            : "${hba1cVM.previousResult.toString()} %") ??
                                        LocaleProvider.current.unspecified,
                                    style: TextStyle(color: Colors.black))
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.WIDTH * .03,
                        ),
                        child: Container(
                          child: Text(
                              LocaleProvider.current.if_want_to_be_reminded),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: context.HEIGHT * .03,
                          horizontal: context.WIDTH * .03,
                        ),
                        child: Container(
                          height: 50,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: R.color.white,
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(LocaleProvider.current.reminder_date,
                                      style: TextStyle(color: R.grey)),
                                  Text(
                                      (hba1cVM.remindDate == "")
                                          ? ""
                                          : hba1cVM.remindDate
                                              .toString()
                                              .substring(0, 16),
                                      style: TextStyle(color: R.color.black))
                                ],
                              ),
                              onPressed: () {
                                hba1cVM.setRemind((DateTime.now()
                                    .add(Duration(minutes: 5))
                                    .toString()));

                                ///MG11
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext builder) {
                                      return Container(
                                        height: 300,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 40,
                                              child: Card(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: GestureDetector(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                              LocaleProvider.of(
                                                                      context)
                                                                  .cancel)),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8.0),
                                                      child: GestureDetector(
                                                          onTap: () {
                                                            //print(birthdateselection);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                              LocaleProvider.of(
                                                                      context)
                                                                  .pick)),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                                height: 260,
                                                child: new CupertinoDatePicker(
                                                  mode: CupertinoDatePickerMode
                                                      .dateAndTime,
                                                  initialDateTime:
                                                      DateTime.now().add(
                                                          Duration(minutes: 6)),
                                                  onDateTimeChanged:
                                                      (DateTime newdate) {
                                                    hba1cVM.setRemind(
                                                        newdate.toString());
                                                  },
                                                  use24hFormat: true,
                                                  minimumDate: DateTime.now()
                                                      .add(
                                                          Duration(minutes: 5)),
                                                  maximumDate: DateTime.now()
                                                      .add(new Duration(
                                                          days: 1500)),
                                                  minuteInterval: 1,
                                                )),
                                          ],
                                        ),
                                      );
                                    });
                              }),
                        ),
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          gradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft,
                            colors: <Color>[R.btnLightBlue, R.btnDarkBlue],
                          ),
                        ),
                        child: TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
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
                                Text(LocaleProvider.current.done,
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                            onPressed: () {
                              if (hba1cVM.remindDate == null ||
                                  hba1cVM.lastMeasurementDate == null) {
                                showInformationDialog(
                                    LocaleProvider.current.fill_all_field,
                                    context);
                              } else {
                                currentHbaModel = Hba1CForSchedule(
                                    id: hba1cIdForNotification,
                                    lastTestDate:
                                        hba1cVM.lastMeasurementDate.toString(),
                                    lastTestValue: controller.text,
                                    reminderDate:
                                        hba1cVM.remindDate.toString());
                                hba1cVM.setRemindDate(currentHbaModel);
                                Navigator.of(context).pop();
                              }
                            }),
                      )
                    ]),
              ));
        },
      ),
    );
  }

  showInformationDialog(String text, BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return GradientDialog(LocaleProvider.current.warning, text);
        });
  }
}
