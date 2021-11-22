import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../core/core.dart';
import '../../../../../../generated/l10n.dart';
import '../../../extension/size_extension.dart';

class BottomActionsOfGraph extends StatelessWidget {
  const BottomActionsOfGraph({
    Key key,
    this.value,
  }) : super(key: key);

  final value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Wrap(
        spacing: context.WIDTH * .1,
        runSpacing: context.HEIGHT * .01,
        children: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                primary: Colors.white,
                shadowColor: Colors.black.withAlpha(50),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 7),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(context.HEIGHT))),
            onPressed: () => value.showFilter(context),
            icon: SvgPicture.asset(
              R.image.filter_graph_icon,
              color: R.color.blue,
              height: (context.HEIGHT * .03) * context.TEXTSCALE,
              width: (context.HEIGHT * .03) * context.TEXTSCALE,
            ),
            label: AutoSizeText(
              '${LocaleProvider.current.filter_graphs}',
              maxLines: 1,
              style: TextStyle(color: R.color.blue, fontSize: 15),
            ),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                primary: Colors.white,
                shadowColor: Colors.black.withAlpha(50),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 7),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(context.HEIGHT))),
            onPressed: () => value.changeGraphType(),
            icon: SvgPicture.asset(R.image.changeGraph,
                color: R.color.blue,
                height: (context.HEIGHT * .03) * context.TEXTSCALE,
                width: (context.HEIGHT * .03) * context.TEXTSCALE),
            label: AutoSizeText(
              '${LocaleProvider.current.change_graph_type}',
              maxLines: 1,
              softWrap: false,
              style: TextStyle(
                color: R.color.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
