import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/core.dart';
import '../../mediminder.dart';

class BloodGlucoseReminderAddEditScreen extends StatelessWidget {
  const BloodGlucoseReminderAddEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int? createdDate;

    try {
      final routeParam = Atom.queryParameters['createdDate'];
      if (routeParam != null) {
        createdDate = int.tryParse(routeParam);
      }
    } catch (_) {
      return const RbioRouteError();
    }

    return BlocProvider<BloodGlucoseReminderAddEditCubit>(
      create: (context) => BloodGlucoseReminderAddEditCubit(
        getIt(),
      )..setInitState(createdDate),
      child: Builder(
        builder: (context) {
          return BlocListener<BloodGlucoseReminderAddEditCubit,
              BloodGlucoseReminderAddEditState>(
            listener: (context, state) {
              state.whenOrNull(
                openListScreen: () {
                  Atom.historyBack();
                  Atom.to(
                    PagePaths.allReminderList,
                    isReplacement: true,
                  );
                },
                showWarningDialog: (descripton) {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return GradientDialog(
                        title: LocaleProvider.current.warning,
                        text: descripton,
                      );
                    },
                  );
                },
              );
            },
            child: const BloodGlucoseReminderAddEditView(),
          );
        },
      ),
    );
  }
}

class BloodGlucoseReminderAddEditView extends StatefulWidget {
  const BloodGlucoseReminderAddEditView({Key? key}) : super(key: key);

  @override
  _BloodGlucoseReminderAddEditViewState createState() =>
      _BloodGlucoseReminderAddEditViewState();
}

class _BloodGlucoseReminderAddEditViewState
    extends State<BloodGlucoseReminderAddEditView> {
  late TextEditingController _dailyDoseController;
  late FocusNode _dailyDoseFocusNode;

  @override
  void initState() {
    _dailyDoseController = TextEditingController();
    _dailyDoseFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _dailyDoseController.dispose();
    _dailyDoseFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: RbioStackedScaffold(
        extendBodyBehindAppBar: true,
        appbar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  // #region _buildAppBar
  RbioAppBar _buildAppBar() {
    return RbioAppBar(
      title: RbioAppBar.textTitle(
        context,
        Remindable.bloodGlucose.toShortTitle(),
      ),
    );
  }
  // #endregion

  // #region _buildBody
  Widget _buildBody() {
    return BlocConsumer<BloodGlucoseReminderAddEditCubit,
        BloodGlucoseReminderAddEditState>(
      listenWhen: (previous, current) =>
          previous.mapOrNull(
            initial: (_) =>
                current.mapOrNull(
                  success: (_) => true,
                ) ??
                false,
          ) ??
          false,
      listener: (context, state) {
        state.whenOrNull(
          success: (result) {
            if (!result.isCreated) {
              _dailyDoseController.text = result.dailyDose.toString();
            }
          },
        );
      },
      buildWhen: (previous, current) =>
          current.whenOrNull(
            openListScreen: () => false,
            showWarningDialog: (_) => false,
          ) ??
          true,
      builder: (context, state) {
        return state.whenOrNull(
              initial: () => const SizedBox(),
              success: (result) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    //
                    Expanded(
                      child: _buildScrollBody(result),
                    ),

                    //
                    KeyboardVisibilityBuilder(
                      builder: (context, isKeyboardVisible) => Column(
                        children: _buildButtons(result, isKeyboardVisible),
                      ),
                    ),
                  ],
                );
              },
            ) ??
            const SizedBox();
      },
    );
  }

  Widget _buildScrollBody(BloodGlucoseReminderAddEditResult result) {
    return RbioScrollbar(
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: RbioKeyboardActions(
          focusList: [
            _dailyDoseFocusNode,
          ],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //
              R.sizes.stackedTopPadding(context),
              _buildGap(),

              // Usage Types
              _buildBoldTitle(LocaleProvider.current.tag_description),
              _buildUsageTypes(result),

              //
              _buildGap(),

              // Medicine Periods
              _buildBoldTitle(LocaleProvider.current.how_often),
              ExpandablePeriodCard(
                initValue: result.medicinePeriod,
                isReset: result.medicinePeriod == null,
                onChanged: (value) {
                  context
                      .read<BloodGlucoseReminderAddEditCubit>()
                      .setMedicinePeriod(value);
                },
              ),

              //
              _buildGap(),

              // Daily Dose
              if (result.medicinePeriod != null) ...[
                _buildBoldTitle(LocaleProvider.current.how_many_times_a_day),
                _buildDailyDose(),
              ],

              //
              ...(result.dailyDose == 0 || result.dailyDose == null)
                  ? [
                      const SizedBox(),
                    ]
                  : [
                      //
                      _buildGap(),

                      //
                      _buildTimeAndDoseSection(result),

                      //
                      if (result.medicinePeriod ==
                          MedicinePeriod.specificDays) ...[
                        ...[
                          //
                          _buildGap(),

                          //
                          _buildBoldTitle(LocaleProvider.current.days),

                          //
                          ExpandableSpecificDays(
                            days: result.days,
                          ),
                        ],
                      ],
                    ],

              //
              _buildGap(),
            ],
          ),
        ),
      ),
    );
  }
  // #endregion

  // #region _buildButtons
  List<Widget> _buildButtons(
    BloodGlucoseReminderAddEditResult result,
    bool isKeyboardVisible,
  ) {
    if (result.dailyDose != null && !isKeyboardVisible) {
      return [
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
                  Atom.historyBack();
                },
              ),
            ),

            //
            R.sizes.wSizer8,

            //
            Expanded(
              child: RbioElevatedButton(
                title: result.isCreated
                    ? LocaleProvider.current.btn_create
                    : LocaleProvider.current.update,
                onTap: () async {
                  await context
                      .read<BloodGlucoseReminderAddEditCubit>()
                      .createReminderPlan();
                },
              ),
            ),
          ],
        ),

        //
        R.sizes.defaultBottomPadding,
      ];
    } else {
      return [const SizedBox()];
    }
  }
  // #endregion

  // #region _buildUsageTypes
  Widget _buildUsageTypes(BloodGlucoseReminderAddEditResult result) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: _buildUsageTypeCard(
            result,
            UsageType.hungry,
          ),
        ),
        R.sizes.wSizer12,
        Expanded(
          child: _buildUsageTypeCard(
            result,
            UsageType.full,
          ),
        ),
      ],
    );
  }
  // #endregion

  // #region _buildUsageTypeCard
  Widget _buildUsageTypeCard(
    BloodGlucoseReminderAddEditResult result,
    UsageType usageType,
  ) {
    final _text = Text(
      usageType.toShortString(),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.start,
      style: context.xHeadline4.copyWith(
        color: usageType == result.usageType
            ? getIt<ITheme>().textColor
            : getIt<ITheme>().textColorPassive,
      ),
    );

    return GestureDetector(
      onTap: () {
        context
            .read<BloodGlucoseReminderAddEditCubit>()
            .setUsageType(usageType);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: usageType == result.usageType
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
  Widget _buildDailyDose() {
    return RbioTextFormField(
      focusNode: _dailyDoseFocusNode,
      controller: _dailyDoseController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      obscureText: false,
      hintText: LocaleProvider.current.medicine_daily_count,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9\t\r]'))
      ],
      onChanged: (text) async {
        if (text.isNotEmpty) {
          await context
              .read<BloodGlucoseReminderAddEditCubit>()
              .setDailyDose(int.parse(text));
        } else {
          context.read<BloodGlucoseReminderAddEditCubit>().resetDailyDose();
        }
      },
    );
  }
  // #endregion

  // #region _buildTimeAndDoseSection
  Widget _buildTimeAndDoseSection(BloodGlucoseReminderAddEditResult result) {
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
            for (var i = 0; i < result.doseTimes.length; i++)
              _buildTimeCard(i, result.doseTimes[i]),
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
                dateTime.xFormatTime8(),
                style: context.xHeadline3.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          //
          GestureDetector(
            onTap: () async {
              var nowTimeOfDay = TimeOfDay(
                hour: dateTime.hour,
                minute: dateTime.minute,
              );

              final selectedDate = await showRbioDatePicker(
                context,
                title: LocaleProvider.current.reminder_hour,
                initialDateTime: DateTime(
                  dateTime.year,
                  dateTime.month,
                  dateTime.day,
                  nowTimeOfDay.hour,
                  nowTimeOfDay.minute,
                ),
                minimumDate: DateTime(
                  dateTime.year,
                  dateTime.month,
                  dateTime.day,
                  0,
                  0,
                ),
                maximumDate: DateTime(
                  dateTime.year,
                  dateTime.month,
                  dateTime.day,
                  23,
                  59,
                ),
                mode: CupertinoDatePickerMode.time,
              );

              if (selectedDate != null) {
                context.read<BloodGlucoseReminderAddEditCubit>().setDoseTimes(
                      TimeOfDay(
                        hour: selectedDate.hour,
                        minute: selectedDate.minute,
                      ),
                      index,
                    );
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
  void initState() {
    if (widget.initValue != null) {
      _selectedPeriod = widget.initValue!;
      _isExpanded = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isReset) {
      _selectedPeriod = null;
      _isExpanded = true;
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
  final List<SelectableDay> days;

  const ExpandableSpecificDays({
    Key? key,
    required this.days,
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
                  for (var index = 0; index < widget.days.length; index++)
                    _buildDayCard(index, context,
                        isBottomLine: index != widget.days.length - 1),
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
    final list = widget.days;
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
                    widget.days[index].name ?? '',
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
                    value: widget.days[index].selected,
                    onChanged: (value) async {
                      await context
                          .read<BloodGlucoseReminderAddEditCubit>()
                          .selectedDayToggle(index);
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
