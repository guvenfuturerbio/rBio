part of '../view/blood_pressure_detail_screen.dart';

class _GraphHeaderSection extends StatelessWidget {
  final BloodPressurePatientDetailVm value;
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
              : context.HEIGHT * 0.5,
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
        Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 25,
            spacing: 25,
            children: [
              _infoSection(context),
              ElevatedButton(
                onPressed: () => value.showFilter(context),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  shadowColor: Colors.black.withAlpha(50),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(context.HEIGHT),
                  ),
                ),
                child: Text(
                  '${LocaleProvider.current.filter_graphs}',
                  maxLines: 1,
                  style: context.xHeadline5.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ])
      ],
    );
  }

  SizedBox _infoSection(BuildContext context) {
    return SizedBox(
      width: context.WIDTH * .3 * context.TEXTSCALE,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: context.WIDTH * .06,
                child: Divider(
                  thickness: 3,
                  color: Colors.red[900],
                ),
              ),
              SizedBox(width: context.WIDTH * .02),
              Text(LocaleProvider.current.sys)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: context.WIDTH * .06,
                child: Divider(
                  thickness: 3,
                  color: Colors.amber,
                ),
              ),
              SizedBox(width: context.WIDTH * .02),
              Text(LocaleProvider.current.dia)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: context.WIDTH * .06,
                child: Divider(
                  thickness: 3,
                  color: Colors.lime[800],
                ),
              ),
              SizedBox(width: context.WIDTH * .02),
              Text(LocaleProvider.current.pulse)
            ],
          ),
        ],
      ),
    );
  }
}
