import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../extension/size_extension.dart';
import '../../helper/resources.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final Widget leading;
  final Widget title;
  final List<Widget> actions;
  final Widget bottom;
  const CustomAppBar({
    Key key,
    this.leading,
    this.title,
    this.actions,
    this.bottom,
    @required this.preferredSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        width: double.infinity,
        height: context.HEIGHT * .2,
        child: Stack(
          children: [
            SvgPicture.asset(
              R.image.topTab,
              alignment: Alignment.center,
              fit: BoxFit.fill,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.WIDTH * .05,
                  vertical: context.HEIGHT * .02),
              child: SizedBox(
                height: context.HEIGHT * .1,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      leading == null
                          ? Container()
                          : SizedBox(
                              height: context.HEIGHT * .04,
                              width: context.HEIGHT * .04,
                              child: leading),
                      Expanded(
                        child:
                            Center(child: title == null ? Container() : title),
                      ),
                      actions == null
                          ? Opacity(
                              opacity: 0,
                              child: leading == null
                                  ? Container()
                                  : SizedBox(
                                      height: context.HEIGHT * .04,
                                      width: context.HEIGHT * .04,
                                      child: leading),
                            )
                          : Row(
                              children: actions
                                  .map(
                                    (action) => SizedBox(
                                        height: context.HEIGHT * .04,
                                        width: context.HEIGHT * .04,
                                        child: action),
                                  )
                                  .toList())
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }

  @override
  final Size preferredSize;
}
