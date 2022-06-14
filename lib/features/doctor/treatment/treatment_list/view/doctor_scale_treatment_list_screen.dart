import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../core/core.dart';
import '../../../../chronic_tracking/scale/scale.dart';
import '../cubit/doctor_scale_treatment_list_cubit.dart';

part 'widget/expandable_fab.dart';

class DoctorScaleTreatmentListScreen extends StatelessWidget {
  const DoctorScaleTreatmentListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late int patientId;
    try {
      patientId = int.parse(Atom.queryParameters['patientId']!);
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      return const RbioRouteError();
    }

    return BlocProvider<DoctorScaleTreatmentListCubit>(
      create: (context) =>
          DoctorScaleTreatmentListCubit(patientId, getIt())..fetchAll(),
      child: DoctorScaleTreatmentListView(patientId: patientId),
    );
  }
}

class DoctorScaleTreatmentListView extends StatefulWidget {
  final int patientId;

  const DoctorScaleTreatmentListView({
    Key? key,
    required this.patientId,
  }) : super(key: key);

  @override
  State<DoctorScaleTreatmentListView> createState() =>
      _DoctorScaleTreatmentListViewState();
}

class _DoctorScaleTreatmentListViewState
    extends State<DoctorScaleTreatmentListView> {
  final ValueNotifier<bool> _fabNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _fabNotifier,
      builder: (BuildContext context, bool fabState, Widget? child) {
        return RbioStackedScaffold(
          isLoading: fabState,
          showLoadingIcon: false,
          appbar: _buildAppBar(context),
          body: _buildBody(),
          floatingActionButton: _buildFAB(context),
        );
      },
    );
  }

  RbioAppBar _buildAppBar(BuildContext context) => RbioAppBar(
        title: RbioAppBar.textTitle(
          context,
          LocaleProvider.of(context).treatment,
        ),
      );

  Widget _buildBody() {
    return BlocBuilder<DoctorScaleTreatmentListCubit,
        DoctorScaleTreatmentListState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox(),
          loadInProgress: () => const RbioLoading(),
          success: (result) => _buildSuccess(context, result),
          failure: () => const RbioBodyError(),
        );
      },
    );
  }

  Widget _buildSuccess(
    BuildContext context,
    ScaleTreatmentListResult result,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        //
        R.sizes.stackedTopPadding(context),
        R.sizes.hSizer8,

        //
        RbioDetailSearchComponent(
          result: result,
          onStartDateChange: (date) {
            context.read<DoctorScaleTreatmentListCubit>().setStartDate(date);
          },
          onEndDateChange: (date) {
            context.read<DoctorScaleTreatmentListCubit>().setEndDate(date);
          },
          onTypeChange: (value) {
            context
                .read<DoctorScaleTreatmentListCubit>()
                .filterTypeChange(value);
          },
        ),

        //
        Expanded(
          child: result.isLoading
              ? const RbioLoading()
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.only(
                    top: 10,
                    bottom: R.sizes.defaultBottomValue,
                  ),
                  physics: const BouncingScrollPhysics(),
                  itemCount: result.list.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = result.list[index];

                    if (item.type == TreatmentType.treatmentNote) {
                      return RbioTreatmentCard.createdBy(
                        item: result.list[index],
                        onTap: () {
                          _openTreatmentAddEdit(
                              result.list[index].id.toString());
                        },
                      );
                    } else {
                      return RbioTreatmentCard.title(
                        item: result.list[index],
                        onTap: () {
                          if (result.list[index].type == TreatmentType.diet) {
                            _openDietAddEdit(result.list[index].id.toString());
                          } else if (result.list[index].type ==
                              TreatmentType.doctorNote) {
                            _openDoctorNoteAddEdit(
                                result.list[index].id.toString());
                          }
                        },
                      );
                    }
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildFAB(BuildContext context) {
    return _ExpandableFab(
      fabNotifier: _fabNotifier,
      distance: 150.0,
      children: [
        //
        _ColorfulExpandedFab(
          backColor: getIt<IAppConfig>().theme.yellow,
          title: LocaleProvider.of(context).diet_list,
          imagePath: R.image.fabDietList,
          onTap: _openDietAddEdit,
        ),

        //
        _ColorfulExpandedFab(
          backColor: getIt<IAppConfig>().theme.blue,
          title: LocaleProvider.of(context).treatment_note,
          imagePath: R.image.fabTreatmentNote,
          onTap: _openTreatmentAddEdit,
        ),

        //
        _ColorfulExpandedFab(
          backColor: getIt<IAppConfig>().theme.pink,
          title: LocaleProvider.of(context).special_note,
          imagePath: R.image.fabSpecialNote,
          onTap: _openDoctorNoteAddEdit,
        ),
      ],
    );
  }

  void _openDietAddEdit([String? itemId]) {
    Atom.to(
      PagePaths.doctorScaleDietAddEdit,
      queryParameters: {
        'patientId': widget.patientId.toString(),
      }..addAll(itemId == null ? {} : {'itemId': itemId}),
    );
  }

  void _openTreatmentAddEdit([String? itemId]) {
    Atom.to(
      PagePaths.doctorScaleTreatmentAddEdit,
      queryParameters: {
        'patientId': widget.patientId.toString(),
      }..addAll(itemId == null ? {} : {'itemId': itemId}),
    );
  }

  void _openDoctorNoteAddEdit([String? itemId]) {
    Atom.to(
      PagePaths.doctorScaleDoctorNoteAddEdit,
      queryParameters: {
        'patientId': widget.patientId.toString(),
      }..addAll(itemId == null ? {} : {'itemId': itemId}),
    );
  }
}
