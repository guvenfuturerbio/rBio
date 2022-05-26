import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/core.dart';
import '../../../../chronic_tracking/scale/scale.dart';
import '../cubit/doctor_scale_treatment_list_cubit.dart';

class DoctorScaleTreatmentListScreen extends StatelessWidget {
  const DoctorScaleTreatmentListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late int patientId;
    try {
      patientId = int.parse(Atom.queryParameters['patientId']!);
    } catch (_) {
      return const RbioRouteError();
    }

    return BlocProvider<DoctorScaleTreatmentListCubit>(
      create: (context) =>
          DoctorScaleTreatmentListCubit(patientId, getIt())..fetchAll(),
      child: const DoctorScaleTreatmentListView(),
    );
  }
}

class DoctorScaleTreatmentListView extends StatelessWidget {
  const DoctorScaleTreatmentListView({Key? key}) : super(key: key);

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
                        onTap: () {},
                      );
                    } else {
                      return RbioTreatmentCard.title(
                        item: result.list[index],
                        onTap: () {},
                      );
                    }
                  },
                ),
        ),
      ],
    );
  }
}
