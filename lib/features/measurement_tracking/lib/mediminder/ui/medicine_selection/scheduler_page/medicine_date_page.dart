import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:onedosehealth/extension/size_extension.dart';
import 'package:onedosehealth/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../../../../helper/resources.dart';
import '../../../../widgets/utils.dart';
import '../../homepage/selectedremindable.dart';
import '../medicine_period_selection.dart';
import 'medicine_date_page_vm.dart';

/// MG11
class MedicineDatePage extends StatefulWidget {
  final Remindable selectedRemindable;
  final MedicinePeriod medicinePeriod;

  MedicineDatePage({this.medicinePeriod, this.selectedRemindable});
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<MedicineDatePage> {
  final TextEditingController drugDailyCountController =
      new TextEditingController();
  final TextEditingController intermittentDrugPerDayController =
      new TextEditingController();
  final TextEditingController dailyDoseController = new TextEditingController();
  final TextEditingController drugNameController = new TextEditingController();

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MedicineDatePageVm(
          remindable: widget.selectedRemindable,
          medicinePeriod: widget.medicinePeriod,
          context: context),
      child: Consumer<MedicineDatePageVm>(builder: (context, value, child) {
        return Scaffold(
          appBar: CustomAppBar(
              preferredSize: Size.fromHeight(context.HEIGHT * .18),
              title: getTitleBar(context),
              leading: InkWell(
                child: SvgPicture.asset(R.image.back_icon),
                onTap: () =>
                    Navigator.of(context, rootNavigator: true).pop(context),
              )),
          extendBodyBehindAppBar: true,
          body: KeyboardAvoider(
            autoScroll: true,
            child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: context.HEIGHT * .18,
                          ),
                          Center(
                              child: Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: Text(
                              LocaleProvider
                                  .current.medicine_usage_type_message,
                              style: TextStyle(fontSize: 22),
                            ),
                          )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              for (UsageType usageType in UsageType.values)
                                GestureDetector(
                                  onTap: () =>
                                      {value.setSelectedUsageType(usageType)},
                                  child: Card(
                                    elevation: 6,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomRight,
                                            end: Alignment.topLeft,
                                            colors: usageType ==
                                                    value.selectedUsageType
                                                ? <Color>[
                                                    R.btnLightBlue,
                                                    R.btnDarkBlue
                                                  ]
                                                : <Color>[
                                                    Colors.white,
                                                    Colors.white
                                                  ],
                                          ),
                                        ),
                                        child: Text(
                                          UtilityManager()
                                              .getMedicineUsageTypeName(
                                                  context, usageType),
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: usageType ==
                                                      value.selectedUsageType
                                                  ? R.color.white
                                                  : R.color.grey),
                                        )),
                                  ),
                                )
                            ],
                          ),
                          Center(
                              child: Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: Text(
                              LocaleProvider
                                  .current.medicine_how_often_daily_message,
                              style: TextStyle(fontSize: 18),
                            ),
                          )),
                          Center(
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, top: 15),
                                  child: TextFormField(
                                    controller: drugDailyCountController,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    obscureText: false,
                                    maxLength: 2,
                                    style: inputTextStyle(),
                                    decoration: inputImageDecoration(
                                      hintText: LocaleProvider
                                          .current.medicine_daily_count,
                                      image: R.image.ic_user,
                                    ),
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9\t\r]'))
                                    ],
                                    onFieldSubmitted: (term) {},
                                    onChanged: (text) {
                                      value.setDailyCount(text.isNotEmpty
                                          ? int.parse(text)
                                          : 0);
                                    },
                                  ))),
                          Visibility(
                              visible: widget.selectedRemindable ==
                                  Remindable.Medication,
                              child: Column(
                                children: [
                                  Center(
                                      child: Padding(
                                    padding: EdgeInsets.only(top: 15),
                                    child: Text(
                                      LocaleProvider.current.medicine_name,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  )),
                                  Center(
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 20, right: 20, top: 15),
                                          child: TextFormField(
                                            controller: drugNameController,
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.text,
                                            obscureText: false,
                                            maxLength: 10,
                                            style: inputTextStyle(),
                                            decoration: inputImageDecoration(
                                              hintText: LocaleProvider
                                                  .current.medicine_name,
                                              image: R.image.ic_user,
                                            ),
                                            inputFormatters: <
                                                TextInputFormatter>[],
                                            onFieldSubmitted: (term) {},
                                            onChanged: (text) {
                                              value.setDrugName(text);
                                            },
                                          ))),
                                ],
                              )),
                          value.dailyCount == 0
                              ? getErrorContainer(context)
                              : Column(
                                  children: <Widget>[
                                    getTimeAndDoseSection(context, value),
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 30, bottom: 30),
                                      child: getPeriodSection(context,
                                          widget.medicinePeriod, value),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 20, bottom: 20),
                                      child: buttonDarkGradient(
                                          text: LocaleProvider.current.confirm,
                                          onPressed: () {
                                            value.createReminderPlan(
                                                widget.selectedRemindable);
                                          }),
                                    )
                                  ],
                                )
                        ],
                      )),
                )),
          ),
        );
      }),
    );
  }

  Widget getErrorContainer(BuildContext context) {
    return new Container(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          LocaleProvider.current.medicine_daily_count_error_message,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget getPeriodSection(BuildContext context, MedicinePeriod medicinePeriod,
      MedicineDatePageVm value) {
    switch (medicinePeriod) {
      case MedicinePeriod.EVERY_DAY:
        return getEveryDaySection(context);
      case MedicinePeriod.SPECIFIC_DAYS:
        return getSpecificDaysSection(context, value);
      case MedicinePeriod.INTERMITTENT_DAYS:
        return getIntermittentDaysSection(context);
      default:
        throw Exception('getPeriodSection');
    }
  }

  Widget getEveryDaySection(BuildContext context) {
    return new Container();
  }

  Widget getSpecificDaysSection(
      BuildContext context, MedicineDatePageVm value) {
    return new Column(
      children: <Widget>[
        for (var index = 0; index < value.days.length; index++)
          Container(
            height: 56,
            child: GestureDetector(
              onTap: () => {value.setSelectedDay(index)},
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                color:
                    value.days[index].selected ? R.btnLightBlue : R.color.white,
                child: Center(
                    child: Text(
                  value.days[index].name,
                  style: TextStyle(
                      fontSize: 18,
                      color: value.days[index].selected
                          ? R.color.white
                          : R.color.grey),
                )),
              ),
            ),
          )
      ],
    );
  }

  Widget getIntermittentDaysSection(BuildContext context) {
    return new Container(
        child: Column(
      children: <Widget>[
        Center(
            child: Padding(
          padding: EdgeInsets.only(top: 15),
          child: Text(
            LocaleProvider
                .current.medicine_how_often_intermittent_daily_message,
            style: TextStyle(fontSize: 18),
          ),
        )),
        Center(
            child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 15),
                child: TextFormField(
                  controller: intermittentDrugPerDayController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  style: inputTextStyle(),
                  decoration: inputImageDecoration(
                    hintText: LocaleProvider
                        .current.medicine_intermittent_daily_count,
                    image: R.image.ic_user,
                  ),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9\t\r]'))
                  ],
                  onFieldSubmitted: (term) {},
                  onChanged: (text) {},
                ))),
      ],
    ));
  }

  Widget getTimeAndDoseSection(BuildContext context, MedicineDatePageVm value) {
    return new Column(
      children: <Widget>[
        Center(
            child: Padding(
          padding: EdgeInsets.only(top: 15),
          child: Text(
            widget.selectedRemindable == Remindable.Medication
                ? LocaleProvider.current.medicine_time_and_dose_message
                : LocaleProvider.current.reminder_time_selection,
            style: TextStyle(fontSize: 18),
          ),
        )),
        Visibility(
            visible: widget.selectedRemindable == Remindable.Medication,
            child: Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: dailyDoseController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                obscureText: false,
                maxLength: 1,
                style: inputTextStyle(),
                decoration: inputImageDecoration(
                  hintText: LocaleProvider.current.hint_dosage,
                  image: R.image.ic_user,
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9\t\r]'))
                ],
                onFieldSubmitted: (term) {},
                onChanged: (text) {
                  value.setDailyDose(text.isNotEmpty ? int.parse(text) : 1);
                },
              ),
            )),
        Column(
          children: <Widget>[
            for (var i = 0; i < value.doseTimes.length; i++)
              GestureDetector(
                onTap: () async {
                  var timeOfDay = await buildMaterialTimePicker(
                      context,
                      TimeOfDay(
                          hour: value.doseTimes[i].hour,
                          minute: value.doseTimes[i].minute));
                  if (timeOfDay != null) {
                    value.setSelectedDoseDate(timeOfDay, i);
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(top: 5),
                  child: getTimeTable(context, value.doseTimes[i], value),
                ),
              ),
          ],
        )
      ],
    );
  }

  Widget getTimeTable(
      BuildContext context, DateTime dateTime, MedicineDatePageVm value) {
    return new Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Center(
        child: Container(
          padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
          child: Column(
            children: <Widget>[
              Text(
                DateFormat('HH:mm').format(dateTime),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                  widget.selectedRemindable == Remindable.Medication
                      ? ("${value.dailyDose} " +
                          LocaleProvider.current.hint_dosage)
                      : LocaleProvider.current.hint_hour,
                  style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }

  Widget getTitleBar(BuildContext context) {
    return TitleAppBarWhite(
        title: UtilityManager()
            .getMedicinePeriodName(context, widget.medicinePeriod));
  }

  Future<TimeOfDay> buildMaterialTimePicker(
      BuildContext context, TimeOfDay timeOfDay) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
      initialTime: timeOfDay,
      initialEntryMode: TimePickerEntryMode.input,
    );
    return picked;
  }
}
