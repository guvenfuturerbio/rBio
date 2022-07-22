import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/core.dart';
import '../../mediminder.dart';

class ExpandableSpecificDays extends StatefulWidget {
  final List<SelectableDay> days;
  final void Function(int index) onChanged;

  const ExpandableSpecificDays({
    Key? key,
    required this.days,
    required this.onChanged,
  }) : super(key: key);

  @override
  _ExpandableSpecificDaysState createState() => _ExpandableSpecificDaysState();
}

class _ExpandableSpecificDaysState extends State<ExpandableSpecificDays> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.xCardColor,
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
                        _getTitle(),
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
              alignment: Alignment.centerLeft,
              duration: const Duration(milliseconds: 250),
              child: Column(
                children: [
                  for (var index = 0; index < widget.days.length; index++)
                    _buildDayCard(index, context,
                        isBottomLine: index != widget.days.length - 1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getTitle() {
    String title = '';
    final list = widget.days;
    for (var element in list) {
      if (element.selected) {
        title += (title.isEmpty ? '' : ', ') + (element.shortName ?? '');
      }
    }
    return title;
  }

  Widget _buildDayCard(
    int index,
    BuildContext context, {
    bool isBottomLine = true,
  }) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              top: 12,
              bottom: 12,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //
                Expanded(
                  child: Text(
                    widget.days[index].name ?? '',
                    style: context.xHeadline4.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                //
                SizedBox(
                  height: R.sizes.iconSize,
                  width: R.sizes.iconSize,
                  child: RbioCheckbox(
                    value: widget.days[index].selected,
                    onChanged: (value) {
                      widget.onChanged(index);
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),

                //
                R.widgets.wSizer12,
              ],
            ),
          ),

          //
          if (isBottomLine)
            Container(
              color: context.xAppColors.textDisabledColor,
              height: 0.25,
            )
          else
            Container(),
        ],
      ),
    );
  }
}
