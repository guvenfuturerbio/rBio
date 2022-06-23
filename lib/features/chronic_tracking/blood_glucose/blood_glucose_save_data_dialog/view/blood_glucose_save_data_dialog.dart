import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/core.dart';
import '../cubit/blood_glucose_save_data_dialog_cubit.dart';

class BloodGlucoseSaveDataDialog extends StatelessWidget {
  final List<GlucoseData> glucoseList;

  const BloodGlucoseSaveDataDialog({
    Key? key,
    required this.glucoseList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BloodGlucoseSaveDataDialogCubit>(
      create: (context) =>
          BloodGlucoseSaveDataDialogCubit(glucoseList, getIt())..savedItems(),
      child: const BloodGlucoseSaveDataDialogView(),
    );
  }
}

class BloodGlucoseSaveDataDialogView extends StatelessWidget {
  const BloodGlucoseSaveDataDialogView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BloodGlucoseSaveDataDialogCubit,
        BloodGlucoseSaveDataDialogState>(
      listener: (context, state) {
        if (state.isDone) {
          Atom.dismiss(true);
        }
      },
      builder: (context, state) {
        return RbioBaseDialog(
          child: state.isError
              ? _buildErrorChild(context)
              : _buildLoadingChild(context, state),
        );
      },
    );
  }

  Widget _buildLoadingChild(
    BuildContext context,
    BloodGlucoseSaveDataDialogState state,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        CircularPercentIndicator(
          radius: 65.0,
          animation: true,
          animationDuration: 1000,
          lineWidth: 10.0,
          percent: state.savedItemsCount == 0
              ? 0.000001
              : state.savedItemsCount / state.totalItemsCount,
          reverse: false,
          arcType: ArcType.FULL_REVERSED,
          startAngle: 0.0,
          animateFromLastPercent: true,
          circularStrokeCap: CircularStrokeCap.round,
          backgroundColor: Colors.green,
          linearGradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            tileMode: TileMode.clamp,
            stops: const [0.0, 1.0],
            colors: <Color>[
              getIt<IAppConfig>().theme.mainColor,
              getIt<IAppConfig>().theme.secondaryColor,
            ],
          ),
          widgetIndicator: Center(
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: getIt<IAppConfig>().theme.mainColor,
                borderRadius: BorderRadius.circular(50),
              ),
              padding: const EdgeInsets.all(5),
              child: Container(
                decoration: BoxDecoration(
                  color: getIt<IAppConfig>().theme.mainColor,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
          arcBackgroundColor: Colors.grey.shade300,
        ),

        //
        R.sizes.hSizer16,

        //
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //
            Text(
              LocaleProvider.current.your_data_is_synchronizing,
              style: context.xHeadline1,
            ),

            //
            Padding(
              padding: const EdgeInsets.only(
                left: 8,
                bottom: 12,
              ),
              child: RbioJumpingDots(
                fontSize: 30,
                dotSpacing: 10,
                color: Colors.black,
              ),
            ),
          ],
        ),

        //
        RbioRedButton(
          title: LocaleProvider.of(context).btn_cancel,
          onTap: () {
            context.read<BloodGlucoseSaveDataDialogCubit>().cancelOperations();
          },
        ),
      ],
    );
  }

  Widget _buildErrorChild(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: SvgPicture.asset(
            R.image.error,
            width: Atom.width * 0.3,
          ),
        ),

        //
        R.sizes.hSizer16,

        //
        Text(
          LocaleProvider.current.something_went_wrong,
          style: context.xHeadline1,
        ),

        //
        R.sizes.hSizer16,

        //
        RbioElevatedButton(
          onTap: () {
            Atom.dismiss(false);
          },
          title: LocaleProvider.current.close_lbl,
        ),
      ],
    );
  }
}
