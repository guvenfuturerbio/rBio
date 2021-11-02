import 'package:atom/atom.dart';
import 'package:flutter/material.dart';

class VerticalCard extends StatelessWidget {
  final Widget topImage;
  final Widget bottomTitle;
  final double width;
  final double height;

  const VerticalCard({
    Key key,
    this.topImage,
    this.bottomTitle,
    this.width,
    this.height,
  }) : super(key: key);

  factory VerticalCard.topImage({
    String topImg,
    Widget bottomTitle,
    double width,
    double height,
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
      width: width,
      height: height,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: SizedBox(
        width: width,
        height: height,
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
}
