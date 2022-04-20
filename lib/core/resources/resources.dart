import 'package:flutter/material.dart';

import '../core.dart';

part 'api_enums.dart';
part 'constants.dart';

part 'images.dart';
part 'regexp.dart';
part 'view.dart';

class R {
  static final apiEnums = _ApiEnums();
  static final image = _Images();
  static final color = _Color();
  static final sizes = _Sizes();
  static final regExp = _RegExp();
  static final constants = _Constants();
}
