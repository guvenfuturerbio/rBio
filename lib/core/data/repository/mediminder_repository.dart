import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../../../features/mediminder/models/strip_detail_model.dart';
import '../../core.dart';

part '../service/mediminder_service.dart';
part '../service/mediminder_service_impl.dart';

class MediminderRepository {
  final MediminderApiService service;

  MediminderRepository(this.service);

  Future<StripDetailModel> getUserStrips(
    int entegrationId,
    String deviceUUID,
  ) =>
      service.getUserStrips(
        entegrationId,
        deviceUUID,
      );

  Future<bool> setUserStrips(
    StripDetailModel stripDetailModel,
  ) =>
      service.setUserStrips(stripDetailModel);
}
