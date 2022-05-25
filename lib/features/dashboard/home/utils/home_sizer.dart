import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class HomeSizer {
  HomeSizer._();

  static HomeSizer? _instance;

  static HomeSizer get instance {
    _instance ??= HomeSizer._();
    return _instance!;
  }

  double _getBodyHeight() =>
      Atom.height - 64 - Atom.safeTop - 12 - Atom.safeBottom - 5;

  double _getPartHeight() => _getBodyHeight() / 78;
  double getBodyGapHeight() => _getPartHeight() / 1; // 3
  double getBodySliderHeight() => _getPartHeight() * 15; // 15
  double getBodyCardHeight() => _getPartHeight() * 17; // 60
  double getRunSpacing() => Atom.width * .025;
  double getBodyCardWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return kIsWeb
        ? width > 1200
            ? 530
            : ((width - getRunSpacing()) / 2) - 60
        : ((width - getRunSpacing()) * .45);
  }

  double getBodyCardHeightLarge() => _getPartHeight() * 30;
  double getBodyCardHeightMedium() => _getPartHeight() * 25;
}
