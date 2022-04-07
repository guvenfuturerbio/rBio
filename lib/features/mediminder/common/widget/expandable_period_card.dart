import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/core.dart';
import '../../mediminder.dart';

class ExpandablePeriodCard extends StatefulWidget {
  final ReminderPeriod? initValue;
  final bool isReset;
  final ValueChanged<ReminderPeriod> onChanged;

  const ExpandablePeriodCard({
    Key? key,
    this.initValue,
    required this.isReset,
    required this.onChanged,
  }) : super(key: key);

  @override
  _ExpandablePeriodCardState createState() => _ExpandablePeriodCardState();
}

class _ExpandablePeriodCardState extends State<ExpandablePeriodCard> {
  ReminderPeriod? _selectedPeriod;
  bool _isExpanded = true;

  @override
  void initState() {
    if (widget.initValue != null) {
      _selectedPeriod = widget.initValue!;
      _isExpanded = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isReset) {
      _selectedPeriod = null;
      _isExpanded = true;
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: getIt<ITheme>().cardBackgroundColor,
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
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 6,
                      ),
                      child: Text(
                        _selectedPeriod == null
                            ? ''
                            : _selectedPeriod!.toShortString(),
                        style: context.xHeadline4,
                      ),
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
              alignment: Alignment.center,
              duration: const Duration(milliseconds: 250),
              child: Column(
                children: [
                  _buildTextTile(
                    period: ReminderPeriod.oneTime,
                  ),
                  _buildTextTile(
                    period: ReminderPeriod.everyDay,
                  ),
                  _buildTextTile(
                    period: ReminderPeriod.specificDays,
                    isBottomLine: false,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextTile({
    required ReminderPeriod period,
    bool isBottomLine = true,
  }) {
    return GestureDetector(
      onTap: () {
        if (widget.isReset) {
          widget.onChanged(period);
          Future.delayed(
            const Duration(milliseconds: 100),
            () {
              if (mounted) {
                setState(() {
                  _selectedPeriod = period;
                  _isExpanded = false;
                });
              }
            },
          );
        } else {
          if (mounted) {
            setState(() {
              _selectedPeriod = period;
              _isExpanded = false;
            });
          }
          widget.onChanged(period);
        }
      },
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            Padding(
              padding: const EdgeInsets.only(
                left: 6,
                top: 12,
                bottom: 12,
              ),
              child: Text(
                period.toShortString(),
                textAlign: TextAlign.left,
                style: context.xHeadline4.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            //
            if (isBottomLine)
              Container(
                color: getIt<ITheme>().textColorPassive,
                height: 0.25,
              )
            else
              Container(),
          ],
        ),
      ),
    );
  }
}
