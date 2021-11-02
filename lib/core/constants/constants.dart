import 'dart:ui';

import 'package:flutter/material.dart';

import '../enums/secret_keys.dart';
import '../utils/secret_utils.dart';
import 'package:atom/atom.dart';

part 'strings.dart';
part 'view.dart';
part 'endpoints.dart';
part 'images.dart';
part 'variables.dart';

class R {
  static final image = _Images();
  static final color = _Color();
  static final dynamicVar = _DynamicVariables();
  static final endpoints = _Endpoints();
  static final strings = _Strings();
  static final sizes = _Sizes();
}
