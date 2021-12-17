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
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  children: value.colorInfo.keys
                      .map(
                        (color) => _colorFilterItem(
                            context: context,
                            text: value.colorInfo[color].toShortString(),
                            status:
                                value.isFilterSelected(value.colorInfo[color]),
                            color: color,
                            size: 15,
                            statCallback: (_) =>
                                value.setFilterState(value.colorInfo[color]),
                            isHungry: false),
                      )
                      .toList(),
                ),
              ),

              //
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  children: value.states
                      .map(
                        (state) => _colorFilterItem(
                            context: context,
                            text: state.toShortString(),
                            status: value.isFilterSelected(state),
                            color: R.color.state_color,
                            size: 15,
                            style: state == LocaleProvider.current.full ||
                                    state == LocaleProvider.current.hungry
                                ? BoxShape.circle
                                : BoxShape.rectangle,
                            statCallback: (_) => value.setFilterState(state),
                            isHungry: state == LocaleProvider.current.hungry),
                      )
                      .toList(),
                ),
              ),

              //
              // Wrap(
              //   crossAxisAlignment: WrapCrossAlignment.center,
              //   children: [
              //     //
              //     GestureDetector(
              //       onTap: () {
              //         //
              //       },
              //       child: Card(
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(25),
              //         ),
              //         elevation: 4,
              //         child: Container(
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(25),
              //             gradient: LinearGradient(
              //                 begin: Alignment.bottomRight,
              //                 end: Alignment.topLeft,
              //                 colors: <Color>[R.color.white, R.color.white]),
              //           ),
              //           padding:
              //               EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              //           child: Text(
              //             LocaleProvider.current.cancel,
              //             softWrap: false,
              //             style: TextStyle(color: Colors.black, fontSize: 17),
              //           ),
              //         ),
              //       ),
              //     ),

              //     //
              //     GestureDetector(
              //       onTap: () {
              //         //
              //       },
              //       child: RbioElevatedButton(
              //         title: '${LocaleProvider.current.save}',
              //       ),

              //       child: Card(
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(25),
              //         ),
              //         elevation: 4,
              //         child: Container(
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(25),
              //             gradient: LinearGradient(
              //               begin: Alignment.bottomRight,
              //               end: Alignment.topLeft,
              //               colors: <Color>[
              //                 R.btnLightBlue,
              //                 R.btnDarkBlue,
              //               ],
              //             ),
              //           ),
              //           padding:
              //               EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              //           child: Text(
              //             '${LocaleProvider.current.save}',
              //             maxLines: 1,
              //             textAlign: TextAlign.center,
              //             softWrap: false,
              //             style: TextStyle(color: Colors.white, fontSize: 17),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),

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
    @required BuildContext context,
    @required double size,
    @required String text,
    @required Color color,
    @required bool status,
    BoxShape style,
    @required Function(bool) statCallback,
    @required bool isHungry,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          Container(
            height: size,
            width: size,
            margin: EdgeInsets.symmetric(horizontal: 25),
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
          Expanded(
            flex: 2,
            child: Text(
              '$text',
              style: context.xHeadline4.copyWith(),
            ),
          ),

          //
          Expanded(
            child: SizedBox(
              height: size,
              width: size,
              child: Checkbox(
                value: status,
                onChanged: statCallback,
                activeColor: getIt<ITheme>().mainColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
