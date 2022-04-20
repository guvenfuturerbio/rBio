part of '../view/bg_patient_detail_screen.dart';

class _CustomBarPie extends StatelessWidget {
  final double width;
  final double height;

  const _CustomBarPie({
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<BgPatientDetailVm>(builder: (
      BuildContext context,
      BgPatientDetailVm value,
      Widget? child,
    ) {
      return _buildContainer(value);
    });
  }

  Widget _buildContainer(BgPatientDetailVm value) {
    return SizedBox(
      width: width,
      child: value.totalValuableCount == 0
          ? SizedBox(
              height: height,
              child: Center(
                child: Text(LocaleProvider.current.no_measurement),
              ),
            )
          : Row(
              children: [
                //
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  height: height,
                  width: value.totalValuableCount == 0
                      ? 0
                      : width *
                          value.chartVeryLow.length /
                          value.totalValuableCount,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [getIt<IAppConfig>().theme.veryLow, getIt<IAppConfig>().theme.veryLow],
                        begin: Alignment.topLeft,
                        end: Alignment.topRight),
                  ),
                  child: _animatedCount(value.totalValuableCount == 0
                      ? 0
                      : (value.chartVeryLow.length / value.totalValuableCount) *
                          100),
                ),

                //
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  height: height,
                  width: value.totalValuableCount == 0
                      ? 0
                      : width *
                          value.chartLow.length /
                          value.totalValuableCount,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [getIt<IAppConfig>().theme.low, getIt<IAppConfig>().theme.low],
                        begin: Alignment.topLeft,
                        end: Alignment.topRight),
                  ),
                  child: _animatedCount(value.totalValuableCount == 0
                      ? 0
                      : (value.chartLow.length / value.totalValuableCount) *
                          100),
                ),

                //
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  height: height,
                  width: value.totalValuableCount == 0
                      ? 0
                      : width *
                          value.chartTarget.length /
                          value.totalValuableCount,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [getIt<IAppConfig>().theme.target, getIt<IAppConfig>().theme.target],
                        begin: Alignment.topLeft,
                        end: Alignment.topRight),
                  ),
                  child: _animatedCount(value.totalValuableCount == 0
                      ? 0
                      : (value.chartTarget.length / value.totalValuableCount) *
                          100),
                ),

                //
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  height: height,
                  width: value.totalValuableCount == 0
                      ? 0
                      : width *
                          value.chartHigh.length /
                          value.totalValuableCount,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [getIt<IAppConfig>().theme.high, getIt<IAppConfig>().theme.high],
                        begin: Alignment.topLeft,
                        end: Alignment.topRight),
                  ),
                  child: _animatedCount(value.totalValuableCount == 0
                      ? 0
                      : (value.chartHigh.length / value.totalValuableCount) *
                          100),
                ),

                //
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  height: height,
                  width: value.totalValuableCount == 0
                      ? 0
                      : width *
                          value.chartVeryHigh.length /
                          value.totalValuableCount,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [getIt<IAppConfig>().theme.veryHigh, getIt<IAppConfig>().theme.veryHigh],
                        begin: Alignment.topLeft,
                        end: Alignment.topRight),
                  ),
                  child: _animatedCount(value.totalValuableCount == 0
                      ? 0
                      : (value.chartVeryHigh.length /
                              value.totalValuableCount) *
                          100),
                ),
              ],
            ),
    );
  }

  Widget _animatedCount(double count) {
    return count > 0.0
        ? Padding(
            padding: const EdgeInsets.all(3.0),
            child: Center(
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Column(
                  children: [
                    const Text("%"),
                    Countup(
                      begin: 0.0,
                      end: count,
                      precision: 1,
                      duration: const Duration(seconds: 1),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Container();
  }
}
