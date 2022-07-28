import 'package:flutter/material.dart';

import '../core.dart';

class RbioUserAndTreatmentTile extends StatelessWidget {
  final VoidCallback onTap;
  final bool horizontalPadding;

  const RbioUserAndTreatmentTile({
    Key? key,
    required this.onTap,
    this.horizontalPadding = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding ? 15 : 0,
      ),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            //
            Expanded(
              child: Container(
                height: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: context.xCardColor,
                  borderRadius: R.sizes.borderRadiusCircular,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RbioCircleAvatar(
                      foregroundImage: Utils.instance.getCacheProfileImage,
                      backgroundColor: context.xCardColor,
                    ),

                    //
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          getIt<ProfileStorageImpl>().getFirst().name ?? 'Name',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.xHeadline5.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //
            R.widgets.wSizer16,

            //
            GestureDetector(
              onTap: onTap,
              child: Container(
                height: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 32),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: context.xCardColor,
                  borderRadius: R.sizes.borderRadiusCircular,
                ),
                child: Text(
                  LocaleProvider.current.treatment,
                  style: context.xHeadline5.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
