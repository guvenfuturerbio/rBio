import 'package:adjust_sdk/adjust.dart';
import 'package:adjust_sdk/adjust_config.dart';
import 'package:adjust_sdk/adjust_event.dart';

class AdjustBaseEvent {
  late final String token;
  late final String unitPrice;

  AdjustBaseEvent(
    this.token,
  );

  @override
  String toString() => "Event_Name: ${token.toString()}";
}

class AdjustManager {
  void initializeAdjust() {
    final adjustConfig =
        AdjustConfig('1vvx05nbpkio', AdjustEnvironment.production);
    adjustConfig.setAppSecret(1, 492801584, 1304692510, 331550936, 2085469560);
    Adjust.start(adjustConfig);
    adjustConfig.logLevel = AdjustLogLevel.verbose;
  }

  // Firebase analytics log event fonksiyonu gibi event oluşturur
  void trackEvent(AdjustBaseEvent eventToken) {
    AdjustEvent adjustEvent = AdjustEvent(eventToken.token);
    Adjust.trackEvent(adjustEvent);
  }

  void setRevenue(String eventToken, int unitPrice) {
    AdjustEvent adjustEvent = AdjustEvent(eventToken);
    adjustEvent.setRevenue(unitPrice, 'TRY');
    Adjust.trackEvent(adjustEvent);
  }
}

class _EventConstants {
  static const successfulLogin = "vy6mgv";
}

class SuccessfulLoginEvent extends AdjustBaseEvent {
  SuccessfulLoginEvent() : super(_EventConstants.successfulLogin);
}
