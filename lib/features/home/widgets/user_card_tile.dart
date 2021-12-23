import 'package:flutter/material.dart';
import 'package:onedosehealth/features/home/view/home_screen.dart';

import '../../../core/core.dart';
import '../utils/home_sizer.dart';
import '../viewmodel/home_vm.dart';

class UserCardTile extends StatelessWidget {
  final HomeVm homeVm;

  const UserCardTile({
    Key key,
    this.homeVm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: HomeSizer.instance.getBodyUserTileHeight(),
      child: RbioUserTile(
        name:
            '${getIt<UserNotifier>().getPatient().firstName} ${getIt<UserNotifier>().getPatient().lastName}',
        leadingImage: UserLeadingImage.Circle,
        trailingIcon: UserTrailingIcons.RightArrow,
        onTap: () {
          if (homeVm.isForDelete) {
            homeVm.addWidget(homeVm.key1);
          } else if (homeVm.status == ShakeMod.notShaken) {
            Atom.to(PagePaths.PROFILE);
          }
        },
        width: Atom.width - (2 * HomeSizer.instance.getBodyGapHeight()),
      ),
    );
  }
}
