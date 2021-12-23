import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../utils/home_sizer.dart';

class UserCardTile extends StatelessWidget {
  const UserCardTile({Key key}) : super(key: key);

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
          Atom.to(PagePaths.PROFILE);
        },
        width: Atom.width - (2 * HomeSizer.instance.getBodyGapHeight()),
      ),
    );
  }
}
