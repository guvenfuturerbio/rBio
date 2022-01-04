import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../utils/home_sizer.dart';

class VerticalCard extends StatelessWidget {
  final String title;
  final CustomPainter painter;

  const VerticalCard({
    Key key,
    @required this.title,
    @required this.painter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RbioOrientationBuilder(
      builder: (BuildContext context, AsyncSnapshot<Orientation> snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            width: HomeSizer.instance.getBodyCardWidth(context),
            height: HomeSizer.instance.getBodyCardHeight(),
            child: Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: R.sizes.borderRadiusCircular,
              ),
              child: Stack(
                children: [
                  //
                  Align(
                    alignment: Alignment.topRight,
                    child: CustomPaint(
                      size: Size(Atom.height * 0.10, Atom.height * 0.10),
                      painter: painter,
                    ),
                  ),

                  //
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        title,
                        maxLines: 3,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: getIt<ITheme>().textTheme.headline3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return SizedBox();
      },
    );
  }
}
