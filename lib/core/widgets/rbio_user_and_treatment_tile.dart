import 'package:flutter/material.dart';

import '../core.dart';

class RbioUserAndTreatmentTile extends StatelessWidget {
  final VoidCallback onTap;

  const RbioUserAndTreatmentTile({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
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
                  color: getIt<IAppConfig>().theme.cardBackgroundColor,
                  borderRadius: R.sizes.borderRadiusCircular,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      foregroundImage: Utils.instance.getCacheProfileImage,
                      backgroundColor:
                          getIt<IAppConfig>().theme.cardBackgroundColor,
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
            const SizedBox(width: 15),

            //
            GestureDetector(
              onTap: () {},
              child: Container(
                height: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 32),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: getIt<IAppConfig>().theme.cardBackgroundColor,
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
