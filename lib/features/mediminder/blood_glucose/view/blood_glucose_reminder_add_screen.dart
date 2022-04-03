import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../mediminder.dart';

class BloodGlucoseReminderAddScreen extends StatefulWidget {
  Remindable remindable = Remindable.bloodGlucose;

  BloodGlucoseReminderAddScreen({Key? key}) : super(key: key);

  @override
  _BloodGlucoseReminderAddScreenState createState() =>
      _BloodGlucoseReminderAddScreenState();
}

class _BloodGlucoseReminderAddScreenState
    extends State<BloodGlucoseReminderAddScreen> {
  late TextEditingController dailyDoseController;

  int? createdDate;
  bool get isCreated => createdDate == null;

  @override
  void initState() {
    dailyDoseController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    dailyDoseController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      final routeParam = Atom.queryParameters['createdDate'];
      if (routeParam != null) {
        createdDate = int.tryParse(routeParam);
      }
    } catch (_) {
      return const RbioRouteError();
    }

    return ChangeNotifierProvider<BloodGlucoseReminderAddVm>(
      create: (_) => BloodGlucoseReminderAddVm(
        mContext: context,
        reminderRepository: getIt(),
        mRemindable: widget.remindable,
        mRotificationManager: getIt<ReminderNotificationsManager>(),
        createdDate: createdDate,
        dailyDoseController: dailyDoseController,
      ),
      child: Consumer<BloodGlucoseReminderAddVm>(
        builder: (
          BuildContext context,
          BloodGlucoseReminderAddVm vm,
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
  Widget _buildBody(BloodGlucoseReminderAddVm vm) {
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

                  // Tags
                  _buildBoldTitle(LocaleProvider.current.tag_description),
                  _buildTags(vm),

                  //
                  _buildGap(),

                  // Periods
                  _buildBoldTitle(LocaleProvider.current.how_often),
                  ExpandablePeriodCard(
                    initValue: vm.mMedicinePeriod,
                    isReset: vm.mMedicinePeriod == null,
                    onChanged: (value) {
                      vm.setMedicinePeriod(value);
                    },
                  ),

                  //
                  _buildGap(),

                  // Daily Dose
                  if (vm.mMedicinePeriod != null) ...[
                    _buildBoldTitle(
                        LocaleProvider.current.how_many_times_a_day),
                    _buildDailyDose(vm),
                  ],

                  //
                  vm.dailyDose == 0
                      ? const SizedBox()
                      : Column(
                          children: <Widget>[
                            //
                            _buildGap(),

                            //
                            _buildTimeAndDoseSection(vm),

                            //
                            if (vm.mMedicinePeriod ==
                                MedicinePeriod.specificDays) ...[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //
                                  _buildGap(),

                                  //
                                  _buildBoldTitle(LocaleProvider.current.days),

                                  //
                                  ExpandableSpecificDays(vm: vm),
                                ],
                              )
                            ],
                          ],
                        ),
                ],
              ),
            ),
          ),
        ),

        if (vm.dailyDose != 0) ...[
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
                    if (isCreated) {
                      dailyDoseController.clear();
                      vm.daysReset();
                      vm.setMedicinePeriod(null);
                      vm.setDailyDose(0);
                    } else {
                      Atom.historyBack();
                    }
                  },
                  showElevation: false,
                ),
              ),

              //
              R.sizes.wSizer8,

              //
              Expanded(
                child: RbioElevatedButton(
                  title: isCreated
                      ? LocaleProvider.current.btn_create
                      : LocaleProvider.current.update,
                  onTap: () {
                    vm.createReminderPlan(widget.remindable, isCreated);
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

  // #region _buildTags
  Widget _buildTags(BloodGlucoseReminderAddVm value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: _buildTagCard(
            value,
            R.image.beforeMeal,
            UsageType.hungry,
          ),
        ),
        R.sizes.wSizer12,
        Expanded(
          child: _buildTagCard(
            value,
            R.image.afterMeal,
            UsageType.full,
          ),
        ),
      ],
    );
  }
  // #endregion

  // #region _buildTagCard
  Widget _buildTagCard(
    BloodGlucoseReminderAddVm value,
    String icon,
    UsageType usageType,
  ) {
    final _text = Text(
      usageType.toShortString(),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.start,
      style: context.xHeadline4.copyWith(
        color: usageType == value.selectedUsageType
            ? getIt<ITheme>().textColor
            : getIt<ITheme>().textColorPassive,
      ),
    );

    return GestureDetector(
      onTap: () => {value.setSelectedUsageType(usageType)},
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: usageType == value.selectedUsageType
              ? getIt<ITheme>().mainColor
              : Colors.white,
          borderRadius: R.sizes.borderRadiusCircular,
        ),
        child: _text,
      ),
    );
  }
  // #endregion

  // #region _buildDailyDose
  RbioTextFormField _buildDailyDose(BloodGlucoseReminderAddVm vm) {
    return RbioTextFormField(
      controller: dailyDoseController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      obscureText: false,
      hintText: LocaleProvider.current.medicine_daily_count,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9\t\r]'))
      ],
      onChanged: (text) {
        if (text != '') {
          vm.setDailyDose(text.isNotEmpty ? int.parse(text) : 0);
        }
      },
    );
  }
  // #endregion

  // #region _buildTimeAndDoseSection
  Widget _buildTimeAndDoseSection(BloodGlucoseReminderAddVm value) {
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
    BloodGlucoseReminderAddVm value,
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

class ExpandablePeriodCard extends StatefulWidget {
  final MedicinePeriod? initValue;
  final bool isReset;
  final ValueChanged<MedicinePeriod> onChanged;

  const ExpandablePeriodCard({
    Key? key,
    this.initValue,
    required this.isReset,
    required this.onChanged,
  }) : super(key: key);

  @override
  _ExpandablePeriodCardState createState() => _ExpandablePeriodCardState();
}

class _ExpandablePeriodCardState extends State<ExpandablePeriodCard> {
  MedicinePeriod? _selectedPeriod;
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    if (widget.isReset) {
      _selectedPeriod = null;
      _isExpanded = true;
    }

    if (widget.initValue != null) {
      _selectedPeriod = widget.initValue!;
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: getIt<ITheme>().cardBackgroundColor,
        borderRadius: R.sizes.borderRadiusCircular,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          GestureDetector(
            onTap: () {
              if (mounted) {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              }
            },
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 12,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  //
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 6,
                      ),
                      child: Text(
                        _selectedPeriod == null
                            ? ''
                            : _selectedPeriod!.toShortString(),
                        style: context.xHeadline4,
                      ),
                    ),
                  ),

                  //
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: SvgPicture.asset(
                      R.image.arrowDown,
                      width: R.sizes.iconSize3,
                    ),
                  ),
                ],
              ),
            ),
          ),

          //
          SizedBox(
            width: double.infinity,
            child: RbioAnimatedClipRect(
              open: _isExpanded,
              alignment: Alignment.center,
              duration: const Duration(milliseconds: 250),
              child: Column(
                children: [
                  _buildTextTile(
                    period: MedicinePeriod.oneTime,
                  ),
                  _buildTextTile(
                    period: MedicinePeriod.everyDay,
                  ),
                  // _buildTextTile(
                  //   period: MedicinePeriod.INTERMITTENT_DAYS,
                  // ),
                  _buildTextTile(
                    period: MedicinePeriod.specificDays,
                    isBottomLine: false,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextTile({
    required MedicinePeriod period,
    bool isBottomLine = true,
  }) {
    return GestureDetector(
      onTap: () {
        if (widget.isReset) {
          widget.onChanged(period);
          Future.delayed(
            const Duration(milliseconds: 100),
            () {
              if (mounted) {
                setState(() {
                  _selectedPeriod = period;
                  _isExpanded = false;
                });
              }
            },
          );
        } else {
          if (mounted) {
            setState(() {
              _selectedPeriod = period;
              _isExpanded = false;
            });
          }
          widget.onChanged(period);
        }
      },
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            Padding(
              padding: const EdgeInsets.only(
                left: 6,
                top: 12,
                bottom: 12,
              ),
              child: Text(
                period.toShortString(),
                textAlign: TextAlign.left,
                style: context.xHeadline4.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            //
            if (isBottomLine)
              Container(
                color: getIt<ITheme>().textColorPassive,
                height: 0.25,
              )
            else
              Container(),
          ],
        ),
      ),
    );
  }
}

class ExpandableSpecificDays extends StatefulWidget {
  final BloodGlucoseReminderAddVm vm;

  const ExpandableSpecificDays({
    Key? key,
    required this.vm,
  }) : super(key: key);

  @override
  _ExpandableSpecificDaysState createState() => _ExpandableSpecificDaysState();
}

class _ExpandableSpecificDaysState extends State<ExpandableSpecificDays> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: getIt<ITheme>().cardBackgroundColor,
        borderRadius: R.sizes.borderRadiusCircular,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          GestureDetector(
            onTap: () {
              if (mounted) {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              }
            },
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 12,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  //
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 6,
                      ),
                      child: Text(
                        _getTitle(),
                        style: context.xHeadline4,
                      ),
                    ),
                  ),

                  //
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: SvgPicture.asset(
                      R.image.arrowDown,
                      width: R.sizes.iconSize3,
                    ),
                  ),
                ],
              ),
            ),
          ),

          //
          SizedBox(
            width: double.infinity,
            child: RbioAnimatedClipRect(
              open: _isExpanded,
              alignment: Alignment.centerLeft,
              duration: const Duration(milliseconds: 250),
              child: Column(
                children: [
                  for (var index = 0; index < widget.vm.days.length; index++)
                    _buildDayCard(index, context,
                        isBottomLine: index != widget.vm.days.length - 1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getTitle() {
    String title = '';
    final list = widget.vm.days;
    for (var element in list) {
      if (element.selected) {
        title += (title.isEmpty ? '' : ', ') + (element.shortName ?? '');
      }
    }
    return title;
  }

  Widget _buildDayCard(
    int index,
    BuildContext context, {
    bool isBottomLine = true,
  }) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              top: 12,
              bottom: 12,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //
                Expanded(
                  child: Text(
                    widget.vm.days[index].name ?? '',
                    style: context.xHeadline4.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                //
                SizedBox(
                  height: R.sizes.iconSize,
                  width: R.sizes.iconSize,
                  child: Checkbox(
                    value: widget.vm.days[index].selected,
                    onChanged: (value) {
                      widget.vm.setSelectedDay(index);
                    },
                    activeColor: getIt<ITheme>().mainColor,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),

                //
                R.sizes.wSizer12,
              ],
            ),
          ),

          //
          if (isBottomLine)
            Container(
              color: getIt<ITheme>().textColorPassive,
              height: 0.25,
            )
          else
            Container(),
        ],
      ),
    );
  }
}
