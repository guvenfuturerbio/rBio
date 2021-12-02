enum Environment { DEV, STAGING, PROD }

class BuildConfigurations {
  static Map<String, dynamic> _config;

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.DEV:
        _config = _Config.debugBuildConfigurations;
        break;
      case Environment.STAGING:
        _config = _Config.qaBuildConfigurations;
        break;
      case Environment.PROD:
        _config = _Config.prodBuildConfigurations;
        break;
    }
  }

  // ignore: non_constant_identifier_names
  static get SSO_URL {
    return _config[_Config.SSO_URL];
  }

  // ignore: non_constant_identifier_names
  static get DOCTOR_SSO_URL {
    return _config[_Config.DOCTOR_SSO_URL];
  }

  // ignore: non_constant_identifier_names
  static get BASE_URL {
    return _config[_Config.BASE_URL];
  }

  // ignore: non_constant_identifier_names
  static get DOCTOR_BASE_URL {
    return _config[_Config.DOCTOR_BASE_URL];
  }

  // ignore: non_constant_identifier_names
  static get CLIENT_ID {
    return _config[_Config.CLIENT_ID];
  }

  // ignore: non_constant_identifier_names
  static get DOCTOR_CLIENT_ID {
    return _config[_Config.DOCTOR_CLIENT_ID];
  }

  // ignore: non_constant_identifier_names
  static get CLIENT_SECRET {
    return _config[_Config.CLIENT_SECRET];
  }

  // ignore: non_constant_identifier_names
  static get DOCTOR_CLIENT_SECRET {
    return _config[_Config.DOCTOR_CLIENT_SECRET];
  }
}

class _Config {
  static const SSO_URL = "SSO_URL";
  static const BASE_URL = "BASE_URL";
  static const CLIENT_ID = "CLIENT_ID";
  static const CLIENT_SECRET = "CLIENT_SECRET";
  static const DOCTOR_SSO_URL = "DOCTOR_SSO_URL";
  static const DOCTOR_BASE_URL = "DOCTOR_BASE_URL";
  static const DOCTOR_CLIENT_ID = "DOCTOR_CLIENT_ID";
  static const DOCTOR_CLIENT_SECRET = "DOCTOR_CLIENT_SECRET";
  static Map<String, dynamic> debugBuildConfigurations = {
    SSO_URL: "http://172.1.45.101:8081",
    BASE_URL: "http://172.1.45.101:1036/api/v1",
    CLIENT_ID: "OneDoseLocalExternal",
    CLIENT_SECRET: "8e7fa603-9c5f-408f-b707-b8b3a43cd1ab",
    DOCTOR_BASE_URL: "http://172.1.45.101:1036",
    DOCTOR_CLIENT_ID: "OneDoseLocal",
    DOCTOR_CLIENT_SECRET: "514b7ffb-e8bc-40a7-a26b-f0b80fac8b99",
  };

  static Map<String, dynamic> qaBuildConfigurations = {
    SSO_URL: "http://172.1.45.101:8081",
    BASE_URL: "http://172.1.45.101:1036/api/v1",
    CLIENT_ID: "OneDoseLocalExternal",
    CLIENT_SECRET: "8e7fa603-9c5f-408f-b707-b8b3a43cd1ab",
    DOCTOR_SSO_URL: "http://172.1.45.101:8081",
    DOCTOR_BASE_URL: "http://172.1.45.101:1036",
    DOCTOR_CLIENT_ID: "CerebrumPlusLocal",
    DOCTOR_CLIENT_SECRET: "939a6f0d-4f6f-4a19-b23e-01999fe3dfe5"
  };

  static Map<String, dynamic> prodBuildConfigurations = {
    SSO_URL: "http://sso.onedosehealth.com:8000",
    BASE_URL: "http://apitest.onedosehealth.com/api/v1",
    CLIENT_ID: "OneDoseLocalExternal",
    CLIENT_SECRET: "8e7fa603-9c5f-408f-b707-b8b3a43cd1ab",
    DOCTOR_SSO_URL: "http://sso.onedosehealth.com:8000",
    DOCTOR_BASE_URL: "http://apitest.onedosehealth.com",
    DOCTOR_CLIENT_ID: "OneDoseLocal",
    DOCTOR_CLIENT_SECRET: "514b7ffb-e8bc-40a7-a26b-f0b80fac8b99"
  };
}
