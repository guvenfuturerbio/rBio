part of '../../abstract/app_config.dart';

class GuvenSuggestionRateEndpoints extends SuggestionRateEndpoints {
  @override
  String addSuggestionPath = '/SuggestionRate/Add-Suggestion'.xBaseUrl;

  @override
  String getAvailabilityRatePath =
      '/SuggestionRate/Get-Availability-Rate-Pusula'.xBaseUrl;

  @override
  String rateOnlineCallPath =
      '/SuggestionRate/Add-Availability-Rate-pusula'.xBaseUrl;
}
