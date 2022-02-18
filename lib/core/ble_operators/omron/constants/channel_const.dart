part of '../omron.dart';

class _$ChannelConst {
  final connect = 'ConnectDevice';
  final startTransferProcess = 'StartTransferProcess';
  final continueToConnection = 'ContinueToConnection';
  final setKey = 'setKey';
  final connectionStatusChannel =
      const EventChannel('com.seniorturkmen/omron/connectionstatus');
  final transferDataChannel =
      const EventChannel('com.seniorturkmen/omron/transferData');
  final methodChannel = const MethodChannel('com.seniorturkmen/omron');
  final scanSpecificOmronPeripheral =
      const EventChannel('com.seniorturkmen/omron/searchOmronPeripherals');
  final startOmronManager = 'startManager';
}
