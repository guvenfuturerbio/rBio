import 'package:onedosehealth/app/bluetooth_v2/bluetooth_v2.dart';
import 'package:scale_repository/scale_repository.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';
import '../scale_detail.dart';

class ScaleMeasurementResultScreen extends StatelessWidget {
  final ScaleEntity scaleEntity;

  const ScaleMeasurementResultScreen({
    Key? key,
    required this.scaleEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ScaleMeasurementResultCubit>(
      create: (context) => ScaleMeasurementResultCubit(
        scaleEntity,
        getIt(),
        getIt(),
      ),
      child: Builder(
        builder: (context) {
          return BlocListener<ScaleMeasurementResultCubit,
              ScaleMeasurementResultState>(
            listener: (context, state) {
              state.whenOrNull(
                failure: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return WarningDialog(
                        LocaleProvider.current.warning,
                        LocaleProvider.current.sorry_dont_transaction,
                      );
                    },
                  );
                },
                successAdded: () {
                  Utils.instance.showSuccessSnackbar(
                    context,
                    LocaleProvider.current.measurement_saved,
                  );
                  Atom.dismiss();
                },
              );
            },
            child: const _ScaleMeasurementResultView(),
          );
        },
      ),
    );
  }
}

class _ScaleMeasurementResultView extends StatelessWidget {
  const _ScaleMeasurementResultView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RbioDarkStatusBar(
      child: Scaffold(
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: R.sizes.screenPadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            //
            R.sizes.hSizer28,
            _buildTitle(context),

            //
            Expanded(
              child: BlocBuilder<ScaleMeasurementResultCubit,
                  ScaleMeasurementResultState>(
                buildWhen: (previous, current) =>
                    current.whenOrNull(initial: (_) => true) ?? false,
                builder: (context, state) {
                  return state.whenOrNull(
                        initial: (scaleEntity) {
                          return ScaleValuesScrollView(
                            scaleEntity: scaleEntity,
                          );
                        },
                      ) ??
                      const SizedBox();
                },
              ),
            ),

            //
            R.sizes.hSizer8,
            _buildButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      LocaleProvider.current.weighing_results,
      style: context.xHeadline3.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        //
        Expanded(
          child: RbioWhiteButton(
            title: LocaleProvider.current.btn_cancel,
            onTap: () {
              context.read<MiScaleOpsCubit>().changeResultDialogStatus();
              Atom.dismiss();
            },
          ),
        ),

        //
        R.sizes.wSizer12,

        //
        Expanded(
          child: RbioElevatedButton(
            title: LocaleProvider.current.save,
            onTap: () async {
              context.read<MiScaleOpsCubit>().changeResultDialogStatus();
              await context.read<ScaleMeasurementResultCubit>().save();
            },
          ),
        ),
      ],
    );
  }
}
