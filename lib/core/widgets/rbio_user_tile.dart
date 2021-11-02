import 'package:flutter/material.dart';

import '../core.dart';

class RbioUserTile extends StatelessWidget {
  final String name;
  final void Function() onTap;
  final bool isBackColor;
  final bool isTrailingArrow;

  RbioUserTile({
    Key key,
    @required this.name,
    @required this.onTap,
    this.isBackColor = false,
    this.isTrailingArrow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isBackColor ? Colors.white : Colors.transparent,
          borderRadius: R.sizes.borderRadiusCircular,
        ),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: R.sizes.borderRadiusCircular,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 14,
          ),
          leading: CircleAvatar(
            backgroundColor: getIt<ITheme>().mainColor,
            backgroundImage: NetworkImage(R.image.mockAvatar),
            radius: Atom.width * 0.050,
          ),
          title: Text(
            name,
            style: context.xHeadline3.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: isTrailingArrow
              ? const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 25,
                )
              : SizedBox(),
        ),
      ),
    );
  }
}
