import 'package:flutter/material.dart';
import 'package:onedosehealth/features/home/utils/home_sizer.dart';

import '../../../core/core.dart';

class UserCardTile extends StatelessWidget {
  const UserCardTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RbioUserTile(
      name:
          '${getIt<UserNotifier>().getPatient().firstName} ${getIt<UserNotifier>().getPatient().lastName}',
      leadingImage: UserLeadingImage.Circle,
      trailingIcon: UserTrailingIcons.RightArrow,
      onTap: () {
        Atom.to(PagePaths.PROFILE);
      },
      width: HomeSizer.instance.getWidth(context) * 3,
    );
  }
}
