import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../features/chronic_tracking/scale/scale.dart';
import '../core.dart';

class RbioDetailSearchComponent extends StatefulWidget {
  final ScaleTreatmentListResult result;
  final void Function(DateTime date) onStartDateChange;
  final void Function(DateTime date) onEndDateChange;
  final void Function(TreatmentFilterType value) onTypeChange;

  const RbioDetailSearchComponent({
    Key? key,
    required this.result,
    required this.onStartDateChange,
    required this.onEndDateChange,
    required this.onTypeChange,
  }) : super(key: key);

  @override
  _RbioDetailSearchComponentState createState() =>
      _RbioDetailSearchComponentState();
}

class _RbioDetailSearchComponentState extends State<RbioDetailSearchComponent>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  var val = TreatmentFilterType.current;

  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  late AnimationController _controller;
  late Animation<double> _iconTurns;

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: getIt<IAppConfig>().theme.cardBackgroundColor,
        borderRadius: R.sizes.borderRadiusCircular,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
                if (_isExpanded) {
                  _controller.forward();
                } else {
                  _controller.reverse().then<void>((void value) {
                    if (!mounted) return;
                    setState(() {
                      // Rebuild without widget.children.
                    });
                  });
                }
                PageStorage.of(context)?.writeState(context, _isExpanded);
              });
            },
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 18,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  //
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: R.sizes.borderRadiusCircular,
                      ),
                      child: Text(
                        LocaleProvider.of(context).detail_search,
                        style: context.xHeadline4,
                      ),
                    ),
                  ),

                  //
                  RotationTransition(
                    turns: _iconTurns,
                    child: SizedBox(
                      height: R.sizes.iconSize2,
                      width: R.sizes.iconSize2,
                      child: SvgPicture.asset(
                        R.image.arrowDown,
                      ),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        //
                        RbioRadio(
                          value: TreatmentFilterType.current,
                          groupValue: val,
                          onChanged: (_) => onChange(_),
                        ),

                        //
                        GestureDetector(
                          onTap: () => onChange(TreatmentFilterType.current),
                          child: Text(
                            LocaleProvider.of(context).current_treatments,
                            style: context.xHeadline3.copyWith(
                              color: val == TreatmentFilterType.current
                                  ? context.xPrimaryColor
                                  : null,
                            ),
                          ),
                        ),

                        //
                        RbioRadio(
                          value: TreatmentFilterType.past,
                          groupValue: val,
                          onChanged: (_) => onChange(_),
                        ),

                        //
                        GestureDetector(
                          onTap: () => onChange(TreatmentFilterType.past),
                          child: Text(
                            LocaleProvider.of(context).past_treatments,
                            style: context.xHeadline3.copyWith(
                              color: val == TreatmentFilterType.past
                                  ? context.xPrimaryColor
                                  : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //
                  if (val == TreatmentFilterType.past) ...[
                    //
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: GuvenDateRange(
                        backColor: getIt<IAppConfig>().theme.grayColor,
                        startCurrentDate: widget.result.startCurrentDate,
                        endCurrentDate: widget.result.endCurrentDate,
                        onStartDateChange: (date) {
                          if (!widget.result.startCurrentDate
                              .xIsSameDate(date)) {
                            widget.onStartDateChange(date);
                          }
                        },
                        onEndDateChange: (date) {
                          if (!widget.result.endCurrentDate.xIsSameDate(date)) {
                            widget.onEndDateChange(date);
                          }
                        },
                        startMinDate: DateTime(1900).getStartOfTheDay,
                        startMaxDate: DateTime.now().getStartOfTheDay,
                        endMinDate: DateTime.now().getStartOfTheDay,
                        endMaxDate: DateTime.now()
                            .add(const Duration(days: 365))
                            .getStartOfTheDay,
                      ),
                    ),

                    //
                    R.widgets.hSizer20,
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onChange(TreatmentFilterType value) {
    if (mounted) {
      setState(() {
        val = value;
      });
    }

    widget.onTypeChange(value);
  }
}
