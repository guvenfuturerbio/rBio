import 'package:dart_date/dart_date.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

import '../../../generated/l10n.dart';
import '../../../helper/loading_dialog.dart';
import '../../../helper/resources.dart';
import '../../../services/base_provider.dart';
import '../../../widgets/gradient_dialog.dart';
import '../../../widgets/utils.dart';
import '../../models/drug_result.dart';
import '../homepage/selectedremindable.dart';
import 'medicine_period_selection.dart';
import 'medicine_reminder_set.dart';

class MedicineDateTimeSelection extends StatefulWidget {
  final Remindable selectedRemindable;
  final MedicinePeriod medicinePeriod;
  final DrugResult drugResult;

  MedicineDateTimeSelection(
      {this.medicinePeriod, this.drugResult, this.selectedRemindable});
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<MedicineDateTimeSelection> {
  LoadingDialog loadingDialog;
  final TextEditingController drugDailyCountController =
      new TextEditingController();
  BaseProvider baseProvider;
  List names = [];
  List<String> filteredNames = [];

  String selectedTerm = "";
  UsageType selectedUsageType;
  final drugDailyCountFNode = FocusNode();
  DateTime initialTime = DateTime.now();
  List<DateTime> followingTimes = [];
  int dailyCount = 1;
  int selectedDose = 1;
  int intermittentDrugPerDay = 1;
  final dailyDoseController = new TextEditingController();
  final dailyDoseFNode = FocusNode();
  final intermittentDrugPerDayController = new TextEditingController();
  final intermittentDrugPerDayFNode = FocusNode();
  List<SelectableDay> days;

  @override
  void initState() {
    super.initState();
    setState(() {
      _getToken();
      drugDailyCountController.text = "1";
      selectedUsageType = UsageType.IRRELEVANT;
    });
  }

  Widget build(BuildContext context) {
    if (days == null) {
      days = [];
      days.add(new SelectableDay(
          name: LocaleProvider.current.weekdays_monday, selected: false));
      days.add(new SelectableDay(
          name: LocaleProvider.current.weekdays_tuesday, selected: false));
      days.add(new SelectableDay(
          name: LocaleProvider.current.weekdays_wednesday, selected: false));
      days.add(new SelectableDay(
          name: LocaleProvider.current.weekdays_thursday, selected: false));
      days.add(new SelectableDay(
          name: LocaleProvider.current.weekdays_friday, selected: false));
      days.add(new SelectableDay(
          name: LocaleProvider.current.weekdays_saturday, selected: false));
      days.add(new SelectableDay(
          name: LocaleProvider.current.weekdays_sunday, selected: false));
    }
    return Scaffold(
      appBar: MainAppBar(
          context: context,
          title: getTitleBar(context),
          leading: IconButton(
            icon: SvgPicture.asset(R.image.back_icon),
            onPressed: () =>
                Navigator.of(context, rootNavigator: true).pop(context),
          )),
      body: KeyboardAvoider(
        autoScroll: true,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: getBodyByPeriod(context, widget.medicinePeriod),
        ),
      ),
    );
  }

  Widget getBodyByPeriod(BuildContext context, MedicinePeriod medicinePeriod) {
    return new SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: <Widget>[
              Center(
                  child: Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  LocaleProvider.current.medicine_usage_type_message,
                  style: TextStyle(fontSize: 18),
                ),
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  for (UsageType usageType in UsageType.values)
                    getFullness(usageType, usageType == selectedUsageType)
                ],
              ),
              Center(
                  child: Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  LocaleProvider.current.medicine_how_often_daily_message,
                  style: TextStyle(fontSize: 18),
                ),
              )),
              Center(
                  child: Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 15),
                      child: TextFormField(
                        controller: drugDailyCountController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        style: inputTextStyle(),
                        decoration: inputImageDecoration(
                          hintText: LocaleProvider.current.medicine_daily_count,
                          image: R.image.ic_user,
                        ),
                        focusNode: drugDailyCountFNode,
                        inputFormatters: <TextInputFormatter>[
                          new TabToNextFieldTextInputFormatter(
                              context, drugDailyCountFNode, null),
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9\t\r]'))
                        ],
                        onFieldSubmitted: (term) {
                          UtilityManager().fieldFocusChange(
                              context, drugDailyCountFNode, null);
                        },
                        onChanged: (text) {
                          setState(() {
                            dailyCount = int.parse(text);
                          });
                        },
                      ))),
              isDrugCountNotSelected()
                  ? getErrorContainer(context)
                  : Column(
                      children: <Widget>[
                        getTimeAndDoseSection(context),
                        Container(
                          margin: EdgeInsets.only(top: 30, bottom: 30),
                          child: getPeriodSection(context, medicinePeriod),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20, bottom: 20),
                          child: button(
                              text: LocaleProvider.current.next,
                              onPressed: () {
                                navigateToReminderSetIfCan(context);
                              }),
                        )
                      ],
                    )
            ],
          )),
    );
  }

  void navigateToReminderSetIfCan(BuildContext context) {
    switch (widget.medicinePeriod) {
      case MedicinePeriod.EVERY_DAY:
        break;
      case MedicinePeriod.INTERMITTENT_DAYS:
        if (intermittentDrugPerDayController.text == "" ||
            intermittentDrugPerDay == 0) {
          // Show error
          showGradientDialog(context, LocaleProvider.current.warning,
              LocaleProvider.current.medicine_intermittent_selection_error);
          return;
        }
        break;
      case MedicinePeriod.SPECIFIC_DAYS:
        bool selectedAtLeastOne = false;
        for (var day in days) {
          selectedAtLeastOne = selectedAtLeastOne || day.selected;
        }

        if (!selectedAtLeastOne) {
          // Show error
          showGradientDialog(context, LocaleProvider.current.warning,
              LocaleProvider.current.medicine_specific_days_no_day_error);

          return;
        }
        break;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MedicineReminderSet(
          drugResult: widget.drugResult,
          dailyCount: dailyCount,
          doseCount: selectedDose,
          initialTime: initialTime,
          medicinePeriod: widget.medicinePeriod,
          usageType: selectedUsageType,
          intermittentDrugPerDay: intermittentDrugPerDay,
          weekDays: days,
          selectedRemindable: widget.selectedRemindable,
        ),
        settings: RouteSettings(name: 'MedicineReminderSet'),
      ),
    );
  }

  bool isDrugCountNotSelected() {
    try {
      int count = int.parse(drugDailyCountController.text);
      return drugDailyCountController.text == "" || count == 0;
    } catch (e) {
      return true;
    }
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

  Widget getPeriodSection(BuildContext context, MedicinePeriod medicinePeriod) {
    switch (medicinePeriod) {
      case MedicinePeriod.EVERY_DAY:
        return getEveryDaySection(context);
      case MedicinePeriod.SPECIFIC_DAYS:
        return getSpecificDaysSection(context);
      case MedicinePeriod.INTERMITTENT_DAYS:
        return getIntermittentDaysSection(context);
      default:
        throw Exception('getPeriodSection');
    }
  }

  Widget getEveryDaySection(BuildContext context) {
    return new Container();
  }

  void setSelectedDays(int index) {
    setState(() {
      days[index].selected = !days[index].selected;
    });
  }

  Widget getSpecificDaysSection(BuildContext context) {
    return new Column(
      children: <Widget>[
        for (var index = 0; index < days.length; index++)
          Container(
            height: 56,
            child: GestureDetector(
              onTap: () => {setSelectedDays(index)},
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                color:
                    days[index].selected ? R.color.defaultBlue : R.color.white,
                child: Center(
                    child: Text(
                  days[index].name,
                  style: TextStyle(
                      fontSize: 18,
                      color:
                          days[index].selected ? R.color.white : R.color.grey),
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
                  focusNode: intermittentDrugPerDayFNode,
                  inputFormatters: <TextInputFormatter>[
                    new TabToNextFieldTextInputFormatter(
                        context, intermittentDrugPerDayFNode, null),
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9\t\r]'))
                  ],
                  onFieldSubmitted: (term) {
                    UtilityManager().fieldFocusChange(
                        context, intermittentDrugPerDayFNode, null);
                  },
                  onChanged: (text) {
                    setState(() {
                      intermittentDrugPerDay = int.parse(text);
                    });
                  },
                ))),
      ],
    ));
  }

  Widget getTimeAndDoseSection(BuildContext context) {
    if (dailyCount > 24) {
      dailyCount = 24;
    }
    int perMinute = ((24 * 60) / dailyCount).round();
    int hour = perMinute < 60 ? perMinute : (perMinute / 60).round();
    int minute = perMinute < 60 ? 0 : perMinute - hour * 60;
    followingTimes.clear();
    followingTimes.add(initialTime);
    for (var i = 1; i < dailyCount; i++) {
      followingTimes.add(
          initialTime.add(new Duration(hours: i * hour, minutes: i * minute)));
    }
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
                style: inputTextStyle(),
                decoration: inputImageDecoration(
                  hintText: LocaleProvider.current.hint_dosage,
                  image: R.image.ic_user,
                ),
                focusNode: dailyDoseFNode,
                inputFormatters: <TextInputFormatter>[
                  new TabToNextFieldTextInputFormatter(
                      context, dailyDoseFNode, null),
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9\t\r]'))
                ],
                onFieldSubmitted: (term) {
                  UtilityManager()
                      .fieldFocusChange(context, dailyDoseFNode, null);
                },
                onChanged: (text) {
                  setState(() {
                    if (text == "") {
                      selectedDose = 30;
                    } else {
                      selectedDose = int.parse(text);
                    }
                  });
                },
              ),
            )),
        Column(
          children: <Widget>[
            for (var i = 0; i < followingTimes.length; i++)
              GestureDetector(
                onTap: () => buildMaterialTimePicker(context),
                child: Container(
                  margin: EdgeInsets.only(top: 5),
                  child: getTimeTable(context, followingTimes[i]),
                ),
              ),
          ],
        )
      ],
    );
  }

  Widget getTimeTable(BuildContext context, DateTime dateTime) {
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
                      ? ("$selectedDose " + LocaleProvider.current.hint_dosage)
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

  /*  Widget _buildList() {
    List<MedicinePeriod> periodList = MedicinePeriod.values;
    return ListView.builder(
      itemCount: periodList.length,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
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
                  builder: (context) => NewEntry(),
                  settings: RouteSettings(name: 'NewEntry'),
                ),
              );
            },
          ),
        );
      },
    );
  } */

  showGradientDialog(BuildContext context, String title, String text) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return GradientDialog(title, text);
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

  void _getToken() async {
    baseProvider = BaseProvider.create("");
  }

  void setSelectedFullness(UsageType usageType) {
    setState(() {
      selectedUsageType = usageType;
    });
  }

  Widget getFullness(UsageType usageType, bool selected) {
    return new Container(
        margin: EdgeInsets.only(top: 10),
        height: 45,
        width: 100,
        child: GestureDetector(
          onTap: () => {setSelectedFullness(usageType)},
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            color: selected ? R.color.defaultBlue : R.color.white,
            child: Center(
                child: Text(
              UtilityManager().getMedicineUsageTypeName(context, usageType),
              style: TextStyle(
                  fontSize: 16, color: selected ? R.color.white : R.color.grey),
            )),
          ),
        ));
  }

/*   // DateTime Picker
  void _selectDate(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    assert(theme.platform != null);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return buildMaterialDatePicker(context);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return buildCupertinoDatePicker(context);
    }
  } */

  buildMaterialTimePicker(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != initialTime)
      setState(() {
        initialTime = initialTime.setHour(picked.hour);
        initialTime = initialTime.setMinute(picked.minute);
      });
  }

  /* buildCupertinoTimePicker(BuildContext context) async {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
          height: 500,
          color: Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              Container(
                height: 400,
                child: CupertinoDatePicker(
                  mode:CupertinoDatePickerMode.time,
                    initialDateTime: DateTime.now(),
                    onDateTimeChanged: (val) {
                      setState(() {
                        initialTimeOfDay = val.;
                      });
                    }),
              ),

              // Close the modal
              CupertinoButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          ),
        ));
  }*/
  /// This builds material date picker in Android
  buildMaterialDatePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: initialTime,
      initialEntryMode: DatePickerEntryMode.calendar,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
    if (picked != null && picked != initialTime)
      setState(() {
        initialTime = picked;
      });
  }

  /// This builds cupertion date picker in iOS
  buildCupertinoDatePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
                use24hFormat: true,
                mode: CupertinoDatePickerMode.time,
                onDateTimeChanged: (picked) {
                  if (picked != null && picked != initialTime)
                    setState(() {
                      initialTime = picked;
                    });
                },
                initialDateTime: initialTime),
          );
        });
  }
}

class SelectableDay {
  String name;
  bool selected;
  SelectableDay({this.name, this.selected});
}
