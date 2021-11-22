part of '../repository/mediminder_repository.dart';

class MediminderApiServiceImpl extends MediminderApiService {
  MediminderApiServiceImpl(IDioHelper helper) : super(helper);

  String get getToken => getIt<ISharedPreferencesManager>()
      .get(SharedPreferencesKeys.CT_AUTH_TOKEN);
  Options get authOptions => Options(
      headers: {'Authorization': getToken, 'Lang': Intl.getCurrentLocale()});

  @override
  Future<StripDetailModel> getUserStrips(
    int entegrationId,
    String deviceUUID,
  ) async {
    final response = await helper.getGuven(
      R.endpoints.mediminderGetUserStrip(entegrationId, deviceUUID),
      options: authOptions,
    );
    if (response.isSuccessful) {
      return StripDetailModel.fromJson(response.datum);
    } else {
      throw Exception('/getUserStrips/ : ${response.isSuccessful}');
    }
  }

  @override
  Future<bool> setUserStrips(StripDetailModel stripDetailModel) async {
    if (stripDetailModel.deviceUUID == "") {
      stripDetailModel.deviceUUID = "no-device";
    }
    final response = await helper.postGuven(
      R.endpoints.mediminderUpdateUserStrip(),
      stripDetailModel.toJson(),
      options: authOptions,
    );
    return response.isSuccessful;
  }
}
