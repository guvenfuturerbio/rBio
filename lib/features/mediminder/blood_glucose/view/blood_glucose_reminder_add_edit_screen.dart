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
                    PagePaths.reminderList,
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
            child: const _BloodGlucoseReminderAddEditView(),
          );
        },
      ),
    );
  }
}

class _BloodGlucoseReminderAddEditView extends StatefulWidget {
  const _BloodGlucoseReminderAddEditView({Key? key}) : super(key: key);

  @override
  __BloodGlucoseReminderAddEditViewState createState() =>
      __BloodGlucoseReminderAddEditViewState();
}

class __BloodGlucoseReminderAddEditViewState
    extends State<_BloodGlucoseReminderAddEditView> {
  late TextEditingController _dailyDoseController;
  late FocusNode _dailyDoseFocusNode;

  @override
  void initState() {
    super.initState();
    _dailyDoseController = TextEditingController();
    _dailyDoseFocusNode = FocusNode();
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
              _dailyDoseController.text =
                  result.dailyDose == null ? '' : result.dailyDose.toString();
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

              // Almanız gereken durumu seçiniz
              SelectableUsageType(
                activeType: result.usageType,
                onChanged: (value) {
                  context
                      .read<BloodGlucoseReminderAddEditCubit>()
                      .setUsageType(value);
                },
              ),

              //
              _buildGap(),

              // Ne sıklıkla
              ..._buildPeriodCard(result),

              //
              _buildGap(),

              // Günde kaç kere?
              if (result.reminderPeriod != null) ...[
                ..._buildDailyDose(),
              ],

              // Alarm & Belirli Günler
              if (!(result.dailyDose == 0 || result.dailyDose == null)) ...[
                //
                _buildGap(),

                //
                _buildTimeAndDoseSection(result),

                //
                if (result.reminderPeriod == ReminderPeriod.specificDays) ...[
                  ...[
                    //
                    _buildGap(),

                    //
                    ReminderBoldTitle(
                      title: LocaleProvider.current.days,
                    ),

                    //
                    ExpandableSpecificDays(
                      days: result.days,
                      onChanged: (index) async {
                        await context
                            .read<BloodGlucoseReminderAddEditCubit>()
                            .selectedDayToggle(index);
                      },
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
                backColor: getIt<IAppConfig>().theme.cardBackgroundColor,
                textColor: getIt<IAppConfig>().theme.textColorSecondary,
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

  // #region _buildPeriodCard
  List<Widget> _buildPeriodCard(
    BloodGlucoseReminderAddEditResult result,
  ) {
    return [
      //
      ReminderBoldTitle(
        title: LocaleProvider.current.how_often,
      ),

      //
      ExpandablePeriodCard(
        initValue: result.reminderPeriod,
        isReset: result.reminderPeriod == null,
        onChanged: (value) {
          context
              .read<BloodGlucoseReminderAddEditCubit>()
              .setReminderPeriod(value);
        },
      ),
    ];
  }
  // #endregion

  // #region _buildDailyDose
  List<Widget> _buildDailyDose() {
    return [
      //
      ReminderBoldTitle(
        title: LocaleProvider.current.how_many_times_a_day,
      ),

      //
      RbioTextFormField(
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
      ),
    ];
  }
  // #endregion

  // #region _buildTimeAndDoseSection
  Widget _buildTimeAndDoseSection(BloodGlucoseReminderAddEditResult result) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //
        ReminderBoldTitle(
          title: LocaleProvider.current.alert,
        ),

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
        color: getIt<IAppConfig>().theme.cardBackgroundColor,
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

  Widget _buildGap() => R.sizes.hSizer16;
}
