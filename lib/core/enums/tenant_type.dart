import 'package:flutter/material.dart';

import '../core.dart';

enum TenantType {
  ayranci,
  cayyolu,
  online;

  String getTitle(BuildContext context) {
    if (name == TenantType.ayranci.name) {
      return LocaleProvider.of(context).guven_hospital_ayranci;
    } else if (name == TenantType.cayyolu.name) {
      return LocaleProvider.of(context).guven_cayyolu_campus;
    }

    return LocaleProvider.current.online_hospital;
  }
}

extension TenantTypeExtensions on int? {
  String xGetTenantTitle(BuildContext context) {
    final tenantType = xGetTenant;
    return tenantType.getTitle(context);
  }

  TenantType get xGetTenant {
    if (this == R.constants.tenantAyranciId) {
      return TenantType.ayranci;
    } else if (this == R.constants.tenantCayyoluId) {
      return TenantType.cayyolu;
    }

    return TenantType.online;
  }
}
