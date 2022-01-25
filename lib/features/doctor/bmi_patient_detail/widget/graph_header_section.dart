part of '../view/bmi_patient_detail_screen.dart';

class _GraphHeaderSection extends StatelessWidget {
  final BmiPatientDetailVm value;
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
            selected: value.selected,
            setSelectedItem: (val) {
              return value.setSelectedItem(val);
            },
            setEndDate: value.setStartDate,
            setStartDate: value.setEndDate,
          ),
        ),

        //
        Container(
          height: MediaQuery.of(context).orientation == Orientation.portrait
              ? context.HEIGHT * 0.25
              : context.HEIGHT * 0.7,
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

              //
              if (MediaQuery.of(context).orientation == Orientation.portrait)
                Positioned(
                    right: 0,
                    top: 0,
                    child: GestureDetector(
                      onTap: () => context
                          .read<BmiPatientDetailVm>()
                          .changeChartShowStatus(),
                      child: Icon(
                        Icons.keyboard_arrow_up,
                        size: 52 * context.TEXTSCALE,
                      ),
                    ))
            ],
          ),
        ),

        //
        BottomActionsOfGraph(
          value: value,
        ),
      ],
    );
  }
}
