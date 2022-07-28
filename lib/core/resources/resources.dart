import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core.dart';

part 'api_enums.dart';
part 'colors.dart';
part 'constants.dart';
part 'images.dart';
part 'regexp.dart';
part 'sizes.dart';
part 'utils.dart';
part 'widgets.dart';

class R {
  static final apiEnums = _ApiEnums();
  static final colors = _Colors();
  static final constants = _Constants();
  static final image = _Images();
  static final regExp = _RegExp();
  static final sizes = _Sizes();
  static final utils = _Utils();
  static final widgets = _Widgets();
}
