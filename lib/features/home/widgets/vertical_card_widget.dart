import 'package:atom/atom.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';

class VerticalCard extends StatelessWidget {
  final String topImage;
  final Widget bottomTitle;

  const VerticalCard({
    Key key,
    this.topImage,
    this.bottomTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RbioOrientationBuilder(
      builder: (BuildContext context, AsyncSnapshot<Orientation> snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            width: getWidth(context),
            height: getHeight(context),
            child: Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Image.asset(
                      topImage,
                      width: Atom.height * 0.10,
                      height: Atom.height * 0.10,
                    ),
                  ),

                  //
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: bottomTitle,
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

  double getWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 576) {
      return width * .3;
    } else if (width < 860) {
      return width * 0.27;
    } else if (width < 1000) {
      return width * 0.26;
    } else if (width < 1350) {
      return width * 0.23;
    } else if (width < 1600) {
      return width * 0.1871;
    }

    return width * 0.183;
  }

  double getHeight(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return R.sizes.screenHandler<double>(
      context,
      mobile: height * 0.28,
      tablet: height * 0.25,
      desktop: height * 0.25,
    );
  }
}
