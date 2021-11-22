part of '../repository/mediminder_repository.dart';

abstract class MediminderApiService {
  final IDioHelper helper;
  MediminderApiService(this.helper);

  Future<StripDetailModel> getUserStrips(
    int entegrationId,
    String deviceUUID,
  );

  Future<bool> setUserStrips(
    StripDetailModel stripDetailModel,
  );
}
