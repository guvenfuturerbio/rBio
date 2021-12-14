part of '../view/blood_glucose_patient_detail_screen.dart';

class _NormalRangeSelectionSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BloodGlucosePatientPickerVm>(
      create: (BuildContext context) => BloodGlucosePatientPickerVm(context),
      child: Consumer<BloodGlucosePatientPickerVm>(
        builder: (
          BuildContext context,
          BloodGlucosePatientPickerVm value,
          Widget child,
        ) {
          return _buildAlertDialog(context, value);
        },
      ),
    );
  }

  AlertDialog _buildAlertDialog(
    BuildContext context,
    BloodGlucosePatientPickerVm value,
  ) {
    return AlertDialog(
      backgroundColor: getIt<ITheme>().cardBackgroundColor,
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
            SizedBox(height: 12),

            //
            Expanded(
              child: Container(
                width: Atom.width * 0.9,
                child: FlutterSlider(
                  step: FlutterSliderStep(step: 10),
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
                        color: getIt<ITheme>().mainColor,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                    alwaysShowTooltip: true,
                    textStyle: context.xHeadline4.copyWith(
                      color: getIt<ITheme>().textColor,
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
                        color: getIt<ITheme>().secondaryColor,
                      ),
                    ),
                    activeTrackBar: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: getIt<ITheme>().mainColor,
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
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: getIt<ITheme>().mainColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12.0),
                    bottomRight: Radius.circular(12.0),
                  ),
                ),
                child: Text(
                  LocaleProvider.current.save,
                  textAlign: TextAlign.center,
                  style: context.xHeadline3.copyWith(
                    color: getIt<ITheme>().textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onTap: () {
                value.updatePatientLimit(
                  id: Provider.of<PatientNotifiers>(context, listen: false)
                      .patientDetail
                      .id,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
