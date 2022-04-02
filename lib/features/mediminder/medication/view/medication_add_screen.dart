import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../mediminder.dart';

class MedicationReminderAddScreen extends StatefulWidget {
  Remindable remindable = Remindable.medication;

  MedicationReminderAddScreen({Key? key}) : super(key: key);

  @override
  _MedicationReminderAddScreenState createState() =>
      _MedicationReminderAddScreenState();
}

class _MedicationReminderAddScreenState
    extends State<MedicationReminderAddScreen> {
  late TextEditingController drugDailyCountController;
  late TextEditingController intermittentDrugPerDayController;
  late TextEditingController dailyDoseController;
  late TextEditingController drugNameController;

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

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MedicationReminderAddVm>(
      create: (_) => MedicationReminderAddVm(
        mContext: context,
        mRemindable: widget.remindable,
        mRotificationManager: getIt<ReminderNotificationsManager>(),
      ),
      child: Consumer<MedicationReminderAddVm>(
        builder: (
          BuildContext context,
          MedicationReminderAddVm vm,
          Widget? child,
        ) {
          return KeyboardDismissOnTap(
            child: RbioStackedScaffold(
              extendBodyBehindAppBar: true,
              appbar: RbioAppBar(
                title: RbioAppBar.textTitle(
                  context,
                  widget.remindable.toShortTitle(),
                ),
              ),
              body: _buildBody(vm),
            ),
          );
        },
      ),
    );
  }

  // #region _buildBody
  Widget _buildBody(MedicationReminderAddVm vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        //
        Expanded(
          child: RbioScrollbar(
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //
                  R.sizes.stackedTopPadding(context),
                  _buildGap(),

                  // Medicine Name
                  _buildMedicineName(vm),

                  // Tags
                  _buildBoldTitle(LocaleProvider.current.select_tag),
                  _buildTags(vm),

                  //
                  _buildGap(),

                  // Periods
                  _buildBoldTitle(LocaleProvider.current.how_often),
                  ExpandablePeriodCard(
                    isReset: vm.mMedicinePeriod == null,
                    onChanged: (value) {
                      vm.setMedicinePeriod(value);
                    },
                  ),

                  //
                  _buildGap(),

                  // How many times a day?
                  if (vm.mMedicinePeriod != null) ...[
                    _buildBoldTitle(
                        LocaleProvider.current.how_many_times_a_day),
                    _buildHowManyTimes(vm),
                  ],

                  //
                  if (vm.mMedicinePeriod ==
                      MedicinePeriod.intermittentDays) ...[
                    _buildIntermittentDaysSection(),
                  ],

                  //
                  vm.dailyCount == 0
                      ? const SizedBox()
                      : Column(
                          children: <Widget>[
                            //
                            _buildGap(),

                            //
                            _buildTimeAndDoseSection(vm),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ),

        if (vm.dailyCount != 0) ...[
          _buildGap(),

          //
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              //
              Expanded(
                child: RbioElevatedButton(
                  backColor: getIt<ITheme>().cardBackgroundColor,
                  textColor: getIt<ITheme>().textColorSecondary,
                  title: LocaleProvider.current.btn_cancel,
                  onTap: () {
                    drugDailyCountController.clear();
                    drugDailyCountController.clear();
                    intermittentDrugPerDayController.clear();
                    dailyDoseController.clear();
                    drugNameController;
                    vm.daysReset();
                    vm.setMedicinePeriod(null);
                    vm.setDailyCount(0);
                  },
                  showElevation: false,
                ),
              ),

              //
              R.sizes.wSizer8,

              //
              Expanded(
                child: RbioElevatedButton(
                  title: LocaleProvider.current.btn_create,
                  onTap: () {
                    vm.createReminderPlan(widget.remindable);
                  },
                  showElevation: false,
                ),
              ),
            ],
          ),

          //
          R.sizes.defaultBottomPadding,
        ],
      ],
    );
  }
  // #endregion

  // #region _buildMedicineName
  Widget _buildMedicineName(MedicationReminderAddVm value) {
    return Visibility(
      visible: widget.remindable == Remindable.medication,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBoldTitle(LocaleProvider.current.medicine_name),

          //
          RbioTextFormField(
            controller: drugNameController,
            // maxLength: 10,
            obscureText: false,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            hintText: LocaleProvider.current.medicine_name,
            onChanged: (text) {
              value.setDrugName(text);
            },
          ),

          //
          _buildGap(),
        ],
      ),
    );
  }
  // #endregion

  // #region _buildTags
  Widget _buildTags(MedicationReminderAddVm value) {
    if (context.xTextScaleType == TextScaleType.small) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: _buildTagCard(
              value,
              R.image.beforeMeal,
              UsageType.hungry,
              false,
            ),
          ),
          R.sizes.wSizer12,
          Expanded(
            child: _buildTagCard(
              value,
              R.image.afterMeal,
              UsageType.full,
              false,
            ),
          ),
          R.sizes.wSizer12,
          Expanded(
            child: _buildTagCard(
              value,
              R.image.otherIcon,
              UsageType.irrelevant,
              false,
            ),
          ),
        ],
      );
    } else {
      return Wrap(
        runSpacing: 5,
        children: [
          _buildTagCard(
            value,
            R.image.beforeMeal,
            UsageType.hungry,
            true,
          ),
          _buildTagCard(
            value,
            R.image.afterMeal,
            UsageType.full,
            true,
          ),
          _buildTagCard(
            value,
            R.image.otherIcon,
            UsageType.irrelevant,
            true,
          )
        ],
      );
    }
  }
  // #endregion

  // #region _buildTagCard
  Widget _buildTagCard(
    MedicationReminderAddVm value,
    String icon,
    UsageType usageType,
    bool isWrap,
  ) {
    final _text = Text(
      usageType.xToString(),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.end,
      style: context.xHeadline4.copyWith(
        color: usageType == value.selectedUsageType
            ? getIt<ITheme>().textColor
            : getIt<ITheme>().textColorPassive,
      ),
    );

    return GestureDetector(
      onTap: () => {value.setSelectedUsageType(usageType)},
      child: Container(
        height: isWrap ? null : 60,
        decoration: BoxDecoration(
          color: usageType == value.selectedUsageType
              ? getIt<ITheme>().mainColor
              : Colors.white,
          borderRadius: R.sizes.borderRadiusCircular,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //
              SvgPicture.asset(
                icon,
                height: R.sizes.iconSize2,
                color: usageType == value.selectedUsageType
                    ? Colors.white
                    : Colors.black,
              ),

              //
              if (isWrap) ...[
                R.sizes.wSizer8,
                _text,
              ] else ...[
                Expanded(child: _text),
              ],
            ],
          ),
        ),
      ),
    );
  }
  // #endregion

  // #region _buildHowManyTimes
  RbioTextFormField _buildHowManyTimes(MedicationReminderAddVm vm) {
    return RbioTextFormField(
      controller: drugDailyCountController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      obscureText: false,
      hintText: LocaleProvider.current.medicine_daily_count,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9\t\r]'))
      ],
      onChanged: (text) {
        if (text != '') {
          vm.setDailyCount(text.isNotEmpty ? int.parse(text) : 0);
        }
      },
    );
  }
  // #endregion

  // #region _buildIntermittentDaysSection
  Widget _buildIntermittentDaysSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //
        _buildGap(),

        _buildBoldTitle(
          LocaleProvider.current.medicine_how_often_intermittent_daily_message,
        ),

        //
        RbioTextFormField(
          controller: intermittentDrugPerDayController,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          obscureText: false,
          hintText: LocaleProvider.current.medicine_intermittent_daily_count,
          prefixIcon: SvgPicture.asset(
            R.image.user,
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
  // #endregion

  // #region _buildTimeAndDoseSection
  Widget _buildTimeAndDoseSection(MedicationReminderAddVm value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //
        _buildBoldTitle(LocaleProvider.current.alert),

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
  // #endregion

  // #region _buildTimeCard
  Widget _buildTimeCard(
    int index,
    DateTime dateTime,
    MedicationReminderAddVm value,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 6),
      margin: EdgeInsets.only(top: index == 0 ? 0 : 8),
      decoration: BoxDecoration(
        color: getIt<ITheme>().cardBackgroundColor,
        borderRadius: R.sizes.borderRadiusCircular,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                DateFormat('HH:mm').format(dateTime),
                style: context.xHeadline3.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          //
          GestureDetector(
            onTap: () async {
              var timeOfDay = await Utils.instance.openMaterialTimePicker(
                context,
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
              color: Colors.transparent,
              padding: const EdgeInsets.all(8),
              child: SvgPicture.asset(
                R.image.otherIcon,
                width: R.sizes.iconSize3,
              ),
            ),
          ),
        ],
      ),
    );
  }
  // #endregion

  // #region _buildBoldTitle
  Widget _buildBoldTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        bottom: 8,
      ),
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: context.xHeadline3.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
  // #endregion

  Widget _buildGap() => R.sizes.hSizer16;
}
