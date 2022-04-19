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
  IAppTheme get theme;
  IAppFunctionality get functionality;
  IAppEndpoints get endpoints;
}
