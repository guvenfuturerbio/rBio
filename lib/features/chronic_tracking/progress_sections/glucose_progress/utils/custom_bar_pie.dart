import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/core.dart';
import '../view_model/bg_progress_page_view_model.dart';

class CustomBarPie extends StatelessWidget {
  final double width;
  final double height;

  const CustomBarPie({
    Key? key,
    this.width = 10.0,
    this.height = 10.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BgProgressPageViewModel>(builder: (context, value, child) {
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
                            colors: [R.color.very_low, R.color.very_low],
                            begin: Alignment.topLeft,
                            end: Alignment.topRight),
                      ),
                      child: animatedCount(value.totalValuableCount == 0
                          ? 0
                          : (value.chartVeryLow.length /
                                  value.totalValuableCount) *
                              100)),
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
                            colors: [R.color.low, R.color.low],
                            begin: Alignment.topLeft,
                            end: Alignment.topRight),
                      ),
                      child: animatedCount(value.totalValuableCount == 0
                          ? 0
                          : (value.chartLow.length / value.totalValuableCount) *
                              100)),
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
                            colors: [R.color.target, R.color.target],
                            begin: Alignment.topLeft,
                            end: Alignment.topRight),
                      ),
                      child: animatedCount(value.totalValuableCount == 0
                          ? 0
                          : (value.chartTarget.length /
                                  value.totalValuableCount) *
                              100)),
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
                            colors: [R.color.high, R.color.high],
                            begin: Alignment.topLeft,
                            end: Alignment.topRight),
                      ),
                      child: animatedCount(value.totalValuableCount == 0
                          ? 0
                          : (value.chartHigh.length /
                                  value.totalValuableCount) *
                              100)),
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
                            colors: [R.color.very_high, R.color.very_high],
                            begin: Alignment.topLeft,
                            end: Alignment.topRight),
                      ),
                      child: animatedCount(value.totalValuableCount == 0
                          ? 0
                          : (value.chartVeryHigh.length /
                                  value.totalValuableCount) *
                              100)),
                ],
              ),
      );
    });
  }
}

Widget animatedCount(double count) {
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
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        )
      : Container();
}
