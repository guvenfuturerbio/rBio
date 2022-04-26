import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/core.dart';
import '../../mediminder.dart';

class MedicationReminderAddEditScreen extends StatelessWidget {
  const MedicationReminderAddEditScreen({Key? key}) : super(key: key);

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

    return BlocProvider<MedicationReminderAddEditCubit>(
      create: (context) => MedicationReminderAddEditCubit(
        getIt(),
      )..setInitState(createdDate),
      child: Builder(
        builder: (context) {
          return BlocListener<MedicationReminderAddEditCubit,
              MedicationReminderAddEditState>(
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
            child: const _MedicationReminderAddEditView(),
          );
        },
      ),
    );
  }
}

class _MedicationReminderAddEditView extends StatefulWidget {
  const _MedicationReminderAddEditView({Key? key}) : super(key: key);

  @override
  __MedicationReminderAddEditViewState createState() =>
      __MedicationReminderAddEditViewState();
}

class __MedicationReminderAddEditViewState
    extends State<_MedicationReminderAddEditView> {
  late TextEditingController _drugNameController; // İlaç İsmi
  late TextEditingController _dailyDoseController; // Günde kaç kere?
  late TextEditingController
      _oneTimeDoseController; // Bir kerede kaç doz alınacak?
  late FocusNode _drugNameFocusNode;
  late FocusNode _dailyDoseFocusNode;
  late FocusNode _oneTimeDoseFocusNode;

  // Only Pillar Small
  late TextEditingController _drugCountController; // İlaç Adedi
  late TextEditingController
      _remainingCountNotificationController; // Kalan adet bildirimi
  late FocusNode _drugCountFocusNode;
  late FocusNode _remainingCountNotificationFocusNode;

  @override
  void initState() {
    super.initState();
    _drugNameController = TextEditingController();
    _dailyDoseController = TextEditingController();
    _oneTimeDoseController = TextEditingController();
    _drugCountController = TextEditingController();
    _remainingCountNotificationController = TextEditingController();
    _drugNameFocusNode = FocusNode();
    _dailyDoseFocusNode = FocusNode();
    _oneTimeDoseFocusNode = FocusNode();
    _drugCountFocusNode = FocusNode();
    _remainingCountNotificationFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _drugNameController.dispose();
    _dailyDoseController.dispose();
    _oneTimeDoseController.dispose();
    _drugCountController.dispose();
    _remainingCountNotificationController.dispose();
    _drugNameFocusNode.dispose();
    _dailyDoseFocusNode.dispose();
    _oneTimeDoseFocusNode.dispose();
    _drugCountFocusNode.dispose();
    _remainingCountNotificationFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: RbioStackedScaffold(
        extendBodyBehindAppBar: true,
        appbar: _buildAppBar(context),
        body: _buildBody(),
      ),
    );
  }

  // #region _buildAppBar
  RbioAppBar _buildAppBar(BuildContext context) {
    return RbioAppBar(
      title: RbioAppBar.textTitle(
        context,
        LocaleProvider.current.medication_reminders,
      ),
    );
  }
  // #endregion

  // #region _buildBody
  Widget _buildBody() {
    return BlocConsumer<MedicationReminderAddEditCubit,
        MedicationReminderAddEditState>(
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
              _drugNameController.text = result.drugName ?? '';
              _dailyDoseController.text =
                  result.dailyDose == null ? '' : result.dailyDose.toString();
              _oneTimeDoseController.text = result.oneTimeDose == null
                  ? ''
                  : result.oneTimeDose.toString();
              _drugCountController.text =
                  result.drugCount == null ? '' : result.drugCount.toString();
              _remainingCountNotificationController.text =
                  result.remainingCountNotification == null
                      ? ''
                      : result.remainingCountNotification.toString();
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
  // #endregion

  // #region _buildScrollBody
  Widget _buildScrollBody(MedicationReminderAddEditResult result) {
    return RbioScrollbar(
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: RbioKeyboardActions(
          focusList: [
            _drugNameFocusNode,
            _dailyDoseFocusNode,
            _oneTimeDoseFocusNode,
            _drugCountFocusNode,
            _remainingCountNotificationFocusNode,
          ],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //
              R.sizes.stackedTopPadding(context),

              // İlaç Kutusu & Manuel
              // _buildGap(),
              // ..._buildMedicineTypes(result),

              //
              _buildGap(),

              // İlaç Adı
              ..._buildDrugName(),

              //
              _buildGap(),

              //
              RbioSwitcher(
                showFirstChild: result.drugTracking == DrugTracking.pillarSmall,
                child1: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //
                    _buildOnlySmallPillar(result),

                    //
                    _buildGap(),
                  ],
                ),
                child2: const SizedBox(),
              ),

              // Almanız gereken durumu seçiniz
              SelectableUsageType(
                activeType: result.usageType,
                onChanged: (value) {
                  context
                      .read<MedicationReminderAddEditCubit>()
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
              // Bir kerede kaç doz alınacak?
              if (result.reminderPeriod != null) ...[
                ..._buildDailyDose(),

                //
                _buildGap(),

                //
                ..._buildOneTimeDose(),
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
                            .read<MedicationReminderAddEditCubit>()
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
    MedicationReminderAddEditResult result,
    bool isKeyboardVisible,
  ) {
    var pillarCheck = true;
    if (result.drugTracking == DrugTracking.pillarSmall) {
      pillarCheck =
          result.drugCount != null && result.remainingCountNotification != null;
    }
    if (result.dailyDose != null &&
        result.oneTimeDose != null &&
        !isKeyboardVisible &&
        pillarCheck) {
      return [
        _buildGap(),

        //
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            //
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
                      .read<MedicationReminderAddEditCubit>()
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

  // #region _buildMedicineTypes
  List<Widget> _buildMedicineTypes(
    MedicationReminderAddEditResult result,
  ) {
    return [
      //
      ReminderBoldTitle(
        title: LocaleProvider.current.how_will_you_follow_up,
      ),

      //
      AbsorbPointer(
        absorbing: !result.isCreated,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: _buildMedicineTypeCard(
                result,
                DrugTracking.pillarSmall,
              ),
            ),
            R.sizes.wSizer12,
            Expanded(
              child: _buildMedicineTypeCard(
                result,
                DrugTracking.manuel,
              ),
            ),
          ],
        ),
      ),
    ];
  }
  // #endregion

  // #region _buildMedicineTypeCard
  Widget _buildMedicineTypeCard(
    MedicationReminderAddEditResult result,
    DrugTracking type,
  ) {
    final _text = Text(
      type.toShortString(),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.start,
      style: context.xHeadline4.copyWith(
        color: type == result.drugTracking
            ? getIt<IAppConfig>().theme.textColor
            : getIt<IAppConfig>().theme.textColorPassive,
      ),
    );

    return GestureDetector(
      onTap: () {
        context.read<MedicationReminderAddEditCubit>().setDrugTracking(type);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: type == result.drugTracking
              ? getIt<IAppConfig>().theme.mainColor
              : Colors.white,
          borderRadius: R.sizes.borderRadiusCircular,
        ),
        child: _text,
      ),
    );
  }
  // #endregion

  // #region _buildDrugName
  List<Widget> _buildDrugName() {
    return [
      ReminderBoldTitle(
        title: LocaleProvider.current.medicine_name,
      ),

      //
      RbioTextFormField(
        focusNode: _drugNameFocusNode,
        controller: _drugNameController,
        obscureText: false,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        hintText: LocaleProvider.current.medicine_name,
        onChanged: (text) {
          context.read<MedicationReminderAddEditCubit>().setDrugName(text);
        },
      ),
    ];
  }
  // #endregion

  // #region _buildOnlySmallPillar
  Widget _buildOnlySmallPillar(MedicationReminderAddEditResult result) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: _buildDrugCount(),
        ),
        R.sizes.wSizer12,
        Expanded(
          child: _buildRemainingCountNotification(),
        ),
      ],
    );
  }
  // #endregion

  // #region _buildDrugCount
  Widget _buildDrugCount() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //
        ReminderBoldTitle(
          title: LocaleProvider.current.drug_count,
        ),

        //
        RbioTextFormField(
          focusNode: _drugCountFocusNode,
          controller: _drugCountController,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          obscureText: false,
          hintText: "",
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9\t\r]'))
          ],
          onChanged: (text) {
            context
                .read<MedicationReminderAddEditCubit>()
                .setDrugCount(text.isEmpty ? null : int.parse(text));
          },
        ),
      ],
    );
  }
  // #endregion

  // #region _buildRemainingCountNotification
  Widget _buildRemainingCountNotification() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //
        ReminderBoldTitle(
          title: LocaleProvider.current.remaining_count_notification,
        ),

        //
        RbioTextFormField(
          focusNode: _remainingCountNotificationFocusNode,
          controller: _remainingCountNotificationController,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          obscureText: false,
          hintText: "",
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9\t\r]'))
          ],
          onChanged: (text) {
            context
                .read<MedicationReminderAddEditCubit>()
                .setRemainingCountNotification(
                    text.isEmpty ? null : int.parse(text));
          },
        ),
      ],
    );
  }
  // #endregion

  // #region _buildPeriodCard
  List<Widget> _buildPeriodCard(
    MedicationReminderAddEditResult result,
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
              .read<MedicationReminderAddEditCubit>()
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
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9\t\r]'))
        ],
        onChanged: (text) async {
          if (text.isNotEmpty) {
            await context
                .read<MedicationReminderAddEditCubit>()
                .setDailyDose(int.parse(text));
          } else {
            context.read<MedicationReminderAddEditCubit>().resetDailyDose();
          }
        },
      ),
    ];
  }
  // #endregion

  // #region _buildOneTimeDose
  List<Widget> _buildOneTimeDose() {
    return [
      //
      ReminderBoldTitle(
        title: LocaleProvider.current.one_time_dose_question,
      ),

      //
      RbioTextFormField(
        focusNode: _oneTimeDoseFocusNode,
        controller: _oneTimeDoseController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        obscureText: false,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9\t\r]'))
        ],
        onChanged: (text) {
          context
              .read<MedicationReminderAddEditCubit>()
              .setOneTimeDose(int.parse(text));
        },
      ),
    ];
  }
  // #endregion

  // #region _buildTimeAndDoseSection
  Widget _buildTimeAndDoseSection(MedicationReminderAddEditResult result) {
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
                context.read<MedicationReminderAddEditCubit>().setDoseTimes(
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
