import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:onedosehealth/helper/events/base_event.dart';

class AnalyticsManager {
  static final AnalyticsManager _instance = AnalyticsManager._internal();

  factory AnalyticsManager() {
    return _instance;
  }

  AnalyticsManager._internal() {
    print("test");
  }

  void sendEvent(BaseEvent event) {
    print("Analytics_LOGGER: " + event.toString());
    try {
      FirebaseAnalytics().logEvent(
        name: event.name,
        parameters: event.parameters,
      );
    } catch (e) {
      print("Analytics_LOGGER ERROR: " + e.toString());
    }
  }

  void setScreenName(String _screenName) {
    FirebaseAnalytics().setCurrentScreen(screenName: _screenName);
  }
}
