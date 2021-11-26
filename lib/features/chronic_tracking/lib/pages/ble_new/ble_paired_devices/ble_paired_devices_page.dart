import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/core.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../model/ble_models/paired_device.dart';
import '../../../helper/resources.dart';
import 'ble_paired_devices_vm.dart';

class PairedDevicesPage extends StatefulWidget {
  @override
  _PairedDevicesPage createState() => _PairedDevicesPage();
}

class _PairedDevicesPage extends State<PairedDevicesPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return ChangeNotifierProvider(
      create: (context) => PairedDevicesVm(context: context),
      child: Consumer<PairedDevicesVm>(
        builder: (context, value, child) {
          return Scaffold(
            floatingActionButton: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: <Color>[R.color.btnLightBlue, R.color.btnDarkBlue],
                ),
              ),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(Routes.DEVICE_CONNECTIONS_PAGE);
                },
                backgroundColor: Colors.transparent,
                child: Container(
                  child: SvgPicture.asset(R.image.add_icon),
                  padding: EdgeInsets.all(8),
                ),
              ),
            ),
            extendBodyBehindAppBar: true,
            appBar: MainAppBar(
                context: context,
                title: TitleAppBarWhite(
                    title: LocaleProvider.current.paired_devices),
                leading: InkWell(
                    child: SvgPicture.asset(R.image.back_icon),
                    onTap: () => Navigator.of(context).pop())),
            body: value?.pairedDevices != null && value.pairedDevices.isNotEmpty
                ? SingleChildScrollView(
                    child: Stack(
                      alignment: AlignmentDirectional.topCenter,
                      clipBehavior: Clip.hardEdge,
                      children: <Widget>[
                        Column(children: [
                          SizedBox(
                            height: context.HEIGHT * .18,
                          ),
                          ...value.pairedDevices
                              .map((device) => deviceItem(
                                  device,
                                  (device) =>
                                      value.deletePairedDevice(device.deviceId),
                                  (device) => value.infoFetcher(device)))
                              .toList(),
                        ])
                      ],
                    ),
                  )
                : Center(
                    child: Text(LocaleProvider.current.add_new_device),
                  ),
          );
        },
      ),
    );
  }

  Widget deviceItem(
    PairedDevice device,
    Function(PairedDevice) deleteAction,
    Widget Function(PairedDevice) infoFetcher,
  ) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      secondaryActions: [
        IconSlideAction(
          caption: LocaleProvider.current.delete,
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            Get.defaultDialog(
                title: LocaleProvider.current.warning,
                content: Text(
                    '${LocaleProvider.current.ble_delete_paired_device_approv}'),
                actions: [
                  TextButton(
                      onPressed: () => Get.back(),
                      child: Text('${LocaleProvider.current.cancel}')),
                  TextButton(
                      style: TextButton.styleFrom(primary: Colors.red),
                      onPressed: () => deleteAction(device),
                      child: Text('${LocaleProvider.current.yes}')),
                ]);
          },
        )
      ],
      child: Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Card(
            color: R.color.main_color,
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: SizedBox(
              height: (context.HEIGHT * .1) * context.TEXTSCALE,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: UtilityManager()
                          .getDeviceImageFromType(device.deviceType),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                                device?.manufacturerName ??
                                    LocaleProvider.of(context).unknown,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white)),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                                "SN : ${device?.serialNumber ?? LocaleProvider.current.unknown}",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white)),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      child: (Icon(
                        Icons.info,
                        size: 35 * context.TEXTSCALE,
                        color: R.color.white,
                      )),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                insetPadding: EdgeInsets.all(25),
                                content: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            '${LocaleProvider.current.information}',
                                            textScaleFactor: context.TEXTSCALE,
                                            style: TextStyle(
                                                color: R.color.blue,
                                                fontSize:
                                                    12 * context.TEXTSCALE),
                                          ),
                                          Flexible(
                                            child: SizedBox(
                                                width: context.WIDTH * .8,
                                                child: infoFetcher(device)),
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(
                                                    context, 'dialog');
                                              },
                                              child: Text(
                                                '${LocaleProvider.current.done}',
                                                textScaleFactor:
                                                    context.TEXTSCALE,
                                                style: TextStyle(
                                                    fontSize:
                                                        12 * context.TEXTSCALE),
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                )));
                      },
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
