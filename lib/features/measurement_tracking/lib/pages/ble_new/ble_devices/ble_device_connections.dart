import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../extension/size_extension.dart';
import '../../../generated/l10n.dart';
import '../../../helper/resources.dart';
import '../../../models/ble_models/DeviceTypes.dart';
import '../../../models/ble_models/paired_device.dart';
import '../../../widgets/custom_app_bar/custom_app_bar.dart';
import '../../../widgets/utils.dart';
import '../ble_status_screen.dart';
import '../ble_scanner/ble_scanner.dart';
import 'ble_device_connections_vm.dart';

class DeviceConnections extends StatefulWidget {
  @override
  _DeviceConnections createState() => _DeviceConnections();
}

class _DeviceConnections extends State<DeviceConnections> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return new ChangeNotifierProvider(
      create: (context) => DeviceConnectionsVm(context: context),
      child: Consumer<DeviceConnectionsVm>(
        builder: (context, value, child) {
          return Scaffold(
            appBar: CustomAppBar(
                preferredSize: Size.fromHeight(context.HEIGHT * .18),
                title: TitleAppBarWhite(
                    title: LocaleProvider.current.supported_devices),
                leading: InkWell(
                    child: SvgPicture.asset(R.image.back_icon),
                    onTap: () => Navigator.of(context).pop())),
            extendBodyBehindAppBar: true,
            body: SingleChildScrollView(
              child: Consumer<BleStatus>(
                builder: (_, status, __) {
                  if (status == BleStatus.ready) {
                    return Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: value.deviceConnectionTypes.length,
                          itemBuilder: (context, index) {
                            return deviceTypeContainer(
                                context, value.deviceConnectionTypes[index]);
                          },
                        ),
                      ],
                    );
                  } else {
                    return BleStatusScreen(status: status);
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget deviceTypeContainer(
      BuildContext context, DeviceConnectionType device) {
    return new GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => BleScannerPage(
                  deviceType: device.deviceType,
                )));
      },
      child: Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: SizedBox(
              height: (context.HEIGHT * .1) * context.TEXTSCALE,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: <Widget>[
                    Expanded(child: Image.asset(device.imagePath)),
                    Expanded(
                      flex: 3,
                      child: Text(device.name ?? LocaleProvider.current.unknown,
                          style: TextStyle(fontSize: 15)),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Widget pairedDeviceContainer(BuildContext context, PairedDevice device) {
    return new GestureDetector(
      onTap: () {},
      child: Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Card(
            color: R.color.main_color,
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: Container(
              child: Center(
                  child: Column(children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 100,
                        width: 120,
                        child: Image.asset(R.image.accu_check_png),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                                device?.manufacturerName ??
                                    LocaleProvider.current.unknown,
                                style: TextStyle(fontSize: 15)),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                                "SN :" + device?.serialNumber ??
                                    LocaleProvider.current.unknown,
                                style: TextStyle(fontSize: 15)),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ])),
            ),
          )),
    );
  }
}
