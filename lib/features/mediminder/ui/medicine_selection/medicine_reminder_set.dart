import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:onedosehealth/core/locator.dart';
import 'package:onedosehealth/core/theme/main_theme.dart';
import 'package:onedosehealth/core/utils/utils.dart';
import 'package:onedosehealth/core/widgets/rbio_appbar.dart';
import 'package:onedosehealth/core/widgets/rbio_scaffold.dart';
import 'package:onedosehealth/generated/l10n.dart';
import 'package:provider/provider.dart';

import '../../common/convert_time.dart';
import '../../global_bloc.dart';
import '../../models/drug_result.dart';
import '../../models/errors.dart';
import '../../models/medicine.dart';
import '../../models/medicine_type.dart';
import '../homepage/homepage.dart';
import '../homepage/selectedremindable.dart';
import '../new_entry/new_entry_bloc.dart';
import 'medicine_date_time_selection.dart';
import 'medicine_period_selection.dart';

class MedicineReminderSet extends StatefulWidget {
  final DrugResult drugResult;
  final MedicinePeriod medicinePeriod;
  final UsageType usageType;
  final DateTime initialTime;
  final List<SelectableDay> weekDays;
  final int dailyCount;
  final int doseCount;
  final int intermittentDrugPerDay;
  final Remindable selectedRemindable;
  MedicineReminderSet(
      {this.drugResult,
      this.medicinePeriod,
      this.usageType,
      this.intermittentDrugPerDay,
      this.initialTime,
      this.weekDays,
      this.dailyCount,
      this.doseCount,
      this.selectedRemindable});

  @override
  _NewEntryState createState() => _NewEntryState();
}

class _NewEntryState extends State<MedicineReminderSet> {
  TextEditingController nameController;
  TextEditingController dosageController;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  NewEntryBloc _newEntryBloc;

  GlobalKey<ScaffoldState> _scaffoldKey;
  GlobalBloc _globalBloc;

  TextEditingController medicineCountController;
  TextEditingController remindMeAheadOfDaysController;
  TextEditingController medicineNameController;

  final medicineCountFNode = FocusNode();
  final remindMeAheadOfDaysFNode = FocusNode();
  final medicineNameFNode = FocusNode();

  int medicineCount = 30;
  int remindMeAheadOfDaysCount = 1;
  DateTime dateTime = DateTime.now();
  DateTime finishDateTime = DateTime.now();

  String reminderName = "";
  void dispose() {
    super.dispose();
    nameController.dispose();
    dosageController.dispose();
    _newEntryBloc.dispose();
  }

  void initState() {
    super.initState();
    _newEntryBloc = NewEntryBloc();
    nameController = TextEditingController();
    dosageController = TextEditingController();
    medicineCountController = TextEditingController();
    remindMeAheadOfDaysController = TextEditingController();
    medicineNameController = TextEditingController();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    initializeNotifications();
    initializeErrorListen();

    dateTime = widget.initialTime;
    medicineCountController.text = "30";
    remindMeAheadOfDaysController.text = "1";
  }

  @override
  Widget build(BuildContext context) {
    _globalBloc = Provider.of<GlobalBloc>(context);
    calculateMedicineFinishDate(context);
    return RbioScaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appbar: RbioAppBar(
        title: getTitleBar(context),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: KeyboardAvoider(
          child: Container(
            child: Provider<NewEntryBloc>.value(
              value: _newEntryBloc,
              child: ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                children: <Widget>[
                  Visibility(
                      visible:
                          widget.selectedRemindable == Remindable.Medication,
                      child: Center(
                          child: Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          LocaleProvider.current.reminder_name,
                          style: TextStyle(fontSize: 18),
                        ),
                      ))),
                  Visibility(
                      visible:
                          widget.selectedRemindable == Remindable.Medication,
                      child: Center(
                          child: Padding(
                              padding:
                                  EdgeInsets.only(left: 20, right: 20, top: 15),
                              child: TextFormField(
                                controller: medicineNameController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.text,
                                obscureText: false,
                                style: inputTextStyle(),
                                decoration: inputImageDecoration(
                                  hintText:
                                      LocaleProvider.current.reminder_name,
                                  image: R.image.ic_user,
                                ),
                                focusNode: medicineNameFNode,
                                inputFormatters: <TextInputFormatter>[
                                  new TabToNextFieldTextInputFormatter(context,
                                      medicineNameFNode, medicineCountFNode),
                                ],
                                onFieldSubmitted: (term) {
                                  UtilityManager().fieldFocusChange(context,
                                      medicineNameFNode, medicineCountFNode);
                                },
                                onChanged: (text) {
                                  setState(() {
                                    try {
                                      reminderName = text;
                                    } catch (e) {
                                      reminderName = "";
                                    }
                                  });
                                },
                              )))),
                  Center(
                      child: Padding(
                    padding: EdgeInsets.only(top: 25),
                    child: Text(
                      LocaleProvider.current.how_many_reminder_is_needed,
                      style: TextStyle(fontSize: 18),
                    ),
                  )),
                  Center(
                      child: Padding(
                          padding:
                              EdgeInsets.only(left: 20, right: 20, top: 15),
                          child: TextFormField(
                            controller: medicineCountController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            obscureText: false,
                            style: inputTextStyle(),
                            decoration: inputImageDecoration(
                              hintText: LocaleProvider.current.drug_count,
                              image: R.image.ic_user,
                            ),
                            focusNode: medicineCountFNode,
                            inputFormatters: <TextInputFormatter>[
                              new TabToNextFieldTextInputFormatter(
                                  context, medicineCountFNode, null),
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9\t\r]'))
                            ],
                            onFieldSubmitted: (term) {
                              UtilityManager().fieldFocusChange(
                                  context, medicineCountFNode, null);
                            },
                            onChanged: (text) {
                              setState(() {
                                try {
                                  medicineCount = int.parse(text);
                                  calculateMedicineFinishDate(context);
                                } catch (e) {
                                  medicineCount = 1;
                                  calculateMedicineFinishDate(context);
                                }
                              });
                            },
                          ))),
                  Center(
                      child: Padding(
                    padding: EdgeInsets.only(top: 25),
                    child: Text(
                      LocaleProvider.current.medicine_start_date,
                      style: TextStyle(fontSize: 18),
                    ),
                  )),
                  GestureDetector(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Center(
                        child: Container(
                          height: 50,
                          padding: EdgeInsets.only(
                              top: 5, bottom: 5, left: 10, right: 10),
                          child: Center(
                            child: Text(
                              DateFormat('dd MMMM yyyy').format(dateTime),
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  isDrugCountNotSelected()
                      ? getErrorContainer(context)
                      : Column(
                          children: <Widget>[
                            Center(
                                child: Padding(
                              padding: EdgeInsets.only(top: 25),
                              child: Text(
                                LocaleProvider.current.medicine_end_date,
                                style: TextStyle(fontSize: 18),
                              ),
                            )),
                            Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              child: Center(
                                child: Container(
                                  height: 50,
                                  padding: EdgeInsets.only(
                                      top: 5, bottom: 5, left: 20, right: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        DateFormat('dd MMMM yyyy')
                                            .format(finishDateTime),
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                        DateFormat('HH:mm')
                                            .format(finishDateTime),
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.height * 0.08,
                                  right:
                                      MediaQuery.of(context).size.height * 0.08,
                                  top: 25,
                                  bottom: 25),
                              child: Container(
                                width: 150,
                                height: 50,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    primary: getIt<ITheme>().mainColor,
                                    shape: StadiumBorder(),
                                  ),
                                  child: Center(
                                    child: Text(
                                      LocaleProvider.current.confirm,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    saveMedicine(context);
                                  },
                                ),
                              ),
                            ),
                          ],
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isDrugCountNotSelected() {
    try {
      int count = int.parse(medicineCountController.text);
      return medicineCountController.text == "" || count == 0;
    } catch (e) {
      return true;
    }
  }

  Widget getErrorContainer(BuildContext context) {
    return new Container(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Text(
            LocaleProvider.current.medicine_drug_count_error_message,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget getTitleBar(BuildContext context) {
    return TitleAppBarWhite(
        title: widget.drugResult.name + " " + widget.doseCount.toString());
  }

  /// MG11

  void saveMedicine(BuildContext context) async {
    String medicineName;
    int dosage;
    //--------------------Error Checking------------------------
    //Had to do error checking in UI
    //Due to unoptimized BLoC value-grabbing architecture

    if (widget.drugResult.name == "") {
      _newEntryBloc.submitError(EntryError.NameNull);
      return;
    }
    if (widget.drugResult.name != "") {
      medicineName = DateTime.now().millisecondsSinceEpoch.toString();
    }
    if (widget.doseCount != 0) {
      dosage = widget.doseCount;
    }

    for (var medicine in _globalBloc.medicineList$.value) {
      if (medicineName == medicine.medicineName) {
        _newEntryBloc.submitError(EntryError.NameDuplicate);
        return;
      }
    }
    /*if (_newEntryBloc.selectedInterval$.value == 0) {
      _newEntryBloc.submitError(EntryError.Interval);
      return;
    }
    if (_newEntryBloc.selectedTimeOfDay$.value == "None") {
      _newEntryBloc.submitError(EntryError.StartTime);
      return;
    }*/
    //---------------------------------------------------------
    String medicineType = widget.drugResult.name;
    int interval = (24 / widget.dailyCount).round();
    String startTime = DateFormat("HH:mm").format(widget.initialTime);

    List<int> intIDs = makeIDs(24 / interval);

    List<String> notificationIDs =
        intIDs.map((i) => i.toString()).toList(); //for Shared preference

    Medicine newEntryMedicine = Medicine(
        notificationIDs: notificationIDs,
        medicineName: medicineName,
        dosage: dosage,
        medicineType: medicineType,
        interval: interval,
        startTime: startTime,
        medicinePeriod: widget.medicinePeriod);

    _globalBloc.updateMedicineList(newEntryMedicine);
    await scheduleNotification(context, newEntryMedicine);

    Navigator.of(context)
        .popUntil(ModalRoute.withName(Routes.MY_MEDICINES_PAGE));
  }

  void initializeErrorListen() {
    _newEntryBloc.errorState$.listen(
      (error) {
        switch (error) {
          case EntryError.NameNull:
            displayError("Please enter the medicine's name");
            break;
          case EntryError.NameDuplicate:
            displayError("Medicine name already exists");
            break;
          case EntryError.Dosage:
            displayError("Please enter the dosage required");
            break;
          case EntryError.Interval:
            displayError("Please select the reminder's interval");
            break;
          case EntryError.StartTime:
            displayError("Please select the reminder's starting time");
            break;
          case EntryError.NoMedicineSelection:
            displayError("Please select a medicine type");
            break;
          default:
        }
      },
    );
  }

  void displayError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(error),
        duration: Duration(milliseconds: 2000),
      ),
    );
  }

  List<int> makeIDs(double n) {
    var rng = Random();
    List<int> ids = [];
    for (int i = 0; i < n; i++) {
      ids.add(rng.nextInt(1000000000));
    }
    return ids;
  }

  initializeNotifications() async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    await Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => HomePageMediminder()),
    );
  }

  /// MG11
  Future<void> scheduleNotification(
      BuildContext context, Medicine medicine) async {
    var hour = int.parse(medicine.startTime[0] + medicine.startTime[1]);
    var ogValue = hour;
    var minute = int.parse(medicine.startTime[3] + medicine.startTime[4]);

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'repeatDailyAtTime channel id',
      'repeatDailyAtTime channel name',
      'repeatDailyAtTime description',
      importance: Importance.max,
      ledColor: getIt<ITheme>().mainColor,
      ledOffMs: 1000,
      ledOnMs: 1000,
      enableLights: true,
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    int repeatingDayCount = (medicineCount / widget.dailyCount).floor();
    if (widget.medicinePeriod == MedicinePeriod.INTERMITTENT_DAYS) {
      for (int k = 0; k < repeatingDayCount; k++) {
        var scheduledNotificationDateTime = widget.initialTime
            .add(Duration(days: (k * widget.intermittentDrugPerDay)));

        for (int i = 0; i < (24 / medicine.interval).floor(); i++) {
          var dailySchedule = scheduledNotificationDateTime
              .add(new Duration(hours: i * medicine.interval));
          dailySchedule = dailySchedule
              .add(new Duration(seconds: (-1) * (dailySchedule.second)));
          String formattedDate = DateFormat('EEE MMM dd yyyy HH:mm:ss', 'en')
              .format(dailySchedule);
          print(formattedDate);
          int notId = (dailySchedule.millisecondsSinceEpoch / 1000).floor();
          //print(notId);
          // TODO: Send notification information to backend server to be able to restore it when required
          await flutterLocalNotificationsPlugin.schedule(
              notId,
              getNotificationTitle(context),
              getNotificationBody(context),
              dailySchedule,
              platformChannelSpecifics);
        }
      }
    } else {
      for (int i = 0; i < (24 / medicine.interval).floor(); i++) {
        if ((hour + (medicine.interval * i) > 23)) {
          hour = hour + (medicine.interval * i) - 24;
        } else {
          hour = hour + (medicine.interval * i);
        }

        switch (widget.medicinePeriod) {
          case MedicinePeriod.EVERY_DAY:
            // TODO: Send notification information to backend server to be able to restore it when required
            await flutterLocalNotificationsPlugin.showDailyAtTime(
                int.parse(medicine.notificationIDs[i]),
                getNotificationTitle(context),
                getNotificationBody(context),
                Time(hour, minute, 0),
                platformChannelSpecifics);
            break;
          case MedicinePeriod.SPECIFIC_DAYS:
            // TODO: Send notification information to backend server to be able to restore it when required
            for (int ix = 0; ix < widget.weekDays.length; ix++) {
              if (widget.weekDays[ix].selected) {
                await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
                    int.parse(medicine.notificationIDs[i]),
                    getNotificationTitle(context),
                    getNotificationBody(context),
                    getWeekDay(ix),
                    Time(hour, minute, 0),
                    platformChannelSpecifics);
              }
            }
            break;
          case MedicinePeriod.INTERMITTENT_DAYS:
            break;
        }

        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(
              alert: true,
              badge: true,
              sound: true,
            );
        //print(result);
        hour = ogValue;
      }
    }

    //await flutterLocalNotificationsPlugin.cancelAll();
  }

  String getNotificationTitle(BuildContext context) {
    return widget.drugResult.name;
    //return LocaleProvider.current.medicine_reminder_title;
  }

  String getNotificationBody(BuildContext context) {
    return widget.drugResult.name +
        "" +
        LocaleProvider.current.medicine_time_has_come;
  }

  // Helper functions
  void calculateMedicineFinishDate(BuildContext context) {
    switch (widget.medicinePeriod) {
      case MedicinePeriod.EVERY_DAY:
        setState(() {
          finishDateTime = dateTime.add(
              new Duration(days: (medicineCount / widget.dailyCount).floor()));
        });
        break;
      case MedicinePeriod.SPECIFIC_DAYS:
        int dayCount = 0;
        for (SelectableDay sd in widget.weekDays) {
          if (sd.selected) {
            dayCount++;
          }
        }
        int weeklyUsage = dayCount * widget.dailyCount;
        setState(() {
          finishDateTime = dateTime.add(
              new Duration(days: 7 * (medicineCount / weeklyUsage).floor()));
        });
        break;
      case MedicinePeriod.INTERMITTENT_DAYS:
        setState(() {
          finishDateTime = dateTime.add(new Duration(
              days: widget.intermittentDrugPerDay *
                  (medicineCount / widget.dailyCount).floor()));
        });
    }
  }

  Day getWeekDay(int selectableDayIndex) {
    switch (selectableDayIndex) {
      case 0:
        return Day.monday;
      case 1:
        return Day.tuesday;
      case 2:
        return Day.wednesday;
      case 3:
        return Day.thursday;
      case 4:
        return Day.friday;
      case 5:
        return Day.saturday;
      case 6:
        return Day.sunday;
      default:
        throw Exception('getWeekDay');
    }
  }

  // DateTime Picker
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
  }

  /// This builds material date picker in Android
  buildMaterialDatePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(DateTime.now().year - 15),
      lastDate: DateTime(DateTime.now().year + 15),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
    if (picked != null && picked != dateTime)
      setState(() {
        dateTime = DateTime(picked.year, picked.month, picked.day,
            dateTime.hour, dateTime.minute);
        finishDateTime = dateTime.add(new Duration(days: 10));
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
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (picked) {
                if (picked != null && picked != dateTime)
                  setState(() {
                    dateTime = DateTime(picked.year, picked.month, picked.day,
                        dateTime.hour, dateTime.minute);
                    finishDateTime = dateTime.add(new Duration(days: 10));
                  });
              },
              initialDateTime: dateTime,
              minimumYear: 2000,
              maximumYear: 2025,
            ),
          );
        });
  }
}

// OTHERS
class IntervalSelection extends StatefulWidget {
  @override
  _IntervalSelectionState createState() => _IntervalSelectionState();
}

class _IntervalSelectionState extends State<IntervalSelection> {
  var _intervals = [
    6,
    8,
    12,
    24,
  ];
  var _selected = 0;

  @override
  Widget build(BuildContext context) {
    final NewEntryBloc _newEntryBloc = Provider.of<NewEntryBloc>(context);
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "${LocaleProvider.current.remind_me_every}  ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            DropdownButton<int>(
              iconEnabledColor: getIt<ITheme>().mainColor,
              hint: _selected == 0
                  ? Text(
                      "${LocaleProvider.current.select_interval}",
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    )
                  : null,
              elevation: 4,
              value: _selected == 0 ? null : _selected,
              items: _intervals.map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(
                    value.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (newVal) {
                setState(() {
                  _selected = newVal;
                  _newEntryBloc.updateInterval(newVal);
                });
              },
            ),
            Text(
              _selected == 1
                  ? " ${LocaleProvider.current.hour}"
                  : " ${LocaleProvider.current.hours}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectTime extends StatefulWidget {
  @override
  _SelectTimeState createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  TimeOfDay _time = TimeOfDay(hour: 0, minute: 00);
  bool _clicked = false;

  Future<TimeOfDay> _selectTime(BuildContext context) async {
    final NewEntryBloc _newEntryBloc = Provider.of<NewEntryBloc>(context);
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
        _clicked = true;
        _newEntryBloc.updateTime("${convertTime(_time.hour.toString())}" +
            "${convertTime(_time.minute.toString())}");
      });
    }
    return picked;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Padding(
        padding: EdgeInsets.only(top: 10.0, bottom: 4),
        child: TextButton(
          style: TextButton.styleFrom(
            primary: getIt<ITheme>().mainColor,
            shape: StadiumBorder(),
          ),
          onPressed: () {
            _selectTime(context);
          },
          child: Center(
            child: Text(
              _clicked == false
                  ? "${LocaleProvider.current.pick_time}"
                  : "${convertTime(_time.hour.toString())}:${convertTime(_time.minute.toString())}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MedicineTypeColumn extends StatelessWidget {
  final MedicineType type;
  final String name;
  final int iconValue;
  final bool isSelected;

  MedicineTypeColumn(
      {Key key,
      @required this.type,
      @required this.name,
      @required this.iconValue,
      @required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NewEntryBloc _newEntryBloc = Provider.of<NewEntryBloc>(context);
    return GestureDetector(
      onTap: () {
        _newEntryBloc.updateSelectedMedicine(type);
      },
      child: Column(
        children: <Widget>[
          Container(
            width: 85,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isSelected
                  ? getIt<ITheme>().mainColor
                  : getIt<ITheme>().textColor,
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 14.0),
                child: Icon(
                  IconData(iconValue, fontFamily: "Ic"),
                  size: 75,
                  color: isSelected ? Colors.white : getIt<ITheme>().mainColor,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Container(
              width: 80,
              height: 30,
              decoration: BoxDecoration(
                color: isSelected
                    ? getIt<ITheme>().mainColor
                    : getIt<ITheme>().textColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    color:
                        isSelected ? Colors.white : getIt<ITheme>().mainColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PanelTitle extends StatelessWidget {
  final String title;
  final bool isRequired;
  PanelTitle({
    Key key,
    @required this.title,
    @required this.isRequired,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12, bottom: 4),
      child: Text.rich(
        TextSpan(children: <TextSpan>[
          TextSpan(
            text: title,
            style: TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          TextSpan(
            text: isRequired ? " *" : "",
            style: TextStyle(fontSize: 14, color: getIt<ITheme>().mainColor),
          ),
        ]),
      ),
    );
  }
}
