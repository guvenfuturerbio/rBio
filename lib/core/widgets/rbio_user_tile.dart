import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core.dart';

class RbioUserTile extends StatelessWidget {
  final double width;
  final String? name;
  final String? imageBytes;
  final String? imageUrl;
  final void Function() onTap;
  final UserLeadingImage leadingImage;
  final UserTrailingIcons? trailingIcon;
  final Widget? bottomChild;

  const RbioUserTile({
    Key? key,
    required this.width,
    required this.name,
    this.imageBytes,
    this.imageUrl,
    required this.onTap,
    required this.leadingImage,
    this.trailingIcon,
    this.bottomChild,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(bottom: bottomChild != null ? 8 : 0),
        decoration: BoxDecoration(
          color: trailingIcon != null ? Colors.white : Colors.transparent,
          borderRadius: R.sizes.borderRadiusCircular,
        ),
        child: Column(
          children: [
            //
            Container(
              width: width,
              alignment: Alignment.center,
              child: ListTile(
                dense: true,
                shape: R.sizes.defaultShape,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 6.0,
                ),
                leading: _getLeadingImage(context, leadingImage),
                title: Text(
                  name ?? '',
                  style: context.xHeadline3.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: _getTrailingIcon(trailingIcon),
              ),
            ),

            //
            if (bottomChild != null) bottomChild!,
          ],
        ),
      ),
    );
  }

  Widget _getLeadingImage(BuildContext context, UserLeadingImage type) {
    switch (type) {
      case UserLeadingImage.circle:
        return RbioCircleAvatar(
          backgroundColor: context.xCardColor,
          backgroundImage: imageBytes != null
              ? MemoryImage(base64.decode(imageBytes!))
              : imageUrl == null
                  ? NetworkImage(R.image.circlevatar)
                  : NetworkImage(imageUrl!) as ImageProvider<Object>?,
          radius: Atom.width * 0.06,
        );

      case UserLeadingImage.rectangle:
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageBytes != null
                  ? MemoryImage(base64.decode(imageBytes!))
                  : imageUrl == null
                      ? NetworkImage(R.image.circlevatar)
                      : NetworkImage(imageUrl!) as ImageProvider<Object>,
            ),
          ),
          width: Atom.width * 0.12,
        );

      default:
        return const SizedBox();
    }
  }

  Widget _getTrailingIcon(UserTrailingIcons? type) {
    switch (type) {
      case UserTrailingIcons.rightArrow:
        return SvgPicture.asset(
          R.image.arrowRightIcon,
          width: R.sizes.iconSize5,
        );

      case UserTrailingIcons.cancel:
        return SvgPicture.asset(
          R.image.cancel,
          color: Colors.black,
          width: R.sizes.iconSize3,
        );

      default:
        return const SizedBox();
    }
  }
}

enum UserTrailingIcons {
  rightArrow,
  cancel,
}

enum UserLeadingImage {
  rectangle,
  circle,
}
