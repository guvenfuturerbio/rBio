import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/config.dart';
import '../core.dart';

mixin IRbioAppBar on PreferredSize {}

class RbioAppBar extends PreferredSize with IRbioAppBar {
  final BuildContext context;
  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final double? leadingWidth;

  RbioAppBar({
    Key? key,
    required this.context,
    this.title,
    this.leading,
    this.actions,
    this.leadingWidth,
  }) : super(
          key: key,
          preferredSize: const Size.fromHeight(64),
          child: AppBar(
            toolbarHeight: 64,
            centerTitle: true,
            elevation: 0,
            backgroundColor: context.xAppBarTheme.backgroundColor,

            //
            leadingWidth: leadingWidth,
            leading: leading ??
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.fromLTRB(14, 8, 8, 8),
                      child: SvgPicture.asset(
                        R.image.back,
                        width: R.sizes.iconSize,
                        color: context.xAppBarTheme.iconTheme?.color,
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
                    height: getIt<IAppConfig>().theme.appBarLogoHeight,
                    child: SvgPicture.asset(
                      getIt<IAppConfig>().theme.appLogo,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),

            //
            actions: actions ??
                [
                  if (title == null) ...[
                    Opacity(
                      opacity: 0,
                      child: AbsorbPointer(
                        absorbing: true,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 14, 8),
                          child: SvgPicture.asset(
                            R.image.back,
                            width: R.sizes.iconSize,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
          ),
        );

  static Widget defaultLeading(BuildContext context, void Function() onTap) {
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.fromLTRB(14, 8, 8, 8),
          child: SvgPicture.asset(
            R.image.back,
            width: R.sizes.iconSize,
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  static Widget textTitle(BuildContext context, String text) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: context.xAppBarTheme.titleTextStyle,
    );
  }
}
