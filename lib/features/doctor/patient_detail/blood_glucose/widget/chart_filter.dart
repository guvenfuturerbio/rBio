part of '../view/bg_patient_detail_screen.dart';

class _ChartFilter extends StatelessWidget {
  final double width;
  final double height;

  const _ChartFilter({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(10),
        child: Consumer<BgPatientDetailVm>(
          builder: (
            BuildContext context,
            BgPatientDetailVm value,
            Widget? child,
          ) {
            return _buildPadding(context, value);
          },
        ),
      ),
    );
  }

  Widget _buildPadding(
    BuildContext context,
    BgPatientDetailVm value,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.width * .03),
      child: SizedBox(
        width: width,
        child: Card(
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                //
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    children: value.colorInfo.keys
                        .map(
                          (color) => _colorFilterItem(
                              context: context,
                              text: value.colorInfo[color]!.toShortString(),
                              status: value
                                  .isFilterSelected(value.colorInfo[color]!),
                              color: color,
                              size: 15,
                              statCallback: (_) =>
                                  value.setFilterState(value.colorInfo[color]!),
                              isHungry: false),
                        )
                        .toList(),
                  ),
                ),

                //
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    children: value.states
                        .map(
                          (state) => _colorFilterItem(
                            context: context,
                            text: state.toShortString(),
                            status: value.isFilterSelected(state),
                            color: getIt<IAppConfig>().theme.stateColor,
                            size: 15,
                            style: state == GlucoseMarginsFilter.full ||
                                    state == GlucoseMarginsFilter.hungry
                                ? BoxShape.circle
                                : BoxShape.rectangle,
                            statCallback: (_) => value.setFilterState(state),
                            isHungry: state == GlucoseMarginsFilter.hungry,
                          ),
                        )
                        .toList(),
                  ),
                ),

                //
                Center(
                  child: Wrap(
                    spacing: 8.0,
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      //
                      RbioElevatedButton(
                        title: LocaleProvider.current.cancel,
                        onTap: () {
                          Atom.dismiss();
                        },
                        backColor: context.xCardColor,
                        textColor: getIt<IAppConfig>().theme.textColorSecondary,
                      ),

                      //
                      RbioElevatedButton(
                        title: LocaleProvider.current.save,
                        onTap: () {
                          Atom.dismiss();
                        },
                      ),
                    ],
                  ),
                ),

                //
                Center(
                  child: TextButton(
                    onPressed: () => value.resetFilterValues(),
                    child: Text(
                      LocaleProvider.current.reset_filter_value,
                      style:
                          const TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _colorFilterItem({
    required BuildContext context,
    required double size,
    required String text,
    required Color color,
    required bool status,
    BoxShape? style,
    required void Function(bool?) statCallback,
    required bool isHungry,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          Container(
            height: size,
            width: size,
            margin: const EdgeInsets.symmetric(horizontal: 25),
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
              text,
              style: context.xHeadline4.copyWith(),
            ),
          ),

          //
          Expanded(
            child: SizedBox(
              height: size,
              width: size,
              child: RbioCheckbox(
                value: status,
                onChanged: statCallback,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
