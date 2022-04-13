import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scale_repository/scale_repository.dart';
import 'package:scale_calculations/scale_calculations.dart';

import '../../../../../../../core/core.dart';
import '../../scale_detail.dart';

class ScaleDetailScrollView extends StatelessWidget {
  final ScaleEntity scaleEntity;

  const ScaleDetailScrollView({
    Key? key,
    required this.scaleEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: R.sizes.defaultBottomValue,
      ),
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: _getChildren(),
      ),
    );
  }

  List<Widget> _getChildren() {
    var didntReachGoalsList = <ScaleExpansionModel>[];
    var reachGoalsList = <ScaleExpansionModel>[];

    final bmhVal = scaleEntity.bmh;
    if (bmhVal != null) {
      final result = _getExpansionModel(
        SelectedScaleType.bmh,
        bmhVal,
        '${bmhVal.xGetFriendyString} kcal',
      );
      if (result['isNormal']) {
        reachGoalsList.add(result['model']);
      } else {
        didntReachGoalsList.add(result['model']);
      }
    }

    final bodyFatVal = scaleEntity.bodyFat;
    if (bodyFatVal != null) {
      final result = _getExpansionModel(
        SelectedScaleType.bodyFat,
        bodyFatVal,
        '%${bodyFatVal.xGetFriendyString}',
      );
      if (result['isNormal']) {
        reachGoalsList.add(result['model']);
      } else {
        didntReachGoalsList.add(result['model']);
      }
    }

    final bmiVal = scaleEntity.bmi;
    if (bmiVal != null) {
      final result = _getExpansionModel(
        SelectedScaleType.bmi,
        bmiVal,
        bmiVal.xGetFriendyString,
      );
      if (result['isNormal']) {
        reachGoalsList.add(result['model']);
      } else {
        didntReachGoalsList.add(result['model']);
      }
    }

    final muscleVal = scaleEntity.muscle;
    if (muscleVal != null) {
      final result = _getExpansionModel(
        SelectedScaleType.muscle,
        muscleVal,
        '${muscleVal.xGetFriendyString} ${scaleEntity.getUnit}',
      );
      if (result['isNormal']) {
        reachGoalsList.add(result['model']);
      } else {
        didntReachGoalsList.add(result['model']);
      }
    }

    final waterVal = scaleEntity.water;
    if (waterVal != null) {
      final result = _getExpansionModel(
        SelectedScaleType.water,
        waterVal,
        '%${waterVal.xGetFriendyString}',
      );
      if (result['isNormal']) {
        reachGoalsList.add(result['model']);
      } else {
        didntReachGoalsList.add(result['model']);
      }
    }

    final visceralFatVal = scaleEntity.visceralFat;
    if (visceralFatVal != null) {
      final result = _getExpansionModel(
        SelectedScaleType.visceralFat,
        visceralFatVal,
        '%${visceralFatVal.xGetFriendyString}',
      );
      if (result['isNormal']) {
        reachGoalsList.add(result['model']);
      } else {
        didntReachGoalsList.add(result['model']);
      }
    }

    final boneMassVal = scaleEntity.boneMass;
    if (boneMassVal != null) {
      final result = _getExpansionModel(
        SelectedScaleType.boneMass,
        boneMassVal,
        '${boneMassVal.xGetFriendyString} ${scaleEntity.getUnit}',
      );
      if (result['isNormal']) {
        reachGoalsList.add(result['model']);
      } else {
        didntReachGoalsList.add(result['model']);
      }
    }

    return <Widget>[
      if (didntReachGoalsList.isNotEmpty)
        ScaleDetailExpansionComponent(
          isRedTheme: true,
          title: LocaleProvider.current.didnt_reach_goals,
          list: didntReachGoalsList,
        ),

      //
      if (reachGoalsList.isNotEmpty)
        ScaleDetailExpansionComponent(
          isRedTheme: false,
          title: LocaleProvider.current.reach_goal,
          list: reachGoalsList,
        ),
    ];
  }

  Map<String, dynamic> _getExpansionModel(
    SelectedScaleType type,
    double val,
    String valDesc,
  ) {
    final isNormal = ScaleCalculate.instance
        .checkNormalValue(Utils.instance.getGender(), type, val);
    final expansionModel = getExpansionModel(type, valDesc, val);
    return {'isNormal': isNormal, 'model': expansionModel};
  }

  ScaleExpansionModel getExpansionModel(
    SelectedScaleType type,
    String value,
    double currentValue,
  ) {
    switch (type) {
      case SelectedScaleType.bmh:
        {
          return ScaleExpansionModel(
            type: type,
            title: LocaleProvider.current.basal_metabolism,
            value: value,
            description: '',
            model: DynamicColorfulRangeModel(
              currentValue: currentValue,
              minValue: kBMHMinimum,
              maxValue: kBMHMaximum,
              breakpoints: kBMHRanges,
              colors: type.xGetColors,
              titles: [
                LocaleProvider.current.didnt_reach_goals,
                LocaleProvider.current.reach_goal,
              ],
            ),
          );
        }

      case SelectedScaleType.bodyFat:
        {
          return ScaleExpansionModel(
            type: type,
            title: LocaleProvider.current.scale_data_body_fat,
            value: value,
            description: '',
            model: DynamicColorfulRangeModel(
              currentValue: currentValue,
              minValue: kBodyFatMinimum(Utils.instance.getGender()),
              maxValue: kBodyFatMaximum(Utils.instance.getGender()),
              breakpoints: kBodyFatRanges(Utils.instance.getGender()),
              colors: type.xGetColors,
              titles: [
                LocaleProvider.current.low,
                LocaleProvider.current.normal,
                LocaleProvider.current.high,
                LocaleProvider.current.very_high,
              ],
            ),
          );
        }

      case SelectedScaleType.bmi:
        {
          return ScaleExpansionModel(
            type: type,
            title: LocaleProvider.current.scale_data_bmi,
            value: value,
            description: '',
            model: DynamicColorfulRangeModel(
              currentValue: currentValue,
              minValue: kBMIMinimum,
              maxValue: kBMIMaximum,
              breakpoints: kBMIRanges,
              colors: type.xGetColors,
              titles: [
                LocaleProvider.current.low,
                LocaleProvider.current.normal,
                LocaleProvider.current.increased,
                LocaleProvider.current.high,
                LocaleProvider.current.very_high,
              ],
            ),
          );
        }

      case SelectedScaleType.muscle:
        {
          return ScaleExpansionModel(
            type: type,
            title: LocaleProvider.current.scale_data_muscle,
            value: value,
            description: '',
            model: DynamicColorfulRangeModel(
              currentValue: currentValue,
              minValue: kMuscleMinimum(Utils.instance.getGender()),
              maxValue: kMuscleMaximum(Utils.instance.getGender()),
              breakpoints: kMuscleRanges(Utils.instance.getGender()),
              colors: type.xGetColors,
              titles: [
                LocaleProvider.current.low,
                LocaleProvider.current.normal,
                LocaleProvider.current.high,
                LocaleProvider.current.very_high,
              ],
            ),
          );
        }

      case SelectedScaleType.water:
        {
          return ScaleExpansionModel(
            type: type,
            title: LocaleProvider.current.scale_data_water,
            value: value,
            description: '',
            model: DynamicColorfulRangeModel(
              currentValue: currentValue,
              minValue: kWaterMinimum(Utils.instance.getGender()),
              maxValue: kWaterMaximum(Utils.instance.getGender()),
              breakpoints: kWaterRanges(Utils.instance.getGender()),
              colors: type.xGetColors,
              titles: [
                LocaleProvider.current.low,
                LocaleProvider.current.normal,
                LocaleProvider.current.high,
              ],
            ),
          );
        }

      case SelectedScaleType.visceralFat:
        {
          return ScaleExpansionModel(
            type: type,
            title: LocaleProvider.current.scale_data_visceral_fat,
            value: value,
            description: '',
            model: DynamicColorfulRangeModel(
              currentValue: currentValue,
              minValue: kVisceralFatMinimum,
              maxValue: kVisceralFatMaximum,
              breakpoints: kVisceralFatRanges,
              colors: type.xGetColors,
              titles: [
                LocaleProvider.current.normal,
                LocaleProvider.current.high,
                LocaleProvider.current.very_high,
              ],
            ),
          );
        }

      case SelectedScaleType.boneMass:
        {
          return ScaleExpansionModel(
            type: type,
            title: LocaleProvider.current.scale_data_bone_mass,
            value: value,
            description: '',
            model: DynamicColorfulRangeModel(
              currentValue: currentValue,
              minValue: kBoneMassMinimum,
              maxValue: kBoneMassMaximum,
              breakpoints: kBoneMassRanges,
              colors: type.xGetColors,
              titles: [
                LocaleProvider.current.insufficient,
                LocaleProvider.current.normal,
                LocaleProvider.current.great,
              ],
            ),
          );
        }

      case SelectedScaleType.weight:
        throw Exception("Not defined");
    }
  }
}

class ScaleDetailExpansionComponent extends StatefulWidget {
  final String title;
  final bool isRedTheme;
  final List<ScaleExpansionModel> list;

  const ScaleDetailExpansionComponent({
    Key? key,
    required this.title,
    required this.isRedTheme,
    required this.list,
  }) : super(key: key);

  @override
  _ScaleDetailExpansionComponentState createState() =>
      _ScaleDetailExpansionComponentState();
}

class _ScaleDetailExpansionComponentState
    extends State<ScaleDetailExpansionComponent> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          GestureDetector(
            onTap: () {
              if (mounted) {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              }
            },
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 12,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  //
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        //
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 6,
                            ),
                            child: Text(
                              widget.title,
                              style: context.xHeadline4.copyWith(
                                color: widget.isRedTheme
                                    ? R.color.darkRed
                                    : getIt<ITheme>().mainColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        //
                        R.sizes.wSizer4,

                        //
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.isRedTheme
                                ? R.color.darkRed
                                : getIt<ITheme>().mainColor,
                          ),
                          child: Text(
                            widget.list.length.toString(),
                            style: context.xHeadline3.copyWith(
                              color: getIt<ITheme>().textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: SvgPicture.asset(
                      R.image.arrowDown,
                      width: R.sizes.iconSize3,
                    ),
                  ),
                ],
              ),
            ),
          ),

          //
          SizedBox(
            width: double.infinity,
            child: RbioAnimatedClipRect(
              open: _isExpanded,
              alignment: Alignment.centerLeft,
              duration: const Duration(milliseconds: 250),
              child: Column(
                children: widget.list
                    .mapIndexed(
                      (index, element) => _buildCard(
                        topMargin: index != 0,
                        model: element,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    bool topMargin = true,
    required ScaleExpansionModel model,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: getIt<ITheme>().cardBackgroundColor,
        borderRadius: R.sizes.borderRadiusCircular,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 12,
      ),
      margin: EdgeInsets.only(
        top: topMargin ? 8 : 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //
              Expanded(
                child: Text(
                  model.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.xHeadline4.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              //
              Text(
                model.value,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: context.xHeadline4.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          //
          R.sizes.hSizer4,

          //
          _DynamicColorfulRange(
            model: model.model,
            type: model.type,
          ),

          //
          if (model.description.isNotEmpty)
            Text(
              model.description,
              style: context.xHeadline4.copyWith(
                color: getIt<ITheme>().textColorPassive,
              ),
            ),
        ],
      ),
    );
  }
}

class _DynamicColorfulRange extends StatelessWidget {
  final DynamicColorfulRangeModel model;
  final SelectedScaleType type;

  const _DynamicColorfulRange({
    Key? key,
    required this.model,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final maxWidth = constraints.maxWidth;

        final perPoint = (maxWidth / (model.maxValue - model.minValue));
        final currentPoint = model.currentValue >= model.maxValue
            ? maxWidth - 8
            : model.currentValue <= model.minValue
                ? 0.0
                : (model.currentValue - model.minValue) * perPoint;

        final containersWidths = _getContainerWidths(maxWidth);
        final containersPoints = _getPoints(containersWidths);

        return Container(
          height: 50,
          width: maxWidth,
          color: Colors.transparent,
          child: Stack(
            alignment: Alignment.center,
            children: [
              //
              ..._buildContainers(containersWidths, containersPoints),

              //
              ..._buildTitles(context, containersWidths, containersPoints),

              //
              ..._buildBreakpoints(context, containersWidths, containersPoints),

              //
              _getCurrentPoint(currentPoint),
            ],
          ),
        );
      },
    );
  }

  Widget _getCurrentPoint(double currentPoint) {
    return Positioned(
      left: currentPoint,
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: ScaleColors.instance.getCurrentBorderColor(
              Utils.instance.getGender(), type, model.currentValue),
          shape: BoxShape.circle,
          border: Border.all(
            color: ScaleColors.instance.getCurrentBorderColor(
                Utils.instance.getGender(), type, model.currentValue),
          ),
        ),
      ),
    );
  }

  Map<int, double> _getContainerWidths(double maxWidth) {
    final result = <int, double>{};
    for (int i = 0; i < model.titles.length; i++) {
      late double diff;

      if (i == 0) {
        // First Item
        diff = model.breakpoints.first - model.minValue;
      } else if (i == model.titles.length - 1) {
        // Last Item
        diff = model.maxValue - model.breakpoints.last;
      } else {
        //
        diff = model.breakpoints[i] - model.breakpoints[i - 1];
      }

      result[i] = diff;
    }

    final allDiffs = result.values
        .fold<double>(0.0, (previousValue, element) => previousValue + element);

    final perWidth = maxWidth / allDiffs;

    for (int i = 0; i < result.keys.length; i++) {
      result[i] = result[i]! * perWidth;
    }

    return result;
  }

  List<Widget> _buildContainers(
    Map<int, double> containersWidths,
    Map<int, double> containersPoints,
  ) {
    return containersPoints.entries.map<Widget>(
      (entry) {
        return Positioned(
          left: containersPoints[entry.key],
          width: containersWidths[entry.key],
          height: 3.0,
          child: Container(
            color: model.colors[entry.key],
          ),
        );
      },
    ).toList();
  }

  List<Widget> _buildTitles(
    BuildContext context,
    Map<int, double> containersWidths,
    Map<int, double> containersPoints,
  ) {
    return containersPoints.entries.map<Widget>(
      (entry) {
        return Positioned(
          top: 30,
          left: containersPoints[entry.key],
          width: containersWidths[entry.key],
          child: AutoSizeText(
            model.titles[entry.key],
            textAlign: TextAlign.center,
            minFontSize: 10,
            maxFontSize: 12,
            style: context.xHeadline3.copyWith(
              color: getIt<ITheme>().textColorPassive,
            ),
          ),
        );
      },
    ).toList();
  }

  List<Widget> _buildBreakpoints(
    BuildContext context,
    Map<int, double> containersWidths,
    Map<int, double> containersPoints,
  ) {
    return containersPoints.entries.map<Widget>(
      (entry) {
        if (entry.value > 0) {
          return Positioned(
            top: 3,
            left: entry.value - 12,
            width: containersWidths[entry.key],
            child: AutoSizeText(
              model.breakpoints[entry.key - 1].toString(),
              textAlign: TextAlign.left,
              minFontSize: 11,
              maxFontSize: 13,
              style: context.xHeadline3.copyWith(
                fontWeight: FontWeight.bold,
                color: getIt<ITheme>().textColorPassive,
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    ).toList();
  }

  Map<int, double> _getPoints(Map<int, double> result) {
    var points = <int, double>{};
    for (var entry in result.entries) {
      double left = 0;
      if (entry.key != 0) {
        for (int index = 0; index < entry.key; index++) {
          left += result[index]!;
        }
      }
      points[entry.key] = left;
    }
    return points;
  }
}
