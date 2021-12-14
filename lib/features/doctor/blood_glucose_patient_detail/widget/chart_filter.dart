part of '../view/blood_glucose_patient_detail_screen.dart';

class _ChartFilter extends StatelessWidget {
  final double width;
  final double height;

  const _ChartFilter({
    Key key,
    @required this.width,
    @required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(10),
        child: Consumer<BloodGlucosePatientDetailVm>(
          builder: (
            BuildContext context,
            BloodGlucosePatientDetailVm value,
            Widget child,
          ) {
            return _buildPadding(context, value);
          },
        ),
      ),
    );
  }

  Widget _buildPadding(
    BuildContext context,
    BloodGlucosePatientDetailVm value,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.WIDTH * .03),
      child: SizedBox(
        height: height,
        width: width,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: R.sizes.borderRadiusCircular,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              Padding(
                padding: EdgeInsets.symmetric(vertical: context.HEIGHT * .01),
                child: Column(
                  children: value.colorInfo.keys
                      .map((color) => _colorFilterItem(
                          text: value.colorInfo[color].toShortString(),
                          status:
                              value.isFilterSelected(value.colorInfo[color]),
                          color: color,
                          size: 15,
                          statCallback: (_) =>
                              value.setFilterState(value.colorInfo[color]),
                          isHungry: false))
                      .toList(),
                ),
              ),

              //
              Padding(
                padding: EdgeInsets.symmetric(vertical: context.HEIGHT * .01),
                child: Column(
                  children: value.states
                      .map((state) => _colorFilterItem(
                          text: state.toShortString(),
                          status: value.isFilterSelected(state),
                          color: R.color.state_color,
                          size: 15,
                          style: state == LocaleProvider.current.full ||
                                  state == LocaleProvider.current.hungry
                              ? BoxShape.circle
                              : BoxShape.rectangle,
                          statCallback: (_) => value.setFilterState(state),
                          isHungry: state == LocaleProvider.current.hungry))
                      .toList(),
                ),
              ),

              //
              TextButton(
                onPressed: () => value.resetFilterValues(),
                child: Text(
                  '${LocaleProvider.current.reset_filter_value}',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _colorFilterItem({
    double size,
    String text,
    Color color,
    bool status,
    BoxShape style,
    Function(bool) statCallback,
    bool isHungry,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25),
            height: size,
            width: size,
            decoration: BoxDecoration(
              shape: style ?? BoxShape.circle,
              color: isHungry ? Colors.transparent : color,
              border: Border.all(
                color: color,
                width: 2.0,
              ),
            ),
          ),

          //
          Expanded(flex: 2, child: Text('$text')),

          //
          Expanded(
              child: SizedBox(
                  height: size,
                  width: size,
                  child: Checkbox(value: status, onChanged: statCallback)))
        ],
      ),
    );
  }
}
