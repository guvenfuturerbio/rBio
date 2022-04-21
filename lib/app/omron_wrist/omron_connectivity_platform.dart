import 'dart:developer';

import 'omron_wrist_core/core.dart';

CancelListening connectionStateChecker(Listener listener) {
  var subscription = connectionStatusChannel
      .receiveBroadcastStream()
      .listen(listener, cancelOnError: true, onError: (e) {
    throw Exception(e);
  });

  return () {
    subscription.cancel();
  };
}

startTransferProcess(Map<dynamic, dynamic> map, String hashId) async {
  var deviceInfo = {
    'device': map['name'],
    'uuid': map['uuid'],
    'hashId': hashId,
    'userType': map['userType']
  };

  await methodeChannel
      .invokeMethod(ChannelConst.startTransferProcess, deviceInfo)
      .then((value) => null)
      .onError((error, stackTrace) async {
    throw Exception(error);
  });
}

Future setKey(String key) async {
  log(key);
  await methodeChannel.invokeMethod(ChannelConst.setKey, {'key': key});
}

CancelListening transferData(Listener listener) {
  var subscription = transferDataChannel
      .receiveBroadcastStream()
      .listen(listener, cancelOnError: true, onError: (e) {
    throw Exception(e);
  });

  return () {
    subscription.cancel();
  };
}

Future connectDevice(Map<String, dynamic> map) async {
  return await methodeChannel.invokeMethod(ChannelConst.connect, map);
}

Future continueToConnection(Map<dynamic, dynamic> map) async {
  return await methodeChannel.invokeMethod(
      ChannelConst.continueToConnection, map);
}
