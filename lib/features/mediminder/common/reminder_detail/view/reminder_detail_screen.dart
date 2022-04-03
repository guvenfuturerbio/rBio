import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onedosehealth/core/utils/tz_helper.dart';

import '../../../../../core/core.dart';
import '../../../mediminder.dart';

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
                    PagePaths.allReminderList,
                    isReplacement: true,
                  );
                },
              );
            },
            child: ReminderDetailView(
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

class ReminderDetailView extends StatefulWidget {
  final String title;
  final Remindable remindable;
  final int notificationId;

  const ReminderDetailView({
    Key? key,
    required this.title,
    required this.remindable,
    required this.notificationId,
  }) : super(key: key);

  @override
  _ReminderDetailViewState createState() => _ReminderDetailViewState();
}

class _ReminderDetailViewState extends State<ReminderDetailView> {
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
                empty: () => Center(
                  heightFactor: 5,
                  child: Text(
                    LocaleProvider.current.no_records_found,
                    textAlign: TextAlign.center,
                    style: context.xHeadline3.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
              medication: (model) => _buildMedicationReminders(model),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPillar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        _buildDetailsTitle(),

        //
        _buildTitleRow(
          "Kutu kodu",
          "Durum",
          false,
        ),

        //
        _buildTitleRow(
          "12345",
          "Tok",
          true,
        ),

        //
        _buildGap(),

        //
        _buildTitleRow(
          "Kaç günde bir",
          "Günde alınan",
          false,
        ),

        //
        _buildTitleRow(
          "1",
          "2 kere",
          true,
        ),

        //
        _buildGap(),

        //
        _buildTitleRow(
          "Bir kerede",
          "Kalan ilaç",
          false,
        ),

        //
        _buildTitleRow(
          "1 doz",
          "20 adet",
          true,
        ),

        //
        _buildGap(),

        //
        _buildTitleRow(
          "Bildirim",
          "",
          false,
        ),

        //
        _buildTitleRow(
          "10 adet kaldığında",
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
          model.medicinePeriod == null
              ? ''
              : model.medicinePeriod!.toShortString(),
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
          "2 kere",
          true,
        ),

        //
        _buildGap(),

        //
        _buildTitleRow(
          "Kaç günde bir",
          LocaleProvider.current.once,
          false,
        ),

        //
        _buildTitleRow(
          "1",
          model.dosage == null
              ? ''
              : '${model.dosage} ${LocaleProvider.current.hint_dosage.toLowerCase()}',
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
                    PagePaths.bloodGlucoseReminderAdd,
                    queryParameters: <String, String>{
                      'createdDate': model.createdDate.toString(),
                    },
                  );
                },
                medication: (model) {},
              );
            },
            title: LocaleProvider.current.edit,
            infinityWidth: true,
            showElevation: false,
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
