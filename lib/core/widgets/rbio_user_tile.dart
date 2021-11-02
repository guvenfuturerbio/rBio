import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core.dart';

class RbioUserTile extends StatelessWidget {
  final String name;
  final String imageUrl;
  final void Function() onTap;
  final UserLeadingImage leadingImage;
  final UserTrailingIcons trailingIcon;

  RbioUserTile({
    Key key,
    @required this.name,
    @required this.imageUrl,
    @required this.onTap,
    @required this.leadingImage,
    this.trailingIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: trailingIcon != null ? Colors.white : Colors.transparent,
          borderRadius: R.sizes.borderRadiusCircular,
        ),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: R.sizes.borderRadiusCircular,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 6.0,
          ),
          leading: _getLeadingImage(leadingImage),
          title: Text(
            name ?? '',
            style: context.xHeadline3.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          // subtitle: Text(
          //   'Hangi doktordan randevu almak istiyorsunuz?',
          //   maxLines: 2,
          //   overflow: TextOverflow.ellipsis,
          //   style: context.xHeadline5.copyWith(
          //     fontWeight: FontWeight.w600,
          //     color: Colors.grey,
          //   ),
          // ),
          trailing: _getTrailingIcon(trailingIcon),
        ),
      ),
    );
  }

  Widget _getLeadingImage(UserLeadingImage type) {
    switch (type) {
      case UserLeadingImage.Circle:
        return CircleAvatar(
          backgroundColor: getIt<ITheme>().mainColor,
          backgroundImage: NetworkImage(imageUrl),
          radius: Atom.width * 0.06,
        );

      case UserLeadingImage.Rectangle:
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(imageUrl)),
          ),
          width: Atom.width * 0.12,
        );

      default:
        return SizedBox();
    }
  }

  Widget _getTrailingIcon(UserTrailingIcons type) {
    switch (type) {
      case UserTrailingIcons.RightArrow:
        return Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey,
          size: 25,
        );

      case UserTrailingIcons.Cancel:
        return SvgPicture.asset(
          R.image.close,
          color: Colors.black,
          width: 20,
        );

      default:
        return SizedBox();
    }
  }
}

enum UserTrailingIcons {
  RightArrow,
  Cancel,
}

enum UserLeadingImage {
  Rectangle,
  Circle,
}
