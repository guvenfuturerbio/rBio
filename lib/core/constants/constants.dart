import 'package:flutter/material.dart';

import '../core.dart';

part 'strings.dart';
part 'view.dart';
part 'endpoints.dart';
part 'images.dart';
part 'variables.dart';
part 'regexp.dart';
part 'bodydatas.dart';
part 'device_guides.dart';

class R {
  static final image = _Images();
  static final color = _Color();
  static final dynamicVar = _DynamicVariables();
  static final endpoints = _Endpoints();
  static final strings = _Strings();
  static final sizes = _Sizes();
  static final regExp = _RegExp();
  static final bodyDatas = _Constants();
  static final deviceGuides = _DeviceGuides();
}
