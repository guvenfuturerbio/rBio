import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/core.dart';
import '../cubit/patient_scale_treatment_list_cubit.dart';
import '../model/scale_treatment_request.dart';
import '../model/treatment_filter_type.dart';

part 'widget/detail_search_component.dart';

class PatientScaleTreatmentListScreen extends StatelessWidget {
  const PatientScaleTreatmentListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PatientScaleTreatmentListCubit>(
      create: (context) => PatientScaleTreatmentListCubit(getIt(), getIt())
        ..fetchAll(ScaleTreatmentRequest(count: 1)),
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
    PatientScaleTreatmentListResult result,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        //
        DetailSearchComponent(result: result),

        //
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.only(top: 10),
            physics: const BouncingScrollPhysics(),
            itemCount: result.list.length,
            itemBuilder: (BuildContext context, int index) {
              return RbioTreatmentCard(
                item: result.list[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
