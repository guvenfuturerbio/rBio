import 'package:flutter/material.dart';

import '../core.dart';

part 'bodydatas.dart';
part 'device_guides.dart';
part 'endpoints.dart';
part 'images.dart';
part 'regexp.dart';
part 'strings.dart';
part 'variables.dart';
part 'view.dart';

class R {
  static final image = _Images();
  static final color = _Color();
  static final dynamicVar = _DynamicVariables();
  static final endpoints = _Endpoints();
  static final strings = _Strings();
  static final sizes = _Sizes();
  static final regExp = _RegExp();
  static final constants = _Constants();
  static final deviceGuides = _DeviceGuides();
}
