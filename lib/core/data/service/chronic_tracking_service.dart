import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../../../features/measurement_tracking/lib/pages/signup&login/token_provider.dart';
import '../../core.dart';

part 'chronic_tracking_service_impl.dart';

abstract class ChronicTrackingApiService {
  final IDioHelper helper;
  ChronicTrackingApiService(this.helper);
}
