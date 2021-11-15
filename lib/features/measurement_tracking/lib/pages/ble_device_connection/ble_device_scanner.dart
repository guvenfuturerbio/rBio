import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onedosehealth/generated/l10n.dart';
import 'package:onedosehealth/helper/loading_dialog.dart';
import 'package:onedosehealth/helper/resources.dart';
import 'package:onedosehealth/models/ble_models/DeviceTypes.dart';
import 'package:onedosehealth/pages/ble_device_connection/ble_reactive_singleton.dart';
import 'package:onedosehealth/pages/ble_device_connection/mi_scale/measurement_pane.dart';
import 'package:onedosehealth/pages/home/home_page_view_model.dart';
import 'package:onedosehealth/widgets/utils.dart';
import 'package:onedosehealth/widgets/utils/loading_indicator_handler.dart';
import 'package:provider/provider.dart';

class BleDeviceScanner extends StatefulWidget {
  BleDeviceScanner({this.deviceConnectionType});
  DeviceConnectionType deviceConnectionType;
  @override
  _BleDeviceScanner createState() => _BleDeviceScanner();
}

class _BleDeviceScanner extends State<BleDeviceScanner> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  LoadingDialog loadingDialog;
  int deviceFromSharedPref = -1;
  String serialNumberFromSharedPref = "";

  @override
  Widget build(BuildContext context) {
    getSavedDevices(context);
    return new ChangeNotifierProvider(
      create: (context) => HomePageViewModel(),
      child: Consumer<HomePageViewModel>(
        builder: (context, value, child) {
          return Scaffold(
            appBar: MainAppBar(
                context: context,
                title: TitleAppBarWhite(
                    title: LocaleProvider.current.connect_glucometer),
                leading: InkWell(
                    child: SvgPicture.asset(R.image.back_icon),
                    onTap: () => Navigator.of(context).pop())),
            body: Stack(
              alignment: AlignmentDirectional.topCenter,
              clipBehavior: Clip.hardEdge,
              children: <Widget>[
                SafeArea(
                  child: Container(child: getMainBody(context)),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  getSavedDevices(BuildContext context) async {
    int lastPairedDevice = await BLEHandler().getSavedDevice(context);
    String lastSerialNumber = await BLEHandler().getSavedSerialNumber(context);
    if (lastPairedDevice == null || lastPairedDevice == -1) {
      // No device is paired yet!
      setState(() {});
    } else {
      setState(() {
        deviceFromSharedPref = lastPairedDevice;
        serialNumberFromSharedPref = lastSerialNumber;
      });
    }
  }

  Widget getMainBody(BuildContext context) {
    return new ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: <Widget>[
        GestureDetector(
          onTap: () {},
          child: Container(
            child: Center(
                child: Column(children: <Widget>[
              GestureDetector(
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 16),
                  child: Row(
                    children: <Widget>[
                      UtilityManager().getDeviceImage(deviceFromSharedPref) ==
                              null
                          ? Container()
                          : GestureDetector(
                              onTap: () async {
                                print("SAVED DEVICE connected");
                                print(widget
                                    .deviceConnectionType.deviceType.name);
                              },
                              child: Container(
                                  padding: EdgeInsets.only(left: 16, right: 16),
                                  child: Card(
                                    color: R.color.light_blue,
                                    elevation: 8,
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
                                                    .getDeviceImage(
                                                        deviceFromSharedPref),
                                              ),
                                              Container(
                                                padding:
                                                    EdgeInsets.only(left: 16),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                        UtilityManager()
                                                                .getDeviceName(
                                                                    deviceFromSharedPref) ??
                                                            LocaleProvider.of(
                                                                    context)
                                                                .unknown,
                                                        style: TextStyle(
                                                            fontSize: 15)),
                                                    Text(
                                                        serialNumberFromSharedPref ??
                                                            LocaleProvider.of(
                                                                    context)
                                                                .unknown,
                                                        style: TextStyle(
                                                            fontSize: 15))
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ])),
                                    ),
                                  )),
                            )
                    ],
                  ),
                ),
              )
            ])),
          ),
        ),
        Divider(
          color: R.color.defaultBlue,
          height: 1,
          thickness: 1,
          indent: 20,
          endIndent: 20,
        ),
        Consumer<BLEHandler>(builder: (context, bleHandler, _) {
          return ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: bleHandler.devices.length,
            itemBuilder: (context, index) {
              return discoveredDeviceContainer(
                  context, bleHandler, bleHandler.devices[index]);
            },
          );
        }),
        deviceFromSharedPref == -1
            ? Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(16),
                          child: RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(
                              text: '1 ',
                              style: TextStyle(
                                  fontSize: 20, color: R.color.defaultBlue),
                              children: <TextSpan>[
                                TextSpan(
                                    text: LocaleProvider
                                        .current.device_connection_step_1,
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black)),
                              ],
                            ),
                          )),
                      Padding(
                          padding: EdgeInsets.all(16),
                          child: RichText(
                            text: TextSpan(
                              text: '2 ',
                              style: TextStyle(
                                  fontSize: 20, color: R.color.defaultBlue),
                              children: <TextSpan>[
                                TextSpan(
                                    text: LocaleProvider
                                        .current.device_connection_step_2_Roche,
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black)),
                              ],
                            ),
                          )),
                      Padding(
                          padding: EdgeInsets.all(16),
                          child: RichText(
                            text: TextSpan(
                              text: '3 ',
                              style: TextStyle(
                                  fontSize: 20, color: R.color.defaultBlue),
                              children: <TextSpan>[
                                TextSpan(
                                    text: LocaleProvider
                                        .current.device_connection_step_3_Roche,
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black)),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              )
            : Container()
      ],
    );
  }

  Widget getKek() {
    return Consumer<BLEHandler>(builder: (context, bleHandler, _) {
      return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: bleHandler.glucoseReadings.length,
        itemBuilder: (context, index) {
          DateTime measureDT = new DateTime.fromMillisecondsSinceEpoch(
              bleHandler.glucoseReadings[index].time);
          return new Visibility(
            visible: (bleHandler.glucoseReadings[index].tag == null ||
                bleHandler.glucoseReadings[index].tag == 0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  bleHandler.glucoseReadings[index].tag = 1;
                });
              },
              child: Container(
                  height: 50,
                  padding:
                      EdgeInsets.only(left: 8, right: 8, bottom: 16, top: 16),
                  color: Colors.deepOrangeAccent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "${measureDT.hour > 9 ? measureDT.hour : "0" + measureDT.hour.toString()}:${measureDT.minute > 9 ? measureDT.minute : "0" + measureDT.minute.toString()}",
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                              "  ${measureDT.day}.${measureDT.month}.${measureDT.year}"),
                          Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                                "Bg: ${bleHandler.glucoseReadings[index].level} mg/dL"),
                          ),
                          Text(" T: ${bleHandler.glucoseReadings[index].tag}"),
                          Text(
                              " D: ${bleHandler.glucoseReadings[index].device}")
                        ],
                      ),
                    ],
                  )),
            ),
          );
        },
      );
    });
  }

  Widget discoveredDeviceContainer(
      BuildContext context, BLEHandler bleHandler, DiscoveredDevice device) {
    return new GestureDetector(
      onTap: () async {
        print(widget.deviceConnectionType.deviceType.name);
        switch (widget.deviceConnectionType.deviceType) {
          case DeviceType.ACCU_CHEK:
            LoadingIndicatorHandler().showLoading(context);
            // TODO: Handle this case.
            break;
          case DeviceType.CONTOUR_PLUS_ONE:
            LoadingIndicatorHandler().showLoading(context);
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
            break;
          default:
            break;
        }
        String resultMessage = await bleHandler.connect(
            context, device, false, widget.deviceConnectionType.deviceType);
        LoadingIndicatorHandler().hideLoading();
        print(resultMessage);
        if (widget.deviceConnectionType.deviceType == DeviceType.MI_SCALE) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MeasurementPane()),
          );
        } else {
          if (resultMessage != null && resultMessage != "") {
            UtilityManager()
                .showAlertDialog(context, resultMessage, new LoadingDialog());
          }
        }
      },
      child: Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
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
                        child: UtilityManager().getDeviceImage(
                            device.manufacturerData.length < 1
                                ? 112
                                : device.manufacturerData[0]),
                      ),
                      Container(
                        width: 120,
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                            device.name ?? LocaleProvider.current.unknown,
                            style: TextStyle(fontSize: 15)),
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
