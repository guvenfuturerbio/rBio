import 'dart:async';

import 'package:flutter/material.dart';
import 'package:onedosehealth/pages/ble_device_connection/mi_scale/util/permission.dart';

import 'mi_scale.dart';
import 'model/device/mi_scale_device.dart';

class ScanningPane extends StatefulWidget {
  @override
  _ScanningPaneState createState() => _ScanningPaneState();
}

class _ScanningPaneState extends State<ScanningPane> {
  StreamSubscription _scanSubscription;
  Map<String, MiScaleDevice> devices = {}; // <Id, MiScaleDevice>
  final _scale = MiScale.instance;

  @override
  void dispose() {
    stopDiscovery(dispose: true);
    super.dispose();
  }

  Future<void> startDiscovery() async {
    try {
      // Make sure we have location permission required for BLE scanning
      print('upper');
      if (!await checkPermission()) return;
      print('down');
      // Clear device list
      devices = {};
      // Start scanning
      setState(() {
        print('hellooo');
        _scanSubscription = _scale.discoverDevices().listen(
          (device) {
            print(device);
            setState(() {
              devices[device.id] = device;
            });
          },
          onError: (e) {
            print(e);
            stopDiscovery();
          },
          onDone: stopDiscovery,
        );
      });
    } catch (error, stk) {
      print(error);
      debugPrintStack(stackTrace: stk);
    }
  }

  void stopDiscovery({dispose = false}) {
    _scanSubscription?.cancel();
    _scanSubscription = null;
    if (!dispose) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Start Scanning'),
              onPressed: _scanSubscription == null ? startDiscovery : null,
            ),
            ElevatedButton(
              child: const Text('Stop Scanning'),
              onPressed: _scanSubscription != null ? stopDiscovery : null,
            ),
          ],
        ),
        Opacity(
          opacity: _scanSubscription != null ? 1 : 0,
          child: const Center(child: CircularProgressIndicator()),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: devices.values.map(_buildDeviceWidget).toList(),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildDeviceWidget(MiScaleDevice device) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Name: ${device.name}'),
                  Text('Device ID: ${device.id}'),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('RSSI: ${device.rssi}dBm'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
