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
          preferredSize: Size.fromHeight(64),
          child: AppBar(
            toolbarHeight: 64,
            actions: actions,
            centerTitle: true,

            //
            leading: leading ??
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    child: Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.fromLTRB(14, 8, 8, 8),
                      child: SvgPicture.asset(
                        R.image.appbar_back,
                        width: R.sizes.iconSize,
                      ),
                    ),
                    onTap: () {
                      Atom.historyBack();
                    },
                  ),
                ),

            //
            title: title ??
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 50,
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
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: context.xHeadline1.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
