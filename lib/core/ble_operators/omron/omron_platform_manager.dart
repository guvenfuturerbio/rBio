part of 'omron.dart';

class OmronPlatformManager {
  static OmronPlatformManager? _instance;
  OmronPlatformManager._();
  static OmronPlatformManager get instance {
    _instance ??= OmronPlatformManager._();
    return _instance!;
  }

  OmronCancelListening connectionStateChecker(OmronListener listener) {
    var subscription = OmronConstants.instance.channel.connectionStatusChannel
        .receiveBroadcastStream()
        .listen(listener, cancelOnError: true, onError: (e) {
      throw Exception(e);
    });

    return () {
      subscription.cancel();
    };
  }

  Future<void> startTransferProcess(
      Map<dynamic, dynamic> omronDeviceRequestMap) async {
    await OmronConstants.instance.channel.methodChannel
        .invokeMethod(OmronConstants.instance.channel.startTransferProcess,
            omronDeviceRequestMap)
        .then((value) => null)
        .onError((error, stackTrace) async {
      throw Exception(error);
    });
  }

  Future setKey(String key) async {
    await OmronConstants.instance.channel.methodChannel
        .invokeMethod(OmronConstants.instance.channel.setKey, {'key': key});
  }

  OmronCancelListening transferData(OmronListener listener) {
    var subscription = OmronConstants.instance.channel.transferDataChannel
        .receiveBroadcastStream()
        .listen(listener, cancelOnError: true, onError: (e) {
      throw Exception(e);
    });

    return () {
      subscription.cancel();
    };
  }

  Future<void> connectDevice(Map<String, dynamic> map) async {
    return await OmronConstants.instance.channel.methodChannel
        .invokeMethod(OmronConstants.instance.channel.connect, map);
  }

  Future<void> continueToConnection(Map<dynamic, dynamic> map) async =>
      await OmronConstants.instance.channel.methodChannel.invokeMethod(
          OmronConstants.instance.channel.continueToConnection, map);

  OmronCancelListening scanSpesificPeripheral(
      OmronListener listener, StartOmronManagerModel model) {
    var subscription = OmronConstants
        .instance.channel.scanSpecificOmronPeripheral
        .receiveBroadcastStream(model.toJson())
        .listen(listener, cancelOnError: true, onError: (e) {
      throw Exception(e);
    });

    return () {
      subscription.cancel();
    };
  }
}
