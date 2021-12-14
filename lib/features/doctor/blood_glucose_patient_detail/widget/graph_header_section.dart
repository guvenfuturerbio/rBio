part of '../view/blood_glucose_patient_detail_screen.dart';

class _GraphHeaderSection extends StatelessWidget {
  final BloodGlucosePatientDetailVm value;
  final ScrollController controller;

  const _GraphHeaderSection({
    Key key,
    this.value,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        //
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: DateRangePicker(
            endDate: value.endDate,
            startDate: value.startDate,
            nextDate: value.nextDate,
            previousDate: value.previousDate,
            selected: value.selected.fromString,
            setSelectedItem: (val) {
              return value.setSelectedItem(val.toShortString());
            },
            setEndDate: value.setStartDate,
            setStartDate: value.setEndDate,
          ),
        ),

        //
        Container(
          height: context.HEIGHT * 0.25,
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: getIt<ITheme>().cardBackgroundColor,
            borderRadius: R.sizes.borderRadiusCircular,
          ),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              //
              value.currentGraph,

              //
              IgnorePointer(
                child: Padding(
                  padding: EdgeInsets.only(left: 40, top: 45),
                  child: SvgPicture.asset(
                    R.image.grafik_arkasi,
                    alignment: Alignment.centerRight,
                  ),
                ),
              ),
            ],
          ),
        ),

        //
        BottomActionsOfGraph(
          value: value,
        ),

        //
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(4),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return _CustomBarPie(
                width: constraints.maxWidth,
                height: (context.HEIGHT * 0.06) * context.TEXTSCALE,
              );
            }),
          ),
        ),
      ],
    );
  }
}
