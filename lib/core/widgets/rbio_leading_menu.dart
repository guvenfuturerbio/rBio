import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core.dart';

class RbioLeadingMenu extends StatelessWidget {
  final GlobalKey<ScaffoldState>? drawerKey;
  final bool isHome;

  const RbioLeadingMenu({
    Key? key,
    this.drawerKey,
    this.isHome = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isHome ? EdgeInsets.zero : const EdgeInsets.all(8.0),
      child: InkWell(
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.all(8),
          child: SvgPicture.asset(
            R.image.menu,
            color: Colors.white,
            width: R.sizes.iconSize2,
          ),
        ),
        onTap: () {
          drawerKey?.currentState?.openDrawer();
        },
      ),
    );
  }
}
