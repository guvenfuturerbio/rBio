import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/core.dart';
import '../../../../model/ble_models/DeviceTypes.dart';

Widget TitleAppBarWhite({String title}) => Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: AutoSizeText(
        title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
Widget MainAppBar(
        {BuildContext context,
        Widget leading,
        Widget title,
        List<Widget> actions,
        Widget bottom}) =>
    PreferredSize(
      preferredSize: Size(context.WIDTH, context.HEIGHT * 0.18),
      child: Container(
          color: Colors.transparent,
          width: double.infinity,
          child: Stack(
            children: [
              SvgPicture.asset(
                R.image.topTab,
                alignment: Alignment.center,
                fit: BoxFit.fill,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: context.WIDTH * .05,
                    vertical: context.HEIGHT * .02),
                child: SizedBox(
                  height: context.HEIGHT * .1,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        leading == null
                            ? Container()
                            : SizedBox(
                                height: context.HEIGHT * .04,
                                width: context.HEIGHT * .04,
                                child: leading),
                        Expanded(
                          child: Center(
                              child: title == null ? Container() : title),
                        ),
                        actions == null
                            ? Opacity(
                                opacity: 0,
                                child: leading == null
                                    ? Container()
                                    : SizedBox(
                                        height: context.HEIGHT * .04,
                                        width: context.HEIGHT * .04,
                                        child: leading),
                              )
                            : Row(
                                children: actions
                                    .map(
                                      (action) => SizedBox(
                                          height: context.HEIGHT * .04,
                                          width: context.HEIGHT * .04,
                                          child: action),
                                    )
                                    .toList())
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
          /* Center(
            child: Stack(
              children: <Widget>[
                Center(
                  child: SvgPicture.asset(
                    R.image.topTab,
                    alignment: Alignment.center,
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  child: leading == null
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).padding.top),
                          child: leading,
                        ),
                  left: 16,
                  top: (MediaQuery.of(context).size.height * 0.025),
                ),
                Center(
                    child: title == null
                        ? Container()
                        : Padding(
                            padding: EdgeInsets.only(
                                left: 20,
                                right: 20,
                                bottom: (MediaQuery.of(context).size.height *
                                        0.15) /
                                    2,
                                top: MediaQuery.of(context).padding.top),
                            child: title,
                          )),
                Positioned(
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: 0, top: MediaQuery.of(context).padding.top),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: actions == null ? [] : actions,
                    ),
                  ),
                  right: 8,
                  top: (MediaQuery.of(context).size.height * 0.025),
                ),
              ],
            ),
          ), */
          /*decoration: BoxDecoration(
              gradient: appBarGradient()),*/
          ),
    );

Gradient BlueGradient() => LinearGradient(
    colors: [R.color.dark_blue, R.color.defaultBlue],
    begin: Alignment.bottomLeft,
    end: Alignment.centerRight);

DeviceType getDeviceType(DiscoveredDevice device) {
  if (device.name == 'MIBFS' &&
      device.serviceData.length == 1 &&
      device.serviceData.values.first.length == 13) {
    return DeviceType.MI_SCALE;
  } else if (device.manufacturerData[0] == 112) {
    return DeviceType.ACCU_CHEK;
  } else if (device.manufacturerData[0] == 103) {
    return DeviceType.CONTOUR_PLUS_ONE;
  }

  throw Exception('Nondefined device');
}

ListView guidePopUpContextWidget(List<String> currentDeviceInfos) {
  return ListView.builder(
      shrinkWrap: true,
      itemCount: currentDeviceInfos.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: SizedBox(
            width: context.WIDTH * .8,
            child: RichText(
              textScaleFactor: context.TEXTSCALE,
              text: TextSpan(
                text: (index + 1).toString() + ".",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: R.color.dark_blue,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: currentDeviceInfos[index],
                      style: TextStyle(
                        color: R.color.black,
                        fontWeight: FontWeight.normal,
                      )),
                ],
              ),
            ),
          ),
        );
      });
}
