import 'package:flutter/material.dart';

import '../core.dart';

export 'colors.dart';

part 'api_enums.dart';
part 'constants.dart';
part 'images.dart';
part 'regexp.dart';
part 'sizes.dart';
part 'widgets.dart';
part 'utils.dart';

class R {
  static final apiEnums = _ApiEnums();
  static final image = _Images();
  static final sizes = _Sizes();
  static final regExp = _RegExp();
  static final constants = _Constants();
  static final widgets = _Widgets();
  static final utils = _Utils();
}
