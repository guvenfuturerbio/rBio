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
            width: HomeSizer.instance.getWidth(context),
            height: getHeight(context),
            child: Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
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
                  // Align(
                  //   alignment: Alignment.topRight,
                  //   child: Image.asset(
                  //     topImage,
                  //     width: Atom.height * 0.10,
                  //     height: Atom.height * 0.10,
                  //   ),
                  // ),

                  //
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: getIt<ITheme>().textTheme.headline2,
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

  double getHeight(BuildContext context) =>
      HomeSizer.instance.getBodyCardHeight();
}
