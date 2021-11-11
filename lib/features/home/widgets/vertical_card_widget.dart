import 'package:atom/atom.dart';
import 'package:flutter/material.dart';
import 'package:onedosehealth/core/core.dart';

class VerticalCard extends StatelessWidget {
  final Widget topImage;
  final Widget bottomTitle;

  const VerticalCard({
    Key key,
    this.topImage,
    this.bottomTitle,
  }) : super(key: key);

  factory VerticalCard.topImage({
    String topImg,
    Widget bottomTitle,
  }) {
    Widget topImage = Align(
      alignment: Alignment.topRight,
      child: Image.asset(
        topImg,
        width: Atom.height * 0.10,
        height: Atom.height * 0.10,
      ),
    );

    Widget bottomTtl = bottomTitle;

    return VerticalCard(
      topImage: topImage,
      bottomTitle: bottomTtl,
    );
  }

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
                  topImage,
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: bottomTitle,
                      ))
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
      // Mobile
      return width * .3;
    } else if (width >= 576 && width < 850) {
      // Tablet
      return width * 0.2;
    } else {
      // Desktop
      return width * 0.1471;
    }
  }

  double getHeight(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    if (width < 576) {
      // Mobile
      return height * 0.25;
    } else if (width >= 576 && width < 850) {
      // Tablet
      return height * 0.25;
    } else {
      // Desktop
      return height * 0.25;
    }
  }
}
