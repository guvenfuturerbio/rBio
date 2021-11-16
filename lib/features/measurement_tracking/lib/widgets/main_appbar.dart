import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/helper/resources.dart';

/*Widget MainAppBar(
    {BuildContext context,
      Widget leading,
      Widget title,
      List<Widget> actions,
      Widget bottom}) =>
    PreferredSize(
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Stack(
            children: <Widget>[
              Positioned(
                child: leading == null ? Container() : leading,
                left: 0,
              ),
              Center(
                child: title == null
                    ? Container()
                    : Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: title,
                ),
              ),
              Positioned(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: actions == null ? [] : actions,
                ),
                right: 0,
              )
            ],
          ),
          decoration: BoxDecoration(
              gradient: GreenGradient()),
        ),
        preferredSize: Size(MediaQuery.of(context).size.width, 50.0));*/

Gradient GreenGradient() => LinearGradient(
    colors: [R.color.blue, R.color.blue],
    begin: Alignment.bottomLeft,
    end: Alignment.centerRight);

/*Widget TitleAppBarWhite({String title}) => Container(
  padding: EdgeInsets.only(left: 20, right: 20),
  child: Text(
    title.toUpperCase(),
    style: TextStyle(
        fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
    textAlign: TextAlign.center,
  ),
);*/
