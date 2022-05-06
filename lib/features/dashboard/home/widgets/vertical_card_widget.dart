import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../utils/home_sizer.dart';

class VerticalCard extends StatelessWidget {
  final String title;
  final CustomPainter painter;

  const VerticalCard({
    Key? key,
    required this.title,
    required this.painter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeVm, child) => SizedBox(
        width: HomeSizer.instance.getBodyCardWidth(context),
        height: themeVm.textScale == TextScaleType.large
            ? HomeSizer.instance.getBodyCardHeightLarge()
            : themeVm.textScale == TextScaleType.medium
                ? HomeSizer.instance.getBodyCardHeightMedium()
                : HomeSizer.instance.getBodyCardHeight(),
        child: Card(
          elevation: R.sizes.defaultElevation,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: R.sizes.borderRadiusCircular,
          ),
          child: Stack(
            children: [
              //
              Align(
                alignment: Alignment.topRight,
                child: CustomPaint(
                  size: Size(Atom.height * 0.10, Atom.height * 0.10),
                  painter: painter,
                ),
              ),

              //
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    maxLines: 3,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: getIt<IAppConfig>().theme.textTheme.headline3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
