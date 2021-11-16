part of 'chronic_tracking_service.dart';

class ChronicTrackingApiServiceImpl extends ChronicTrackingApiService {
  ChronicTrackingApiServiceImpl(IDioHelper helper) : super(helper);

  String get getChronicTrackingToken => TokenProvider().authToken;
  Options get authOptions => Options(headers: {
        'Authorization': getChronicTrackingToken,
        'Lang': Intl.getCurrentLocale()
      });
}
