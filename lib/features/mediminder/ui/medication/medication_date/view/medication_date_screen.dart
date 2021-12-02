import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/core.dart';
import '../../../../../../core/enums/medicine_period.dart';
import '../../../../../../core/enums/remindable.dart';
import '../../../../../../core/enums/usage_type.dart';
import '../viewmodel/medication_date_vm.dart';
import 'package:provider/provider.dart';

class MedicationDateScreen extends StatefulWidget {
  MedicinePeriod medicinePeriod;
  Remindable remindable;

  MedicationDateScreen({
    Key key,
    this.medicinePeriod,
    this.remindable,
  }) : super(key: key);

  @override
  _MedicationDateScreenState createState() => _MedicationDateScreenState();
}

class _MedicationDateScreenState extends State<MedicationDateScreen> {
  TextEditingController drugDailyCountController;
  TextEditingController intermittentDrugPerDayController;
  TextEditingController dailyDoseController;
  TextEditingController drugNameController;

  @override
  void initState() {
    drugDailyCountController = TextEditingController();
    intermittentDrugPerDayController = TextEditingController();
    dailyDoseController = TextEditingController();
    drugNameController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    drugDailyCountController.dispose();
    intermittentDrugPerDayController.dispose();
    dailyDoseController.dispose();
    drugNameController.dispose();

    super.dispose();
  }

  Widget build(BuildContext context) {
    try {
      widget.remindable = Atom.queryParameters['remindable'].toRemindable();
      widget.medicinePeriod =
          Atom.queryParameters['medicinePeriod'].toMedicinePeriod();
    } catch (e) {
      print(e);
    }

    return ChangeNotifierProvider<MedicationDateVm>(
      create: (_) => MedicationDateVm(
        context: context,
        remindable: widget.remindable,
        medicinePeriod: widget.medicinePeriod,
      ),
      child: Consumer<MedicationDateVm>(
        builder: (
          BuildContext _,
          MedicationDateVm value,
          Widget __,
        ) {
          return KeyboardDismissOnTap(
            child: RbioScaffold(
              extendBodyBehindAppBar: true,
              appbar: RbioAppBar(
                title: RbioAppBar.textTitle(
                  context,
                  widget.medicinePeriod.toShortString(),
                ),
              ),
              body: _buildBody(value),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(MedicationDateVm value) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: <Widget>[
            //
            SizedBox(
              height: context.HEIGHT * .18,
            ),

            //
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(LocaleProvider.current.medicine_usage_type_message,
                    style: context.xHeadline3),
              ),
            ),

            //
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                for (UsageType usageType in UsageType.values)
                  GestureDetector(
                    onTap: () => {value.setSelectedUsageType(usageType)},
                    child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft,
                            colors: usageType == value.selectedUsageType
                                ? <Color>[
                                    getIt<ITheme>().secondaryColor,
                                    getIt<ITheme>().mainColor
                                  ]
                                : <Color>[Colors.white, Colors.white],
                          ),
                        ),
                        child: Text(
                          usageType.xToString(),
                          style: context.xHeadline3.copyWith(
                              color: usageType == value.selectedUsageType
                                  ? getIt<ITheme>().textColor
                                  : getIt<ITheme>().textColorPassive),
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            //
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  LocaleProvider.current.medicine_how_often_daily_message,
                  style: context.xHeadline3,
                ),
              ),
            ),

            //
            Center(
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 15),
                child: TextFormField(
                  controller: drugDailyCountController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  maxLength: 2,
                  style: Utils.instance.inputTextStyle(),
                  decoration: Utils.instance.inputImageDecoration(
                    hintText: LocaleProvider.current.medicine_daily_count,
                    image: R.image.ic_user,
                  ),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9\t\r]'))
                  ],
                  onFieldSubmitted: (term) {},
                  onChanged: (text) {
                    if (text != null && text != '') {
                      value
                          .setDailyCount(text.isNotEmpty ? int.parse(text) : 0);
                    }
                  },
                ),
              ),
            ),

            //
            Visibility(
              visible: widget.remindable == Remindable.Medication,
              child: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Text(
                        LocaleProvider.current.medicine_name,
                        style: context.xHeadline3,
                      ),
                    ),
                  ),

                  //
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 15),
                      child: TextFormField(
                        controller: drugNameController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        maxLength: 10,
                        style: Utils.instance.inputTextStyle(),
                        decoration: Utils.instance.inputImageDecoration(
                          hintText: LocaleProvider.current.medicine_name,
                          image: R.image.ic_user,
                        ),
                        inputFormatters: <TextInputFormatter>[],
                        onFieldSubmitted: (term) {},
                        onChanged: (text) {
                          value.setDrugName(text);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //
            value.dailyCount == 0
                ? getErrorContainer(context)
                : Column(
                    children: <Widget>[
                      //
                      getTimeAndDoseSection(value),

                      //
                      Container(
                        margin: EdgeInsets.only(top: 30, bottom: 30),
                        child: getPeriodSection(
                            context, widget.medicinePeriod, value),
                      ),

                      //
                      Container(
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        child: Mediminder.instance.buttonDarkGradient(
                          text: LocaleProvider.current.confirm,
                          onPressed: () {
                            value.createReminderPlan(widget.remindable);
                          },
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget getErrorContainer(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text(LocaleProvider.current.medicine_daily_count_error_message,
            style: context.xHeadline3.copyWith(fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget getPeriodSection(
    BuildContext context,
    MedicinePeriod medicinePeriod,
    MedicationDateVm value,
  ) {
    switch (medicinePeriod) {
      case MedicinePeriod.EVERY_DAY:
        return SizedBox();

      case MedicinePeriod.SPECIFIC_DAYS:
        return getSpecificDaysSection(context, value);

      case MedicinePeriod.INTERMITTENT_DAYS:
        return getIntermittentDaysSection(context);

      default:
        return SizedBox();
    }
  }

  Widget getSpecificDaysSection(BuildContext context, MedicationDateVm value) {
    return Column(
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
                color: value.days[index].selected
                    ? getIt<ITheme>().secondaryColor
                    : getIt<ITheme>().cardBackgroundColor,
                child: Center(
                  child: Text(value.days[index].name,
                      style: context.xHeadline3.copyWith(
                          color: value.days[index].selected
                              ? getIt<ITheme>().textColor
                              : getIt<ITheme>().textColorPassive)),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget getIntermittentDaysSection(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
          child: Padding(
            padding: EdgeInsets.only(top: 15),
            child: Text(
              LocaleProvider
                  .current.medicine_how_often_intermittent_daily_message,
              style: context.xHeadline3,
            ),
          ),
        ),

        //
        Center(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 15),
            child: TextFormField(
              controller: intermittentDrugPerDayController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              obscureText: false,
              style: Utils.instance.inputTextStyle(),
              decoration: Utils.instance.inputImageDecoration(
                hintText:
                    LocaleProvider.current.medicine_intermittent_daily_count,
                image: R.image.ic_user,
              ),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\t\r]'))
              ],
              onFieldSubmitted: (term) {},
              onChanged: (text) {},
            ),
          ),
        ),
      ],
    );
  }

  Widget getTimeAndDoseSection(MedicationDateVm value) {
    return Column(
      children: <Widget>[
        Center(
          child: Padding(
            padding: EdgeInsets.only(top: 15),
            child: Text(
              widget.remindable == Remindable.Medication
                  ? LocaleProvider.current.medicine_time_and_dose_message
                  : LocaleProvider.current.reminder_time_selection,
              style: context.xHeadline3,
            ),
          ),
        ),

        //
        Visibility(
          visible: widget.remindable == Remindable.Medication,
          child: Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: dailyDoseController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              obscureText: false,
              maxLength: 1,
              style: Utils.instance.inputTextStyle(),
              decoration: Utils.instance.inputImageDecoration(
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
          ),
        ),

        //
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            for (var i = 0; i < value.doseTimes.length; i++)
              GestureDetector(
                onTap: () async {
                  var timeOfDay = await _buildMaterialTimePicker(
                    TimeOfDay(
                      hour: value.doseTimes[i].hour,
                      minute: value.doseTimes[i].minute,
                    ),
                  );

                  if (timeOfDay != null) {
                    value.setSelectedDoseDate(timeOfDay, i);
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(top: 5),
                  child: _buildTimeCard(value.doseTimes[i], value),
                ),
              ),
          ],
        )
      ],
    );
  }

  Widget _buildTimeCard(
    DateTime dateTime,
    MedicationDateVm value,
  ) {
    return Card(
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
                style: context.xHeadline3.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                widget.remindable == Remindable.Medication
                    ? ("${value.dailyDose} " +
                        LocaleProvider.current.hint_dosage)
                    : LocaleProvider.current.hint_hour,
                style: context.xHeadline3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<TimeOfDay> _buildMaterialTimePicker(TimeOfDay timeOfDay) async {
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
