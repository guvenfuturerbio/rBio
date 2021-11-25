import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:onedosehealth/core/enums/remindable.dart';
import 'package:onedosehealth/features/mediminder/ui/hba1c/add_hba1c/viewmodel/hba1c_reminder_add_vm.dart';
import 'package:onedosehealth/model/mediminder/hba1c_for_schedule_model.dart';
import 'package:provider/provider.dart';

class Hba1cReminderAddScreen extends StatelessWidget {
  int hba1cIdForNotification;
  Remindable remindable;

  Hba1cReminderAddScreen({
    Key key,
    this.hba1cIdForNotification,
    this.remindable,
  }) : super(key: key);

  static ProgressDialog progressDialog;
  TextEditingController controller = TextEditingController();
  Hba1CForScheduleModel currentHbaModel;

  Widget build(BuildContext context) {
    this.remindable = Atom.queryParameters['remindable'].toRemindable();
    this.hba1cIdForNotification =
        int.parse(Atom.queryParameters['hba1cIdForNotification']);

    return ChangeNotifierProvider<Hba1cReminderAddVm>(
      create: (context) => Hba1cReminderAddVm(context, this.remindable),
      child: Consumer<Hba1cReminderAddVm>(
        builder: (
          BuildContext context,
          Hba1cReminderAddVm hba1cVM,
          Widget child,
        ) {
          return RbioScaffold(
            appbar: RbioAppBar(
              title: RbioAppBar.textTitle(
                context,
                LocaleProvider.current.hbA1c_measurement,
              ),
            ),
            body: _buildBody(context, hba1cVM),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, Hba1cReminderAddVm hba1cVM) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        //
        _buildLastTestDate(context, hba1cVM),

        //
        _buildLastTestValue(context, hba1cVM),

        //
        _buildDescription(context),

        //
        _buildReminderDate(context, hba1cVM),

        //
        _buildSubmitButton(hba1cVM, context),
      ],
    );
  }

  Widget _buildLastTestDate(BuildContext context, Hba1cReminderAddVm hba1cVM) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.WIDTH * .03,
      ),
      child: Container(
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: getIt<ITheme>().cardBackgroundColor,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: () {
            hba1cVM.setLastMeasurementDate(DateTime.now().toString());
            showModalBottomSheet(
              context: context,
              builder: (BuildContext builder) {
                return Container(
                  height: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 40,
                        child: Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Atom.historyBack();
                                  },
                                  child: Text(
                                    LocaleProvider.of(context).cancel,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Atom.historyBack();
                                  },
                                  child: Text(
                                    LocaleProvider.of(context).pick,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 260,
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.date,
                          initialDateTime:
                              DateTime.now().add(Duration(minutes: 5)),
                          onDateTimeChanged: (DateTime newDate) {
                            hba1cVM.setLastMeasurementDate(newDate.toString());
                          },
                          use24hFormat: true,
                          maximumDate: DateTime.now().add(Duration(minutes: 5)),
                          minuteInterval: 1,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(LocaleProvider.current.last_test_date,
                  style:
                      context.xHeadline3.copyWith(color: getIt<ITheme>().grey)),
              Text(
                hba1cVM.lastMeasurementDate == ""
                    ? ""
                    : hba1cVM.lastMeasurementDate.substring(0, 10),
                style: context.xHeadline3
                    .copyWith(color: getIt<ITheme>().textColorSecondary),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLastTestValue(BuildContext context, Hba1cReminderAddVm hba1cVM) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: context.HEIGHT * .03,
        horizontal: context.WIDTH * .03,
      ),
      child: Container(
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: getIt<ITheme>().cardBackgroundColor,
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
              builder: (BuildContext context) => AlertDialog(
                title: Text('${LocaleProvider.current.test_result}'),
                content: TextFormField(
                  controller: controller,
                  style:
                      context.xHeadline1.copyWith(fontWeight: FontWeight.bold),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^(\d+)?\.?\d{0,2}'))
                  ],
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                ),
                actions: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                        colors: <Color>[
                          getIt<ITheme>().secondaryColor,
                          getIt<ITheme>().mainColor,
                        ],
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
                              style: context.xHeadline3
                                  .copyWith(color: getIt<ITheme>().textColor)),
                        ],
                      ),
                      onPressed: () {
                        if (controller.text.length > 0)
                          hba1cVM
                              .setPreviousResult(double.parse(controller.text));
                        Atom.historyBack();
                      },
                    ),
                  ),
                ],
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(LocaleProvider.current.last_result,
                  style:
                      context.xHeadline3.copyWith(color: getIt<ITheme>().grey)),
              Text(
                (Intl.getCurrentLocale() == "tr"
                        ? "% ${hba1cVM.previousResult.toString()}"
                        : "${hba1cVM.previousResult.toString()} %") ??
                    LocaleProvider.current.unspecified,
                style: context.xHeadline3
                    .copyWith(color: getIt<ITheme>().textColorSecondary),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.WIDTH * .03,
      ),
      child: Container(
        child: Text(LocaleProvider.current.if_want_to_be_reminded),
      ),
    );
  }

  Widget _buildReminderDate(BuildContext context, Hba1cReminderAddVm hba1cVM) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: context.HEIGHT * .03,
        horizontal: context.WIDTH * .03,
      ),
      child: Container(
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: getIt<ITheme>().cardBackgroundColor,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(LocaleProvider.current.reminder_date,
                  style:
                      context.xHeadline3.copyWith(color: getIt<ITheme>().grey)),
              Text(
                  (hba1cVM.remindDate == "")
                      ? ""
                      : hba1cVM.remindDate.toString().substring(0, 16),
                  style: context.xHeadline3
                      .copyWith(color: getIt<ITheme>().textColorSecondary))
            ],
          ),
          onPressed: () {
            hba1cVM.setRemindDate(
                (DateTime.now().add(Duration(minutes: 5)).toString()));

            ///MG11
            showModalBottomSheet(
              context: context,
              builder: (BuildContext builder) {
                return Container(
                  height: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 40,
                        child: Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Atom.historyBack();
                                  },
                                  child: Text(
                                    LocaleProvider.of(context).cancel,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    //print(birthdateselection);
                                    Atom.historyBack();
                                  },
                                  child: Text(
                                    LocaleProvider.of(context).pick,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 260,
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.dateAndTime,
                          initialDateTime:
                              DateTime.now().add(Duration(minutes: 6)),
                          onDateTimeChanged: (DateTime newdate) {
                            if (newdate != null) {
                              hba1cVM.setRemindDate(newdate.toString());
                            }
                          },
                          use24hFormat: true,
                          minimumDate: DateTime.now().add(Duration(minutes: 5)),
                          maximumDate:
                              DateTime.now().add(new Duration(days: 1500)),
                          minuteInterval: 1,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildSubmitButton(Hba1cReminderAddVm hba1cVM, BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: <Color>[
            getIt<ITheme>().secondaryColor,
            getIt<ITheme>().mainColor,
          ],
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
            ),
            Text(
              LocaleProvider.current.done,
              style:
                  context.xHeadline3.copyWith(color: getIt<ITheme>().textColor),
            ),
          ],
        ),
        onPressed: () {
          if (hba1cVM.remindDate == null ||
              hba1cVM.lastMeasurementDate == null) {
            showInformationDialog(
              LocaleProvider.current.fill_all_field,
              context,
            );
          } else {
            currentHbaModel = Hba1CForScheduleModel(
              id: hba1cIdForNotification,
              lastTestDate: hba1cVM.lastMeasurementDate.toString(),
              lastTestValue: controller.text,
              reminderDate: hba1cVM.remindDate.toString(),
            );
            hba1cVM.createNotification(currentHbaModel);
            Atom.historyBack();
          }
        },
      ),
    );
  }

  void showInformationDialog(String text, BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return GradientDialog(LocaleProvider.current.warning, text);
      },
    );
  }
}
