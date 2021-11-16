import 'package:flutter/material.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/extension/size_extension.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/helper/resources.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({Key key, this.child, this.title, this.callBack})
      : super(key: key);
  final Widget child;
  final String title;
  final Function() callBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: callBack,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(context.HEIGHT * .02),
            color: R.color.chart_gray,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withAlpha(50),
                  blurRadius: 5,
                  spreadRadius: 0,
                  offset: Offset(5, 5))
            ],
          ),
          child: Stack(
            children: [
              Opacity(opacity: .5, child: child),
              Padding(
                padding: EdgeInsets.only(bottom: 15, left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          '$title',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 23),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      size: context.TEXTSCALE * 52,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
