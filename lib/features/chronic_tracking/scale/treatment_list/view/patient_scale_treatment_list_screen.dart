import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/core.dart';
import '../cubit/patient_scale_treatment_list_cubit.dart';
import '../model/treatment_type.dart';

class PatientScaleTreatmentListScreen extends StatelessWidget {
  const PatientScaleTreatmentListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PatientScaleTreatmentListCubit>(
      create: (context) =>
          PatientScaleTreatmentListCubit(getIt(), getIt())..fetchAll(),
      child: const PatientScaleTreatmentListView(),
    );
  }
}

class PatientScaleTreatmentListView extends StatelessWidget {
  const PatientScaleTreatmentListView({Key? key}) : super(key: key);

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
    return BlocBuilder<PatientScaleTreatmentListCubit,
        PatientScaleTreatmentListState>(
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
            context.read<PatientScaleTreatmentListCubit>().setStartDate(date);
          },
          onEndDateChange: (date) {
            context.read<PatientScaleTreatmentListCubit>().setEndDate(date);
          },
          onTypeChange: (value) {
            context
                .read<PatientScaleTreatmentListCubit>()
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
                    return RbioTreatmentCard.createdBy(
                      item: result.list[index],
                      onTap: () {
                        if (result.list[index].type == TreatmentType.diet) {
                          Atom.to(
                            PagePaths.patientScaleDietDetail,
                            queryParameters: {
                              'itemId': result.list[index].id.toString(),
                            },
                          );
                        } else if (result.list[index].type ==
                            TreatmentType.treatmentNote) {
                          Atom.to(
                            PagePaths.patientScaleTreatmentDetail,
                            queryParameters: {
                              'itemId': result.list[index].id.toString(),
                            },
                          );
                        }
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
}
