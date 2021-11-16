import 'package:flutter/material.dart';

import '../service/chronic_tracking_service.dart';
import '../service/local_cache_service.dart';

class ChronicTrackingRepository {
  final ChronicTrackingApiService apiService;
  final LocalCacheService localCacheService;

  ChronicTrackingRepository({
    @required this.apiService,
    @required this.localCacheService,
  });
}
