import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../mediminder.dart';

class SelectableUsageType extends StatelessWidget {
  final UsageType? activeType;
  final void Function(UsageType usageType) onChanged;

  const SelectableUsageType({
    Key? key,
    this.activeType,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        ReminderBoldTitle(
          title: LocaleProvider.current.tag_description,
        ),

        //
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: _buildUsageTypeCard(
                context,
                activeType == UsageType.hungry,
                UsageType.hungry,
              ),
            ),

            //
            R.widgets.wSizer12,

            //
            Expanded(
              child: _buildUsageTypeCard(
                context,
                activeType == UsageType.full,
                UsageType.full,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUsageTypeCard(
    BuildContext context,
    bool isActive,
    UsageType usageType,
  ) {
    final _text = Text(
      usageType.toShortString(),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.start,
      style: context.xHeadline4.copyWith(
        color: isActive
            ? getIt<IAppConfig>().theme.textColor
            : getIt<IAppConfig>().theme.textColorPassive,
      ),
    );

    return GestureDetector(
      onTap: () {
        onChanged(usageType);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isActive ? getIt<IAppConfig>().theme.mainColor : Colors.white,
          borderRadius: R.sizes.borderRadiusCircular,
        ),
        child: _text,
      ),
    );
  }
}
