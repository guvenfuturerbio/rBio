import 'package:flutter/material.dart';

import '../core.dart';

part 'constants.dart';
part 'endpoints.dart';
part 'images.dart';
part 'regexp.dart';
part 'view.dart';

class R {
  static final image = _Images();
  static final color = _Color();
  static final endpoints = _Endpoints();
  static final sizes = _Sizes();
  static final regExp = _RegExp();
  static final constants = _Constants();
}
