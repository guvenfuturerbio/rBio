import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/core.dart';
import '../../../core/enums/medicine_period.dart';
import '../../../core/enums/remindable.dart';
import '../../../core/enums/usage_type.dart';
import '../viewmodel/medication_date_vm.dart';

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
      LoggerUtils.instance.i(e);
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
    return RbioScrollbar(
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //
            SizedBox(height: Atom.height * 0.1),

            //
            Text(
              LocaleProvider.current.medicine_usage_type_message,
              style: context.xHeadline3,
              textAlign: TextAlign.center,
            ),

            //
            _buildGap(),

            //
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                for (UsageType usageType in UsageType.values)
                  GestureDetector(
                    onTap: () => {value.setSelectedUsageType(usageType)},
                    child: Container(
                      decoration: BoxDecoration(
                        color: usageType == value.selectedUsageType
                            ? getIt<ITheme>().mainColor
                            : Colors.white,
                        borderRadius: R.sizes.borderRadiusCircular,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          usageType.xToString(),
                          style: context.xHeadline3.copyWith(
                            color: usageType == value.selectedUsageType
                                ? getIt<ITheme>().textColor
                                : getIt<ITheme>().textColorPassive,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            //
            _buildGap(true),

            //
            Text(
              LocaleProvider.current.medicine_how_often_daily_message,
              style: context.xHeadline3,
              textAlign: TextAlign.center,
            ),

            //
            _buildGap(),

            //
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: RbioTextFormField(
                controller: drugDailyCountController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                obscureText: false,
                prefixIcon: SvgPicture.asset(
                  R.image.ic_user,
                  fit: BoxFit.none,
                ),
                hintText: LocaleProvider.current.medicine_daily_count,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9\t\r]'))
                ],
                onFieldSubmitted: (term) {},
                onChanged: (text) {
                  if (text != null && text != '') {
                    value.setDailyCount(text.isNotEmpty ? int.parse(text) : 0);
                  }
                },
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
                      child: RbioTextFormField(
                        controller: drugNameController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        maxLength: 10,
                        hintText: LocaleProvider.current.medicine_name,
                        prefixIcon: SvgPicture.asset(
                          R.image.ic_user,
                          fit: BoxFit.none,
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
                      RbioElevatedButton(
                        infinityWidth: true,
                        title: LocaleProvider.current.confirm,
                        onTap: () {
                          value.createReminderPlan(widget.remindable);
                        },
                      ),

                      //
                      R.sizes.defaultBottomPadding,
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget getErrorContainer(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Text(
        LocaleProvider.current.medicine_daily_count_error_message,
        style: context.xHeadline3.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildGap([bool isLarge = false]) =>
      isLarge ? R.sizes.hSizer32 : R.sizes.hSizer16;

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
          GestureDetector(
            onTap: () => {value.setSelectedDay(index)},
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 5),
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 15,
              ),
              decoration: BoxDecoration(
                color: value.days[index].selected
                    ? getIt<ITheme>().mainColor
                    : getIt<ITheme>().cardBackgroundColor,
                borderRadius: R.sizes.borderRadiusCircular,
              ),
              child: Center(
                child: Text(value.days[index].name,
                    style: context.xHeadline3.copyWith(
                        color: value.days[index].selected
                            ? getIt<ITheme>().textColor
                            : getIt<ITheme>().textColorPassive)),
              ),
            ),
          ),
      ],
    );
  }

  Widget getIntermittentDaysSection(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          LocaleProvider.current.medicine_how_often_intermittent_daily_message,
          style: context.xHeadline3,
        ),

        //
        _buildGap(),

        //
        RbioTextFormField(
          controller: intermittentDrugPerDayController,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          obscureText: false,
          hintText: LocaleProvider.current.medicine_intermittent_daily_count,
          prefixIcon: SvgPicture.asset(
            R.image.ic_user,
            fit: BoxFit.none,
          ),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9\t\r]'))
          ],
          onFieldSubmitted: (term) {},
          onChanged: (text) {},
        ),
      ],
    );
  }

  Widget getTimeAndDoseSection(MedicationDateVm value) {
    return Column(
      children: <Widget>[
        //
        _buildGap(true),

        Text(
          widget.remindable == Remindable.Medication
              ? LocaleProvider.current.medicine_time_and_dose_message
              : LocaleProvider.current.reminder_time_selection,
          style: context.xHeadline3,
          textAlign: TextAlign.center,
        ),

        //
        Visibility(
          visible: widget.remindable == Remindable.Medication,
          child: Container(
            margin: EdgeInsets.all(10),
            child: RbioTextFormField(
              controller: dailyDoseController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              obscureText: false,
              maxLength: 1,
              hintText: LocaleProvider.current.hint_dosage,
              prefixIcon: SvgPicture.asset(
                R.image.ic_user,
                fit: BoxFit.none,
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
        _buildGap(),

        //
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            for (var i = 0; i < value.doseTimes.length; i++)
              _buildTimeCard(i, value.doseTimes[i], value),
          ],
        )
      ],
    );
  }

  Widget _buildTimeCard(
    int index,
    DateTime dateTime,
    MedicationDateVm value,
  ) {
    return GestureDetector(
      onTap: () async {
        var timeOfDay = await _buildMaterialTimePicker(
          TimeOfDay(
            hour: value.doseTimes[index].hour,
            minute: value.doseTimes[index].minute,
          ),
        );

        if (timeOfDay != null) {
          value.setSelectedDoseDate(timeOfDay, index);
        }
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          color: getIt<ITheme>().cardBackgroundColor,
          borderRadius: R.sizes.borderRadiusCircular,
        ),
        child: Column(
          children: <Widget>[
            //
            Text(
              DateFormat('HH:mm').format(dateTime),
              style: context.xHeadline3.copyWith(fontWeight: FontWeight.bold),
            ),

            //
            Text(
              widget.remindable == Remindable.Medication
                  ? ("${value.dailyDose} " + LocaleProvider.current.hint_dosage)
                  : LocaleProvider.current.hint_hour,
              style: context.xHeadline3,
            ),
          ],
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
