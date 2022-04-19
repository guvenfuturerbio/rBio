part of '../view/bg_patient_detail_screen.dart';

class _NormalRangeSelectionSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BgPatientPickerVm>(
      create: (BuildContext context) => BgPatientPickerVm(context),
      child: Consumer<BgPatientPickerVm>(
        builder: (
          BuildContext context,
          BgPatientPickerVm value,
          Widget? child,
        ) {
          return _buildAlertDialog(context, value);
        },
      ),
    );
  }

  AlertDialog _buildAlertDialog(
    BuildContext context,
    BgPatientPickerVm value,
  ) {
    return AlertDialog(
      backgroundColor: getIt<IAppConfig>().theme.cardBackgroundColor,
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: R.sizes.borderRadiusCircular,
      ),
      content: SizedBox(
        height: Atom.height * 0.25,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            const SizedBox(height: 12),

            //
            Expanded(
              child: SizedBox(
                width: Atom.width * 0.9,
                child: FlutterSlider(
                  step: const FlutterSliderStep(step: 10),
                  handlerWidth: 32,
                  handlerHeight: 32,
                  values: [
                    value.lowerValue.toDouble(),
                    value.higherValue.toDouble(),
                  ],
                  rangeSlider: true,
                  max: value.hyperValue.toDouble(),
                  min: value.hypoValue.toDouble(),
                  tooltip: FlutterSliderTooltip(
                    boxStyle: FlutterSliderTooltipBox(
                      decoration: BoxDecoration(
                        color: getIt<IAppConfig>().theme.mainColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                    alwaysShowTooltip: true,
                    textStyle: context.xHeadline4.copyWith(
                      color: getIt<IAppConfig>().theme.textColor,
                    ),
                  ),
                  trackBar: FlutterSliderTrackBar(
                    inactiveTrackBarHeight: 14,
                    activeTrackBarHeight: 10,
                    inactiveTrackBar: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black12,
                      border: Border.all(
                        width: 3,
                        color: getIt<IAppConfig>().theme.secondaryColor,
                      ),
                    ),
                    activeTrackBar: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: getIt<IAppConfig>().theme.mainColor,
                    ),
                  ),
                  onDragging: (handlerIndex, lowerValue, upperValue) {
                    value.setTargetRange(
                        lowerValue.toDouble(), upperValue.toDouble());
                  },
                ),
              ),
            ),

            //
            InkWell(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: getIt<IAppConfig>().theme.mainColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12.0),
                    bottomRight: Radius.circular(12.0),
                  ),
                ),
                child: Text(
                  LocaleProvider.current.save,
                  textAlign: TextAlign.center,
                  style: context.xHeadline3.copyWith(
                    color: getIt<IAppConfig>().theme.textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onTap: () {
                value.updatePatientLimit(
                  id: Provider.of<PatientNotifiers>(context, listen: false)
                      .patientDetail
                      .id!,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
