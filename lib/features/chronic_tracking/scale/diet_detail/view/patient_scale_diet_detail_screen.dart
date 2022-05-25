import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/core.dart';
import '../cubit/patient_scale_diet_detail_cubit.dart';
import '../model/scale_treatment_detail_response.dart';

class PatientScaleDietDetailScreen extends StatelessWidget {
  const PatientScaleDietDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int? itemId;

    try {
      final routeParam = Atom.queryParameters['itemId'];
      itemId = int.tryParse(routeParam!);
    } catch (_) {
      return const RbioRouteError();
    }

    return BlocProvider<PatientScaleDietDetailCubit>(
      create: (context) =>
          PatientScaleDietDetailCubit(getIt())..fetchAll(itemId!),
      child: const PatientScaleDietDetailView(),
    );
  }
}

class PatientScaleDietDetailView extends StatelessWidget {
  const PatientScaleDietDetailView({Key? key}) : super(key: key);

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
          LocaleProvider.of(context).diet_list,
        ),
      );

  Widget _buildBody() {
    return BlocBuilder<PatientScaleDietDetailCubit,
        PatientScaleDietDetailState>(
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
    ScaleTreatmentDetailResponse result,
  ) {
    return Text(result.id.toString());
  }
}
