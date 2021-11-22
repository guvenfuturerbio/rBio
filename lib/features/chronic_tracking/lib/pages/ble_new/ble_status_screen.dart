
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:onedosehealth/generated/l10n.dart';
import 'package:open_settings/open_settings.dart';
import 'package:system_shortcuts/system_shortcuts.dart';

class BleStatusScreen extends StatelessWidget {
  const BleStatusScreen({@required this.status, Key key})
      : assert(status != null),
        super(key: key);

  final BleStatus status;

  String determineText(BuildContext context, BleStatus status) {
    switch (status) {
      case BleStatus.unsupported:
        return LocaleProvider.current.ble_status_unsupported;
      case BleStatus.unauthorized:
        return LocaleProvider.current.ble_status_unauthorized;
      case BleStatus.poweredOff:
        return LocaleProvider.current.ble_status_powered_off;
      case BleStatus.locationServicesDisabled:
        return LocaleProvider.current.ble_status_location_services_disabled;
      case BleStatus.ready:
        return LocaleProvider.current.ble_status_ready;
      default:
        return "${LocaleProvider.current.ble_status_waiting} $status";
    }
  }

  @override
  Widget build(BuildContext context) => Center(
        child: GestureDetector(
          onTap: () async {
            await SystemShortcuts.bluetooth(); // just android
            if (status == BleStatus.unauthorized) {
              print("AppSettings.openBluetoothSettings();");
              AppSettings.openBluetoothSettings();
            } else {
              print("SystemSettings.bluetooth();");
              OpenSettings
                  .openBluetoothSetting(); // TODO Open System settings not App settings
            }
          },
          child: Container(
            padding: EdgeInsets.all(16),
            child: Text(
              determineText(context, status),
              style: TextStyle(fontSize: 14),
            ),
          ),
        ),
      );
}
