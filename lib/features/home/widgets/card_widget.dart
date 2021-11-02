import 'package:atom/atom.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget leading;
  final Widget centerWidget;
  final Widget trailing;

  const CustomCard({
    Key key,
    this.leading = const SizedBox(),
    @required this.centerWidget,
    this.trailing = const SizedBox(),
  }) : super(key: key);

  factory CustomCard.getImageCircle(String leadingCircleImage,
      Widget centerWidget, double height, double width, Widget trailing) {
    Widget leadingCircle = Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 0, 10),
      height: height,
      width: width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
            image: AssetImage(leadingCircleImage), fit: BoxFit.cover),
      ),
    );
    return CustomCard(
      leading: leadingCircle,
      centerWidget: centerWidget,
      trailing: trailing,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Atom.width,
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(child: leading),
            Expanded(flex: 3, child: centerWidget),
            Expanded(child: trailing),
          ],
        ),
      ),
    );
  }
}
