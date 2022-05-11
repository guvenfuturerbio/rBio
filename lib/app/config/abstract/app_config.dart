import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../bootstrap.dart';
import '../../../core/core.dart';
import '../../../core/exception/undefined_endpoint_exception.dart';
import '../../../core/manager/adjust_manager.dart';
import '../../app.dart';

part '../guven/guven_config.dart';
part '../guven/guven_constants.dart';
part '../guven/guven_endpoints.dart';
part '../guven/guven_functionality.dart';
part '../guven/guven_platform_config.dart';
part '../guven/guven_theme.dart';
part '../onedose/onedose_config.dart';
part '../onedose/onedose_constants.dart';
part '../onedose/onedose_endpoints.dart';
part '../onedose/onedose_functionality.dart';
part '../onedose/onedose_platform_config.dart';
part '../onedose/onedose_theme.dart';
part 'app_constants.dart';
part 'app_endpoints.dart';
part 'app_functionality.dart';
part 'app_platform_config.dart';
part 'app_theme.dart';

abstract class IAppConfig<T extends IAppPlatformConfig> {
  final String title;
  late ProductType productType;
  late IAppTheme theme;
  late IAppFunctionality functionality;
  late IAppEndpoints endpoints;
  late IAppConstants constants;
  late T platform;

  IAppConfig({
    required this.title,
    required this.productType,
    required this.theme,
    required this.functionality,
    required this.endpoints,
    required this.constants,
  });

  void setDeviceConfig();
}

enum ProductType {
  oneDose,
  guven,
}
