import 'package:firebase_analytics/firebase_analytics.dart';

import '../events/base_event.dart';

class AnalyticsManager {
  static final AnalyticsManager _instance = AnalyticsManager._internal();

  factory AnalyticsManager() {
    return _instance;
  }

  AnalyticsManager._internal();

  void sendEvent(BaseEvent event) {
    try {
      FirebaseAnalytics().logEvent(
        name: event.name,
        parameters: event.parameters,
      );
    } catch (e) {
      //
    }
  }

  void setScreenName(String _screenName) {
    FirebaseAnalytics().setCurrentScreen(screenName: _screenName);
  }
}
