// ignore_for_file: must_be_immutable

part of '../view/blood_glucose_patient_detail_screen.dart';

class _HyperPicker extends StatelessWidget {
  int hyper;

  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BloodGlucosePatientPickerVm>(
      create: (BuildContext context) => BloodGlucosePatientPickerVm(context),
      child: Consumer<BloodGlucosePatientPickerVm>(
        builder: (
          BuildContext context,
          BloodGlucosePatientPickerVm vm,
          Widget child,
        ) {
          return _buildDialog(vm, context);
        },
      ),
    );
  }

  Dialog _buildDialog(BloodGlucosePatientPickerVm value, BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            child: SizedBox(
              height: 300,
              child: CupertinoPicker(
                scrollController: FixedExtentScrollController(
                  initialItem:
                      ((value.hyperValue - value.higherValue) / 10).toInt(),
                ),
                backgroundColor: Colors.white,
                onSelectedItemChanged: (value) {
                  hyper = value * 10;
                },
                itemExtent: 45.0,
                children: value.hyperRangeWidget,
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
              value.setHyperValue((value.higherValue + hyper));
              value.updatePatientLimit(
                id: Provider.of<PatientNotifiers>(context, listen: false)
                    .patientDetail
                    .id,
              );
            },
          ),
        ],
      ),
    );
  }
}
