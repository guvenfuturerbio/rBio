import 'package:flutter/material.dart';

import '../core.dart';

class RbioForYouCategoryCard extends StatelessWidget {
  final int? id;
  final String? title;
  final Image? icon;
  final VoidCallback onTap;

  const RbioForYouCategoryCard({
    Key? key,
    this.id,
    this.title,
    this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        clipBehavior: Clip.antiAlias,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: R.sizes.borderRadiusCircular,
        ),
        child: SizedBox(
          height: 300,
          width: 300,
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              //
              FittedBox(
                fit: BoxFit.fill,
                child: icon,
              ),

              //
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.065,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        context.xPrimaryColor.withOpacity(0.8),
                        context.xPrimaryColor.withOpacity(0.3),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color:
                            getIt<IAppConfig>().theme.darkBlack.withAlpha(50),
                        blurRadius: 15,
                        spreadRadius: 0,
                        offset: const Offset(5, 10),
                      ),
                    ],
                  ),
                  child: Wrap(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(6),
                        child: Text(
                          title ?? "No title",
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: context.xHeadline5.copyWith(
                            fontWeight: FontWeight.bold,
                            color: getIt<IAppConfig>().theme.textColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
