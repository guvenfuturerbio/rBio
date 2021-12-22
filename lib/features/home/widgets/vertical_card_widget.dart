import 'package:flutter/material.dart';
import 'package:onedosehealth/features/home/utils/home_sizer.dart';

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
            width: HomeSizer.instance.getWidth(context),
            height: getHeight(context),
            child: Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
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
