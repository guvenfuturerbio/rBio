import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:onedosehealth/core/manager/geolocator_manager.dart';
import 'package:vrouter/vrouter.dart';

import '../../../bootstrap.dart';
import '../../../core/core.dart';
import '../../../core/exception/undefined_endpoint_exception.dart';
import '../../../core/manager/recaptcha_manager.dart';
import '../../../features/dashboard/guven/dashboard_navigation.dart';
import '../../../features/dashboard/onedose/dashboard_navigation.dart';
import '../../app.dart';

part '../guven/endpoints/guven_access_token_endpoints.dart';
part '../guven/endpoints/guven_appointment_interpreter_endpoints.dart';
part '../guven/endpoints/guven_doctor_endpoints.dart';
part '../guven/endpoints/guven_file_endpoints.dart';
part '../guven/endpoints/guven_measurement_endpoints.dart';
part '../guven/endpoints/guven_package_endpoints.dart';
part '../guven/endpoints/guven_profile_endpoints.dart';
part '../guven/endpoints/guven_pusula_endpoints.dart';
part '../guven/endpoints/guven_single_endpoints.dart';
part '../guven/endpoints/guven_social_post_endpoints.dart';
part '../guven/endpoints/guven_suggestion_rate_endpoints.dart';
part '../guven/endpoints/guven_symptom_checker_endpoints.dart';
part '../guven/endpoints/guven_treatment_endpoints.dart';
part '../guven/endpoints/guven_user_endpoints.dart';
part '../guven/endpoints/guven_user_register_endpoints.dart';
part '../guven/guven_config.dart';
part '../guven/guven_constants.dart';
part '../guven/guven_endpoints.dart';
part '../guven/guven_functionality.dart';
part '../guven/guven_platform_config.dart';
part '../guven/guven_theme.dart';
part '../onedose/endpoints/onedose_access_token_endpoints.dart';
part '../onedose/endpoints/onedose_appointment_interpreter_endpoints.dart';
part '../onedose/endpoints/onedose_doctor_endpoints.dart';
part '../onedose/endpoints/onedose_file_endpoints.dart';
part '../onedose/endpoints/onedose_measurement_endpoints.dart';
part '../onedose/endpoints/onedose_package_endpoints.dart';
part '../onedose/endpoints/onedose_profile_endpoints.dart';
part '../onedose/endpoints/onedose_pusula_endpoints.dart';
part '../onedose/endpoints/onedose_single_endpoints.dart';
part '../onedose/endpoints/onedose_social_post_endpoints.dart';
part '../onedose/endpoints/onedose_suggestion_rate_endpoints.dart';
part '../onedose/endpoints/onedose_symptom_checker_endpoints.dart';
part '../onedose/endpoints/onedose_treatment_endpoints.dart';
part '../onedose/endpoints/onedose_user_endpoints.dart';
part '../onedose/endpoints/onedose_user_register_endpoints.dart';
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
    required this.constants,
  });

  void setEndpoints();
  void setDeviceConfig();
  IProductDashboard getDashboard();
}

enum ProductType {
  oneDose,
  guven,
}

abstract class IProductDashboard extends VRouteElementBuilder {}
