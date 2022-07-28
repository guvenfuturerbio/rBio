import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/core.dart';
import '../../scale_detail.dart';

class ChartFilterComponent extends StatelessWidget {
  const ChartFilterComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PatientScaleDetailCubit>().state;

    return state.whenOrNull(
          success: (result) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                //
                Expanded(
                  flex: 20,
                  child: _buildFilterCard(
                    context,
                    result.filterType,
                    ScaleChartFilterType.weekly,
                    LocaleProvider.current.weekly,
                  ),
                ),

                //
                _buildGap(),

                //
                Expanded(
                  flex: 20,
                  child: _buildFilterCard(
                    context,
                    result.filterType,
                    ScaleChartFilterType.monthly,
                    LocaleProvider.current.monthly,
                  ),
                ),

                //
                _buildGap(),

                //
                Expanded(
                  flex: 20,
                  child: _buildFilterCard(
                    context,
                    result.filterType,
                    ScaleChartFilterType.sixMonths,
                    LocaleProvider.current.six_months,
                  ),
                ),

                //
                _buildGap(),

                //
                Expanded(
                  flex: 20,
                  child: _buildFilterCard(
                    context,
                    result.filterType,
                    ScaleChartFilterType.yearly,
                    LocaleProvider.current.yearly,
                  ),
                ),
              ],
            );
          },
        ) ??
        const SizedBox();
  }

  Widget _buildGap() => const Spacer(flex: 4);

  Widget _buildFilterCard(
    BuildContext context,
    ScaleChartFilterType currentType,
    ScaleChartFilterType type,
    String title,
  ) {
    return GestureDetector(
      onTap: () {
        context.read<PatientScaleDetailCubit>().changeFilterType(type);
      },
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(
          vertical: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.xHeadline3.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            //
            R.widgets.hSizer4,

            //
            Container(
              color: currentType == type
                  ? context.xTextInverseColor
                  : Colors.transparent,
              height: 1.0,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
