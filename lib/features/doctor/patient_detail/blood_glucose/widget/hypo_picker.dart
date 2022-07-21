part of '../view/bg_patient_detail_screen.dart';

class _HypoPicker extends StatelessWidget {
  late int hypo;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BgPatientPickerVm>(
      create: (BuildContext context) => BgPatientPickerVm(context),
      child: Consumer<BgPatientPickerVm>(
        builder: (
          BuildContext context,
          BgPatientPickerVm vm,
          Widget? child,
        ) {
          return _buildDialog(vm, context);
        },
      ),
    );
  }

  Dialog _buildDialog(BgPatientPickerVm vm, BuildContext context) {
    return Dialog(
      shape: R.sizes.defaultShape,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          ClipRRect(
            borderRadius: R.sizes.borderRadiusCircular,
            child: SizedBox(
              height: 300,
              child: CupertinoPicker(
                scrollController: FixedExtentScrollController(
                  initialItem: (vm.hypoValue / 10).toInt(),
                ),
                backgroundColor: Colors.white,
                onSelectedItemChanged: (value) {
                  hypo = value * 10;
                },
                itemExtent: 45.0,
                children: vm.hypoRangeWidget,
              ),
            ),
          ),

          //
          InkWell(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: context.xPrimaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: R.sizes.radiusCircular,
                  bottomRight: R.sizes.radiusCircular,
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
              vm.setHypoValue(hypo * 1.0);
              vm.updatePatientLimit(
                id: Provider.of<PatientNotifiers>(context, listen: false)
                    .patientDetail
                    .id!,
              );
            },
          ),
        ],
      ),
    );
  }
}
