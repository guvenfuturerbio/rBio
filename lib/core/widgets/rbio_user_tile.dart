import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onedosehealth/features/home/utils/home_sizer.dart';

import '../core.dart';

class RbioUserTile extends StatelessWidget {
  final double width;
  final String name;
  final String imageBytes;
  final String imageUrl;
  final void Function() onTap;
  final UserLeadingImage leadingImage;
  final UserTrailingIcons trailingIcon;

  RbioUserTile({
    Key key,
    @required this.width,
    @required this.name,
    this.imageBytes,
    this.imageUrl,
    @required this.onTap,
    @required this.leadingImage,
    this.trailingIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: trailingIcon != null ? Colors.white : Colors.transparent,
          borderRadius: R.sizes.borderRadiusCircular,
        ),
        child: ListTile(
          dense: true,
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
          backgroundImage: imageBytes != null
              ? MemoryImage(base64.decode(imageBytes))
              : imageUrl == null
                  ? NetworkImage(R.image.circlevatar)
                  : NetworkImage(imageUrl),
          radius: Atom.width * 0.06,
        );

      case UserLeadingImage.Rectangle:
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageBytes != null
                  ? MemoryImage(base64.decode(imageBytes))
                  : imageUrl == null
                      ? NetworkImage(R.image.circlevatar)
                      : NetworkImage(imageUrl),
            ),
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
        return SvgPicture.asset(
          R.image.arrow_right_icon,
          width: R.sizes.iconSize5,
        );

      case UserTrailingIcons.Cancel:
        return SvgPicture.asset(
          R.image.cancel_icon,
          color: Colors.black,
          width: R.sizes.iconSize3,
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
