import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onedosehealth/generated/l10n.dart';
import 'package:onedosehealth/helper/resources.dart';
import 'package:onedosehealth/pages/ble_device_connection/ble_reactive_singleton.dart';
import 'package:onedosehealth/pages/ble_device_connection/mi_scale/model/mi_scale_measurement.dart';
import 'package:onedosehealth/widgets/utils.dart';

import 'util/permissions.dart';

class MeasurementPane extends StatefulWidget {
  @override
  _MeasurementPaneState createState() => _MeasurementPaneState();
}

class _MeasurementPaneState extends State<MeasurementPane> {
  StreamSubscription _measurementSubscription;
  Map<String, MiScaleMeasurement> measurements = {}; // <Id, Measurement>

  @override
  void dispose() {
    super.dispose();
    stopTakingMeasurements(dispose: true);
  }

  Stream<MiScaleMeasurement> kek;
  Future<void> startTakingMeasurements() async {
    // Make sure we have location permission required for BLE scanning
    if (!await checkPermission()) return;
    // Start taking measurements
    setState(() {
      final ble = BLEHandler();
      kek = ble.takeMeasurements();
      _measurementSubscription = kek.listen(
        (measurement) {
          setState(() {
            measurements[measurement.id] = measurement;
          });
        },
        onError: (e) {
          print(e);
          stopTakingMeasurements();
        },
        onDone: stopTakingMeasurements,
      );
    });
  }

  void stopTakingMeasurements({dispose = false}) {
    _measurementSubscription?.cancel();
    _measurementSubscription = null;
    if (!dispose) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppBar(
          context: context,
          title: TitleAppBarWhite(title: LocaleProvider.current.mi_scale),
          leading: InkWell(
              child: SvgPicture.asset(R.image.back_icon),
              onTap: () => Navigator.of(context).pop()),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RaisedButton(
                  child: const Text('Start'),
                  onPressed: _measurementSubscription == null
                      ? startTakingMeasurements
                      : null,
                ),
                RaisedButton(
                  child: const Text('Stop'),
                  onPressed: _measurementSubscription != null
                      ? stopTakingMeasurements
                      : null,
                ),
              ],
            ),
            Opacity(
              opacity: _measurementSubscription != null ? 1 : 0,
              child: const Center(child: CircularProgressIndicator()),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children:
                      measurements.values.map(_buildMeasurementWidget).toList(),
                ),
              ),
            )
          ],
        ));
  }

  Widget _buildMeasurementWidget(MiScaleMeasurement measurement) {
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
                  Text(
                    measurement.weight.toStringAsFixed(2) +
                        measurement.unit.toString().split('.')[1],
                  ),
                  Text(
                    measurement.stage.toString().split('.')[1],
                  ),
                  Text(
                    measurement.dateTime.toIso8601String(),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                // Cancel the measurement if it is still active
                if (measurement.isActive)
                  BLEHandler().cancelMeasurement(measurement.deviceId);
                // Remove the measurement from the list
                setState(() {
                  measurements.remove(measurement.id);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
