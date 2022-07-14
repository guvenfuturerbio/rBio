import 'package:flutter/material.dart';

import '../core.dart';

export 'colors.dart';

part 'api_enums.dart';
part 'constants.dart';
part 'images.dart';
part 'regexp.dart';
part 'sizes.dart';
part 'utils.dart';
part 'widgets.dart';

class R {
  static final apiEnums = _ApiEnums();
  static final constants = _Constants();
  static final image = _Images();
  static final regExp = _RegExp();
  static final sizes = _Sizes();
  static final utils = _Utils();
  static final widgets = _Widgets();
}
