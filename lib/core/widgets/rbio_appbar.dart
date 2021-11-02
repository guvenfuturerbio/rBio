import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core.dart';

class RbioAppBar extends PreferredSize {
  final Widget title;
  final Widget leading;
  final List<Widget> actions;

  RbioAppBar({
    this.title,
    this.leading,
    this.actions,
  }) : super(
          preferredSize: Size.fromHeight(Atom.height * 0.09),
          child: AppBar(
            toolbarHeight: Atom.height * 0.09,
            actions: actions,
            centerTitle: true,

            //
            leading: leading ??
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.symmetric(
                      vertical: Atom.width * 0.04,
                      horizontal: Atom.width * 0.02,
                    ),
                    child: InkWell(
                      child: SvgPicture.asset(
                        R.image.appbar_back,
                        width: Atom.width * 0.075,
                      ),
                      onTap: () {
                        Atom.historyBack();
                      },
                    ),
                  ),
                ),

            //
            title: title ??
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: Atom.height * 0.065,
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

  static Widget textTitle(BuildContext context, String text) {
    return Text(
      text,
      style: context.xHeadline1.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
