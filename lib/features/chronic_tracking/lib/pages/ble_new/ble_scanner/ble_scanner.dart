import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/core.dart';
import '../../../../../../generated/l10n.dart';
import '../../../models/ble_models/DeviceTypes.dart';
import '../../../notifiers/ble_operators/ble_connector.dart';
import '../../../notifiers/ble_operators/ble_reactor.dart';
import '../../../notifiers/ble_operators/ble_scanner.dart';
import '../../../widgets/custom_app_bar/custom_app_bar.dart';
import 'ble_scanner_vm.dart';

class BleScannerPage extends StatefulWidget {
  final DeviceType deviceType;
  BleScannerPage({@required this.deviceType});

  @override
  _BleScannerPageState createState() => _BleScannerPageState();
}

class _BleScannerPageState extends State<BleScannerPage> {
  @override
  void initState() {
    super.initState();
  }

  bool isFocusedDevice(DiscoveredDevice device) {
    switch (widget.deviceType) {
      case DeviceType.ACCU_CHEK:
        return device.manufacturerData[0] == 112;
        break;
      case DeviceType.CONTOUR_PLUS_ONE:
        return device.manufacturerData[0] == 103;
        break;
      case DeviceType.OMRON_BLOOD_PRESSURE_ARM:
        return false;
        break;
      case DeviceType.OMRON_BLOOD_PRESSURE_WRIST:
        return false;
        break;
      case DeviceType.OMRON_SCALE:
        return false;
        break;
      case DeviceType.MI_SCALE:
        return device.name == 'MIBFS' &&
            device.serviceData.length == 1 &&
            device.serviceData.values.first.length == 13;
        break;
      default:
        throw Exception('Undefined Device Type');
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return ChangeNotifierProvider(
      create: (context) => BleScannerVm(context: context),
      builder: (context, child) {
        return Consumer4<BleScannerOps, BleConnectorOps, BleReactorOps,
                BleScannerVm>(
            builder: (_, _bleScannerOps, _bleConnectorOps, _bleReactorOps,
                _bleScannerVm, __) {
          return Scaffold(
              appBar: CustomAppBar(
                  preferredSize: Size.fromHeight(context.HEIGHT * .18),
                  title: TitleAppBarWhite(
                      title: LocaleProvider.current.connect_glucometer),
                  leading: InkWell(
                      child: SvgPicture.asset(R.image.back_icon),
                      onTap: () => Navigator.of(context).pop())),
              extendBodyBehindAppBar: true,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: context.HEIGHT * .17,
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: getPairOrder()),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: _bleScannerOps.discoveredDevices.length,
                      itemBuilder: (context, index) {
                        return (isFocusedDevice(
                                    _bleScannerOps.discoveredDevices[index])) &&
                                !_bleScannerOps.pairedDevices.contains(
                                    _bleScannerOps.discoveredDevices[index].id)
                            ? GestureDetector(
                                onTap: () => _connectDevice(
                                    _bleScannerVm,
                                    _bleConnectorOps,
                                    _bleScannerOps,
                                    _bleScannerOps.discoveredDevices[index]),
                                child: Container(
                                    padding:
                                        EdgeInsets.only(left: 16, right: 16),
                                    child: Card(
                                      color: _bleConnectorOps
                                                  ?.getStatus(_bleScannerOps
                                                      .discoveredDevices[index]
                                                      .id)
                                                  ?.connectionState ==
                                              DeviceConnectionState.connected
                                          ? R.color.regularBlue
                                          : _bleConnectorOps
                                                      ?.getStatus(_bleScannerOps
                                                          .discoveredDevices[
                                                              index]
                                                          .id)
                                                      ?.connectionState ==
                                                  DeviceConnectionState
                                                      .connecting
                                              ? R.color.high
                                              : Colors.white,
                                      elevation: 4,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: Container(
                                        child: Center(
                                            child: Column(children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.all(16),
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  height: 100,
                                                  width: 120,
                                                  child: UtilityManager()
                                                      .getDeviceImageFromType(
                                                          widget.deviceType),
                                                ),
                                                Container(
                                                  width: 120,
                                                  padding:
                                                      EdgeInsets.only(left: 16),
                                                  child: Text(
                                                      _bleScannerOps
                                                              .discoveredDevices[
                                                                  index]
                                                              .name ??
                                                          LocaleProvider.of(
                                                                  context)
                                                              .unknown,
                                                      style: TextStyle(
                                                          fontSize: 15)),
                                                )
                                              ],
                                            ),
                                          )
                                        ])),
                                      ),
                                    )),
                              )
                            : SizedBox();
                      },
                    ),
                  ],
                ),
              ));
        });
      },
    );
  }

  _connectDevice(BleScannerVm _bleScannerVm, BleConnectorOps _bleConnectorOps,
      BleScannerOps _bleScannerOps, device) async {
    switch (widget.deviceType) {
      case DeviceType.ACCU_CHEK:
        _bleScannerVm.connectIsActive &&
                (_bleConnectorOps.deviceConnectionState !=
                        DeviceConnectionState.connecting &&
                    _bleConnectorOps.deviceConnectionState !=
                        DeviceConnectionState.connected)
            ? _bleConnectorOps.connect(
                // ignore: unnecessary_statements
                device)
            : null;
        _bleScannerVm.connectClicked();
        break;
      case DeviceType.CONTOUR_PLUS_ONE:
        _bleScannerVm.connectIsActive &&
                (_bleConnectorOps.deviceConnectionState !=
                        DeviceConnectionState.connecting &&
                    _bleConnectorOps.deviceConnectionState !=
                        DeviceConnectionState.connected)
            ? _bleConnectorOps.connect(
                // ignore: unnecessary_statements
                device)
            : null;
        _bleScannerVm.connectClicked();
        break;
      case DeviceType.OMRON_BLOOD_PRESSURE_ARM:
        // TODO: Handle this case.
        break;
      case DeviceType.OMRON_BLOOD_PRESSURE_WRIST:
        // TODO: Handle this case.
        break;
      case DeviceType.OMRON_SCALE:
        // TODO: Handle this case.
        break;
      case DeviceType.MI_SCALE:
        _bleScannerVm.connectIsActive &&
                (_bleConnectorOps.deviceConnectionState !=
                        DeviceConnectionState.connecting &&
                    _bleConnectorOps.deviceConnectionState !=
                        DeviceConnectionState.connected)
            ? _bleConnectorOps.connect(
                // ignore: unnecessary_statements
                device)
            : null;
        _bleScannerVm.connectClicked();
        break;
      default:
        null;
    }
  }

  Widget pairOrder(String sequence, String text) {
    return Padding(
        padding: EdgeInsets.all(16),
        child: RichText(
          textScaleFactor: context.TEXTSCALE,
          text: TextSpan(
            text: sequence,
            style: TextStyle(color: R.color.defaultBlue),
            children: <TextSpan>[
              TextSpan(text: text, style: TextStyle(color: Colors.black)),
            ],
          ),
        ));
  }

  getPairOrder() {
    switch (widget.deviceType) {
      case DeviceType.ACCU_CHEK:
        return <Widget>[
          pairOrder('1 ', LocaleProvider.current.device_connection_step_1),
          pairOrder(
            '2 ',
            LocaleProvider.current.device_connection_step_2_Roche,
          ),
          pairOrder(
            '3 ',
            LocaleProvider.current.device_connection_step_3_Roche,
          ),
          if (Platform.isIOS)
            pairOrder(
                '4 ', LocaleProvider.current.device_connection_step_4_Roche)
        ];

      case DeviceType.CONTOUR_PLUS_ONE:
        return <Widget>[
          pairOrder('1 ', LocaleProvider.current.device_connection_step_1),
          pairOrder(
            '2 ',
            LocaleProvider.current.device_connection_step_2_Contour,
          ),
          pairOrder(
              '3 ', LocaleProvider.current.device_connection_step_3_Contour),
        ];

      case DeviceType.OMRON_BLOOD_PRESSURE_ARM:
        return <Widget>[];
      case DeviceType.OMRON_BLOOD_PRESSURE_WRIST:
        return <Widget>[];
      case DeviceType.OMRON_SCALE:
        return <Widget>[];
      case DeviceType.MI_SCALE:
        return <Widget>[
          pairOrder('1 ',
              LocaleProvider.current.device_scale_connection_step_1_mi_scale),
          pairOrder(
            '2 ',
            LocaleProvider.current.device_scale_connection_step_2_mi_scale,
          ),
          pairOrder('3 ',
              LocaleProvider.current.device_scale_connection_step_3_mi_scale),
        ];
    }
  }

  getHeader() {
    switch (widget.deviceType) {
      case DeviceType.ACCU_CHEK:
        return '${LocaleProvider.current.connect_glucometer}';

      case DeviceType.CONTOUR_PLUS_ONE:
        return '${LocaleProvider.current.connect_glucometer}';

      case DeviceType.OMRON_BLOOD_PRESSURE_ARM:
        return '';
      case DeviceType.OMRON_BLOOD_PRESSURE_WRIST:
        return '';
      case DeviceType.OMRON_SCALE:
        return '';
      case DeviceType.MI_SCALE:
        return '${LocaleProvider.current.connect_scale}';
        ;
    }
  }
}
