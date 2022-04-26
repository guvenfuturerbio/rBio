import 'package:flutter/material.dart';

import '../../../core/core.dart';

part '../guven/guven_config.dart';
part '../guven/guven_endpoints.dart';
part '../guven/guven_functionality.dart';
part '../guven/guven_theme.dart';
part '../onedose/onedose_config.dart';
part '../onedose/onedose_endpoints.dart';
part '../onedose/onedose_functionality.dart';
part '../onedose/onedose_theme.dart';
part 'app_endpoints.dart';
part 'app_functionality.dart';
part 'app_theme.dart';

abstract class IAppConfig {
  late ProductType productType;
  late IAppTheme theme;
  late IAppFunctionality functionality;
  late IAppEndpoints endpoints;

  IAppConfig({
    required this.productType,
    required this.theme,
    required this.functionality,
    required this.endpoints,
  });
}

enum ProductType {
  oneDose,
  guven,
}
