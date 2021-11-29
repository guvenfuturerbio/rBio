import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core.dart';

mixin IRbioAppBar on PreferredSize {}

class RbioAppBarLogin extends PreferredSize with IRbioAppBar {
  final Widget title;
  final List<Widget> actions;
  final Widget leading;

  RbioAppBarLogin({this.title, this.actions, this.leading})
      : super(
          preferredSize: Size.fromHeight(64),
          child: AppBar(
            toolbarHeight: 64,
            actions: actions ??
                [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      R.image.oneDoseHealthPng,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ],
            centerTitle: false,
            elevation: 0,

//
            leading: leading ??
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    child: Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.fromLTRB(14, 8, 8, 8),
                      child: SvgPicture.asset(
                        R.image.back_icon,
                        width: R.sizes.iconSize,
                      ),
                    ),
                    onTap: () {
                      Atom.historyBack();
                    },
                  ),
                ),
            //
            /*title: title ??
                Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    height: 50,
                    child: Image.asset(
                      R.image.oneDoseHealthPng,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
*/

            //
            backgroundColor: getIt<ITheme>().mainColor,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.vertical(
            //     bottom: Radius.circular(15),
            //   ),
            // ),
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
