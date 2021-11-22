import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/core.dart';
import '../../../../generated/l10n.dart';

class LandScapeBottomActionsWidget extends StatelessWidget {
  const LandScapeBottomActionsWidget({
    Key key,
    this.filterAction,
    this.changeGrapahAction,
  }) : super(key: key);
  final Function() filterAction;
  final Function() changeGrapahAction;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: context.WIDTH * .03,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              shadowColor: Colors.transparent,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.HEIGHT))),
          onPressed: filterAction,
          child: Container(
            height: context.HEIGHT * .1,
            width: context.WIDTH * .25,
            decoration: BoxDecoration(
              color: R.color.white,
              borderRadius: BorderRadius.circular(context.HEIGHT),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withAlpha(50),
                    blurRadius: 5,
                    spreadRadius: 0,
                    offset: Offset(5, 4))
              ],
            ),
            padding: EdgeInsets.symmetric(
                vertical: context.HEIGHT * .0, horizontal: context.WIDTH * .04),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: SvgPicture.asset(
                    R.image.filter_graph_icon,
                    color: R.color.blue,
                    height: context.HEIGHT * .06,
                    width: context.HEIGHT * .06,
                  ),
                ),
                Spacer(),
                Expanded(
                  flex: 5,
                  child: Text(
                    '${LocaleProvider.current.filter_graphs}',
                    maxLines: 2,
                    style: TextStyle(
                        color: R.color.blue,
                        fontSize: context.TEXTSCALE * 12.5),
                  ),
                ),
              ],
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              shadowColor: Colors.transparent,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.HEIGHT))),
          onPressed: changeGrapahAction,
          child: Container(
            height: context.HEIGHT * .1,
            width: context.WIDTH * .25,
            decoration: BoxDecoration(
              color: R.color.white,
              borderRadius: BorderRadius.circular(context.HEIGHT),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withAlpha(50),
                    blurRadius: 5,
                    spreadRadius: 0,
                    offset: Offset(5, 4))
              ],
            ),
            padding: EdgeInsets.symmetric(
                vertical: context.HEIGHT * .005,
                horizontal: context.WIDTH * .04),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: SvgPicture.asset(
                    R.image.changeGraph,
                    color: R.color.blue,
                    height: context.HEIGHT * .06,
                    width: context.HEIGHT * .06,
                  ),
                ),
                Spacer(),
                Expanded(
                  flex: 5,
                  child: Text(
                    '${LocaleProvider.current.change_graph_type}',
                    style: TextStyle(
                        color: R.color.blue,
                        fontSize: context.TEXTSCALE * 12.5),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: context.WIDTH * .03,
        ),
      ],
    );
  }
}
