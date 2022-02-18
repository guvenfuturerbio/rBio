part of 'omron.dart';

class OmronConnector {
  static OmronConnector? _instance;
  OmronConnector._() {
    OmronPlatformManager.instance.setKey(R.strings.omronAuthKey);
  }
  static OmronConnector get instance {
    _instance ??= OmronConnector._();
    return _instance!;
  }

  Future<void> startTransferProcess(
          OmronDeviceConnectionRequestModel
              omronDeviceConnectionRequestModel) async =>
      await OmronPlatformManager.instance
          .startTransferProcess(omronDeviceConnectionRequestModel.toJson());

  OmronCancelListening transferData(OmronListener listener) =>
      OmronPlatformManager.instance.transferData(listener);

  Future<void> connectDevice(
          OmronDeviceConnectionRequestModel
              omronDeviceConnectionRequestModel) async =>
      await OmronPlatformManager.instance
          .connectDevice(omronDeviceConnectionRequestModel.toJson());

  Future<void> continueToConnection(
          OmronDeviceConnectionRequestModel
              omronDeviceConnectionRequestModel) async =>
      await OmronPlatformManager.instance
          .continueToConnection(omronDeviceConnectionRequestModel.toJson());

  OmronCancelListening scanSpesificPeripheral(
          StartOmronManagerModel model, OmronListener listener) =>
      OmronPlatformManager.instance.scanSpesificPeripheral(listener, model);

  OmronCancelListening connectionStateChecker(OmronListener listener) =>
      OmronPlatformManager.instance.connectionStateChecker(listener);
}
