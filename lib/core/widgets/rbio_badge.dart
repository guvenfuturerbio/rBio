import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core.dart';

class RbioBadge extends StatelessWidget {
  final String image;
  final int? count;
  final bool isDark;
  final bool isBigSize;
  final String? path;
  final void Function()? onTap;

  const RbioBadge({
    Key? key,
    required this.image,
    this.count,
    this.isDark = true,
    this.isBigSize = true,
    this.path,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: isBigSize ? 40 : 30,
        width: isBigSize ? 40 : 30,
        child: Stack(
          fit: StackFit.expand,
          children: [
            //
            Positioned.fill(
              top: 4,
              right: 4,
              child: SvgPicture.asset(
                path ?? image,
                color: isDark
                    ? getIt<ITheme>().iconColor
                    : getIt<ITheme>().iconSecondaryColor,
                width: R.sizes.iconSize,
              ),
            ),

            //
            if (count != null) ...{
              Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  backgroundColor: R.color.darkRed,
                  radius: isBigSize ? 10.5 : 9,
                  child: Text(
                    '$count',
                    style: context.xBodyText1.copyWith(
                      color: getIt<ITheme>().textColor,
                    ),
                  ),
                ),
              ),
            },
          ],
        ),
      ),
    );
  }
}
