import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core.dart';

class RbioAppBar extends PreferredSize {
  final Widget leading;
  final List<Widget> actions;

  RbioAppBar({
    this.leading,
    this.actions,
  }) : super(
          preferredSize: Size.fromHeight(Atom.height * 0.11),
          child: AppBar(
            toolbarHeight: Atom.height * 0.11,
            actions: actions,
            centerTitle: true,

            //
            leading: leading ??
                InkWell(
                  child: Center(
                    child: SvgPicture.asset(
                      R.image.ic_back_white,
                      width: Atom.width * 0.075,
                    ),
                  ),
                  onTap: () {
                    Atom.historyBack();
                  },
                ),

            //
            title: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: Atom.height * 0.08,
                child: Image.asset(
                  R.image.oneDoseHealthPng,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),

            //
            backgroundColor: getIt<ITheme>().mainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15),
              ),
            ),
          ),
        );
}
