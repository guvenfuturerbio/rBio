import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../../../../core/core.dart';
import '../../../../core/utils/helper/tz_helper.dart';
import '../../mediminder.dart';

part 'widget/add_medicine_dialog.dart';
part 'widget/blood_glucose_body.dart';
part 'widget/expandable_hours.dart';
part 'widget/hba1c_body.dart';
part 'widget/medication_body.dart';
part 'widget/small_pillar_body.dart';

class ReminderDetailScreen extends StatelessWidget {
  const ReminderDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Remindable remindable;
    late int createdDate;
    late int notificationId;
    late String title;

    try {
      title = Atom.queryParameters['title']!;
      final remindableStr = Atom.queryParameters['remindable'];
      createdDate = int.parse(Atom.queryParameters['createdDate'] ?? '0');
      notificationId = int.parse(Atom.queryParameters['notificationId'] ?? '0');
      if (remindableStr != null) {
        remindable = remindableStr.toRouteToRemindable();
      }
    } catch (e, stackTrace) {
      return RbioRouteError(e: e, stackTrace: stackTrace);
    }

    return BlocProvider<ReminderDetailCubit>(
      create: (context) => ReminderDetailCubit(
        createdDate,
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
              createdDate: createdDate,
            ),
          );
        },
      ),
    );
  }
}

class _ReminderDetailView extends StatelessWidget {
  final String title;
  final Remindable remindable;
  final int createdDate;

  const _ReminderDetailView({
    Key? key,
    required this.title,
    required this.remindable,
    required this.createdDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  RbioAppBar _buildAppBar(BuildContext context) => RbioAppBar(
        title: RbioAppBar.textTitle(
          context,
          title,
        ),
      );

  Widget _buildBody() => BlocBuilder<ReminderDetailCubit, ReminderDetailState>(
        builder: (context, state) {
          return state.whenOrNull(
                initial: () => const SizedBox(),
                loadInProgress: () => const SizedBox(),
                success: (result) => _buildSuccess(context, result),
                empty: () => RbioEmptyText(
                  title: LocaleProvider.current.no_records_found,
                ),
                failure: () => const RbioBodyError(),
              ) ??
              const SizedBox();
        },
      );

  Widget _buildSuccess(BuildContext context, ReminderDetailResult result) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        //
        Expanded(
          child: _buildScrollView(context, result),
        ),

        //
        _buildButtons(context, result),

        //
        R.widgets.defaultBottomPadding,
      ],
    );
  }

  Widget _buildScrollView(BuildContext context, ReminderDetailResult result) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      physics: const ClampingScrollPhysics(),
      child: result.when(
        hba1C: (model) => _Hba1cBody(model: model),
        bloodGlucose: (list) => _BloodGlucoseBody(list: list),
        medication: (list) => list.first.drugTracking == DrugTracking.manuel
            ? _MedicationBody(list: list)
            : _SmallPillarBody(list: list),
      ),
    );
  }

  Widget _buildButtons(BuildContext context, ReminderDetailResult result) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
      ),
      child: Column(
        children: [
          //
          result.whenOrNull(
                medication: (value) {
                  if (value.first.drugTracking == DrugTracking.pillarSmall) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //
                        RbioWhiteButton(
                          title: LocaleProvider.current.add_medicine,
                          onTap: () async {
                            final newValue =
                                await Atom.show(const _AddMedicineDialog());
                            if (newValue != null) {
                              context
                                  .read<ReminderDetailCubit>()
                                  .changePillarSmallAddMedicine(
                                    createdDate,
                                    newValue,
                                  );
                            }
                          },
                          infinityWidth: true,
                        ),

                        //
                        R.widgets.hSizer8,
                      ],
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ) ??
              const SizedBox(),

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
                      'createdDate': createdDate.toString(),
                    },
                  );
                },
                medication: (model) {
                  Atom.to(
                    PagePaths.medicationReminderAddEdit,
                    queryParameters: <String, String>{
                      'createdDate': createdDate.toString(),
                    },
                  );
                },
              );
            },
            title: LocaleProvider.current.edit,
            infinityWidth: true,
            fontWeight: FontWeight.bold,
            textColor: getIt<IAppConfig>().theme.textColorSecondary,
            backColor: getIt<IAppConfig>().theme.cardBackgroundColor,
          ),

          //
          R.widgets.hSizer8,

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
}

Widget _buildDetailsTitle(BuildContext context) {
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
      R.widgets.hSizer8
    ],
  );
}

Widget _buildTitleRow(
  BuildContext context,
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
            color: isActive ? null : getIt<IAppConfig>().theme.textColorPassive,
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
            color: isActive ? null : getIt<IAppConfig>().theme.textColorPassive,
          ),
        ),
      ),
    ],
  );
}

Widget _buildGap() => R.widgets.hSizer8;
