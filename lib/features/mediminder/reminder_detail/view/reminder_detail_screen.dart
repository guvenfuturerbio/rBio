import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../../../core/utils/tz_helper.dart';
import '../../mediminder.dart';

class ReminderDetailScreen extends StatelessWidget {
  const ReminderDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Remindable remindable;
    late int notificationId;
    late String title;

    try {
      title = Atom.queryParameters['title']!;
      final remindableStr = Atom.queryParameters['remindable'];
      notificationId = int.parse(Atom.queryParameters['notificationId'] ?? '0');
      if (remindableStr != null) {
        remindable = remindableStr.toRouteToRemindable();
      }
    } catch (e) {
      return const RbioRouteError();
    }

    return BlocProvider<ReminderDetailCubit>(
      create: (context) => ReminderDetailCubit(
        notificationId,
        remindable,
        getIt(),
      )..getDetail(),
      child: Builder(
        builder: (context) {
          return BlocListener<ReminderDetailCubit, ReminderDetailState>(
            listener: (context, state) {
              state.whenOrNull(
                openListScreen: () {
                  Atom.historyBack();
                  Atom.to(
                    PagePaths.reminderList,
                    isReplacement: true,
                  );
                },
              );
            },
            child: _ReminderDetailView(
              title: title,
              remindable: remindable,
              notificationId: notificationId,
            ),
          );
        },
      ),
    );
  }
}

class _ReminderDetailView extends StatefulWidget {
  final String title;
  final Remindable remindable;
  final int notificationId;

  const _ReminderDetailView({
    Key? key,
    required this.title,
    required this.remindable,
    required this.notificationId,
  }) : super(key: key);

  @override
  __ReminderDetailViewState createState() => __ReminderDetailViewState();
}

class __ReminderDetailViewState extends State<_ReminderDetailView> {
  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  RbioAppBar _buildAppBar() => RbioAppBar(
        title: RbioAppBar.textTitle(
          context,
          widget.title,
        ),
      );

  Widget _buildBody() => BlocBuilder<ReminderDetailCubit, ReminderDetailState>(
        builder: (context, state) {
          return state.whenOrNull(
                initial: () => const SizedBox(),
                loadInProgress: () => const SizedBox(),
                success: (result) => _buildSuccess(result),
                empty: () => RbioEmptyText(
                  title: LocaleProvider.current.no_records_found,
                ),
                failure: () => const RbioBodyError(),
              ) ??
              const SizedBox();
        },
      );

  Widget _buildSuccess(ReminderDetailResult result) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        //
        Expanded(
          child: _buildScrollView(result),
        ),

        //
        _buildButtons(result),

        //
        R.sizes.defaultBottomPadding,
      ],
    );
  }

  Widget _buildScrollView(ReminderDetailResult result) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      physics: const ClampingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          //
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: getIt<ITheme>().cardBackgroundColor,
              borderRadius: R.sizes.borderRadiusCircular,
            ),
            child: result.when(
              hba1C: (model) => _buildHbA1c(model),
              bloodGlucose: (model) => _buildBloodGlucose(model),
              medication: (model) => model.drugTracking == DrugTracking.manuel
                  ? _buildMedicationReminders(model)
                  : _buildSmallPillar(model),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallPillar(MedicationReminderModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        _buildDetailsTitle(),

        //
        _buildTitleRow(
          LocaleProvider.current.box_code,
          LocaleProvider.current.status,
          false,
        ),

        //
        _buildTitleRow(
          model.boxCode == null ? '' : model.boxCode.toString(),
          model.usageType.xGetText,
          true,
        ),

        //
        _buildGap(),

        //
        _buildTitleRow(
          LocaleProvider.current.how_often,
          LocaleProvider.current.taken_per_day,
          false,
        ),

        //
        _buildTitleRow(
          model.reminderPeriod == null
              ? ''
              : model.reminderPeriod!.toShortString(),
          model.dailyDose == null ? '' : model.dailyDose.toString(),
          true,
        ),

        //
        _buildGap(),

        //
        _buildTitleRow(
          LocaleProvider.current.once,
          LocaleProvider.current.remaining_drug,
          false,
        ),

        //
        _buildTitleRow(
          model.oneTimeDose == null ? '' : model.oneTimeDose.toString(),
          model.drugCount == null ? '' : model.drugCount.toString(),
          true,
        ),

        //
        _buildGap(),

        //
        _buildTitleRow(
          LocaleProvider.current.notification,
          "",
          false,
        ),

        //
        _buildTitleRow(
          model.remainingCountNotification == null
              ? ''
              : model.remainingCountNotification.toString(),
          "",
          true,
        ),
      ],
    );
  }

  Widget _buildBloodGlucose(BloodGlucoseReminderModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        _buildDetailsTitle(),

        //
        _buildTitleRow(
          LocaleProvider.current.tag,
          LocaleProvider.current.how_often,
          false,
        ),

        //
        _buildTitleRow(
          model.usageType == null ? '' : model.usageType!.toShortString(),
          model.reminderPeriod == null
              ? ''
              : model.reminderPeriod!.toShortString(),
          true,
        ),

        //
        _buildGap(),

        //
        _buildTitleRow(
          LocaleProvider.current.how_many_times_a_day,
          "",
          false,
        ),

        //
        _buildTitleRow(
          model.dailyDose == null ? '' : model.dailyDose.toString(),
          "",
          true,
        ),
      ],
    );
  }

  Widget _buildMedicationReminders(MedicationReminderModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildDetailsTitle(),

        //
        _buildTitleRow(
          LocaleProvider.current.status,
          LocaleProvider.current.taken_per_day,
          false,
        ),

        //
        _buildTitleRow(
          model.usageType == null ? '' : model.usageType!.toShortString(),
          model.dailyDose == null ? '' : model.dailyDose!.toString(),
          true,
        ),

        //
        _buildGap(),

        //
        _buildTitleRow(
          LocaleProvider.current.how_often,
          LocaleProvider.current.once,
          false,
        ),

        //
        _buildTitleRow(
          model.reminderPeriod == null
              ? ''
              : model.reminderPeriod!.toShortString(),
          model.oneTimeDose == null ? '' : model.oneTimeDose!.toString(),
          true,
        ),
      ],
    );
  }

  Widget _buildHbA1c(Hba1CReminderModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        _buildDetailsTitle(),

        //
        _buildTitleRow(
          LocaleProvider.current.last_test_date,
          LocaleProvider.current.last_result,
          false,
        ),

        //
        _buildTitleRow(
          model.lastTestDate == null ? '' : model.lastTestDate!.xDateFormat,
          model.lastTestValue == null ? '' : '${model.lastTestValue} %',
          true,
        ),

        //
        _buildGap(),

        //
        _buildTitleRow(
          LocaleProvider.current.reminder_date,
          LocaleProvider.current.time,
          false,
        ),

        //
        _buildTitleRow(
          model.scheduledDate.xDateFormat,
          model.scheduledDate.xHourFormat,
          true,
        ),
      ],
    );
  }

  Widget _buildStrip() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        _buildDetailsTitle(),

        //
        _buildTitleRow(
          "Strip sayısı",
          "Kalan adet bildirimi",
          false,
        ),

        //
        _buildTitleRow(
          "200",
          "30",
          true,
        ),
      ],
    );
  }

  Widget _buildGap() => R.sizes.hSizer8;

  Widget _buildDetailsTitle() {
    return Column(
      children: [
        //
        Text(
          LocaleProvider.current.details,
          style: context.xHeadline3.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        //
        R.sizes.hSizer8
      ],
    );
  }

  Widget _buildButtons(ReminderDetailResult result) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
      ),
      child: Column(
        children: [
          //
          RbioElevatedButton(
            onTap: () {
              result.when(
                hba1C: (model) {
                  Atom.to(
                    PagePaths.hba1cReminderAddEdit,
                    queryParameters: <String, String>{
                      'notificationId': model.notificationId.toString(),
                    },
                  );
                },
                bloodGlucose: (model) {
                  Atom.to(
                    PagePaths.bloodGlucoseReminderAddEdit,
                    queryParameters: <String, String>{
                      'createdDate': model.createdDate.toString(),
                    },
                  );
                },
                medication: (model) {
                  Atom.to(
                    PagePaths.medicationReminderAddEdit,
                    queryParameters: <String, String>{
                      'createdDate': model.createdDate.toString(),
                    },
                  );
                },
              );
            },
            title: LocaleProvider.current.edit,
            infinityWidth: true,
            fontWeight: FontWeight.bold,
            textColor: getIt<ITheme>().textColorSecondary,
            backColor: getIt<ITheme>().cardBackgroundColor,
          ),

          //
          R.sizes.hSizer8,

          //
          RbioRedButton(
            onTap: () async {
              await context.read<ReminderDetailCubit>().removeReminder(result);
            },
            title: LocaleProvider.current.btn_delete_reminder,
            infinityWidth: true,
          ),
        ],
      ),
    );
  }

  Widget _buildTitleRow(
    String leftText,
    String rightText,
    bool isActive,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        //
        Expanded(
          child: Text(
            leftText,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.xHeadline4.copyWith(
              color: isActive ? null : getIt<ITheme>().textColorPassive,
            ),
          ),
        ),

        //
        Expanded(
          child: Text(
            rightText,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.xHeadline4.copyWith(
              color: isActive ? null : getIt<ITheme>().textColorPassive,
            ),
          ),
        ),
      ],
    );
  }
}
