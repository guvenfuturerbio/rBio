part of '../core.dart';

const connectionStatusChannel =
    EventChannel('com.guvenfuture.onedosehealth/omron/connectionstatus');
const transferDataChannel =
    EventChannel('com.guvenfuture.onedosehealth.omron/transferData');
const methodeChannel =
    MethodChannel("com.guvenfuture.onedosehealth.customimplement.omron");
