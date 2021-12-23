import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../utils/home_sizer.dart';

class VerticalCard extends StatelessWidget {
  final String topImage;
  final String title;

  const  VerticalCard({
    Key key,
    @required this.topImage,
    @required this.title,
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

  double getHeight(BuildContext context) {
    return HomeSizer.instance.getBodyCardHeight();

    final height = MediaQuery.of(context).size.height;
    return R.sizes.screenHandler<double>(
      context,
      mobile: height * 0.28,
      tablet: height * 0.25,
      desktop: height * 0.25,
    );
  }
}
