import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/core.dart';
import '../../../../bluetooth_v2/bluetooth_v2.dart';
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
                      return RbioMessageDialog(
                        description:
                            LocaleProvider.current.sorry_dont_transaction,
                        isAtom: false,
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
        padding: R.utils.screenPadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            //
            R.widgets.hSizer28,
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
            R.widgets.hSizer8,
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
        R.widgets.wSizer12,

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
