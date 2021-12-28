import 'package:flutter/material.dart';
import 'package:onedosehealth/core/core.dart';

class HomeSizer {
  HomeSizer._();

  static HomeSizer _instance;

  static HomeSizer get instance {
    _instance ??= HomeSizer._();
    return _instance;
  }

  double _getBodyHeight() =>
      Atom.height - 64 - Atom.safeTop - 12 - Atom.safeBottom - 5;
  double _getPartHeight() => _getBodyHeight() / 43;
  double getBodyGapHeight() => _getPartHeight() / 1;
  double getBodySliderHeight() => _getPartHeight() * 15;
  double getBodyCardHeight() => _getPartHeight() * 10;
  double getBodyUserTileHeight() => _getPartHeight() * 5;

  double getRunSpacing() => Atom.width * .025;

  double getWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 576) {
      return width * .29;
    } else if (width < 860) {
      return width * 0.27;
    } else if (width < 1000) {
      return width * 0.26;
    } else if (width < 1350) {
      return width * 0.23;
    } else if (width < 1600) {
      return width * 0.1871;
    }

    return width * 0.170;
  }
}
