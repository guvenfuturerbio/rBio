import 'package:flutter/material.dart';

import '../core.dart';

enum RbioCardAppoType { result, appointment }

class RbioCardAppoCard extends StatelessWidget {
  final RbioCardAppoType type;
  final String tenantName;
  final String departmentName;
  final String doctorName;
  final String date;
  final String? time;
  final VoidCallback? openDetailTap;
  final bool isActiveHeader;
  final Widget? suffix;
  final Widget? footer;

  const RbioCardAppoCard({
    Key? key,
    required this.type,
    required this.tenantName,
    required this.departmentName,
    required this.doctorName,
    required this.date,
    this.time,
    this.openDetailTap,
    required this.isActiveHeader,
    this.suffix,
    this.footer,
  }) : super(key: key);

  factory RbioCardAppoCard.appointment({
    required String tenantName,
    required String departmentName,
    required String doctorName,
    required String date,
    required String time,
    required bool isActiveHeader,
    required Widget suffix,
    required Widget footer,
  }) {
    return RbioCardAppoCard(
      type: RbioCardAppoType.appointment,
      tenantName: tenantName,
      departmentName: departmentName,
      doctorName: doctorName,
      date: date,
      time: time,
      isActiveHeader: isActiveHeader,
      suffix: suffix,
      footer: footer,
    );
  }

  factory RbioCardAppoCard.result({
    required String tenantName,
    required String departmentName,
    required String doctorName,
    required String date,
    required VoidCallback openDetailTap,
  }) {
    return RbioCardAppoCard(
      type: RbioCardAppoType.result,
      tenantName: tenantName,
      departmentName: departmentName,
      doctorName: doctorName,
      date: date,
      isActiveHeader: false,
      openDetailTap: openDetailTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 14),
      child: Column(
        children: [
          //
          ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: R.sizes.radiusCircular,
            ),
            child: Container(
              height: 42,
              decoration: BoxDecoration(
                color: isActiveHeader
                    ? context.xPrimaryColor
                    : getIt<IAppConfig>().theme.secondaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: R.sizes.radiusCircular,
                  topRight: R.sizes.radiusCircular,
                ),
              ),
              padding: const EdgeInsets.only(
                left: 10.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  //
                  Expanded(
                    child: Text(
                      tenantName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.xHeadline2.copyWith(
                        color: isActiveHeader
                            ? getIt<IAppConfig>().theme.textColor
                            : getIt<IAppConfig>().theme.textContrastColor,
                      ),
                    ),
                  ),

                  //
                  suffix ?? const SizedBox(),
                ],
              ),
            ),
          ),

          //
          Container(
            decoration: BoxDecoration(
              color: getIt<IAppConfig>().theme.cardBackgroundColor,
              borderRadius: BorderRadius.only(
                bottomLeft: R.sizes.radiusCircular,
                bottomRight: R.sizes.radiusCircular,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                const SizedBox(height: 4),

                //
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      LocaleProvider.of(context).hint_doctor,
                      style: context.xHeadline4.copyWith(
                        color: getIt<IAppConfig>().theme.textColorPassive,
                      ),
                    ),
                    Text(
                      doctorName,
                      style: context.xHeadline3,
                    ),
                  ],
                ),

                //
                const SizedBox(height: 4),

                //
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      LocaleProvider.of(context).department,
                      style: context.xHeadline4.copyWith(
                        color: getIt<IAppConfig>().theme.textColorPassive,
                      ),
                    ),
                    Text(
                      departmentName,
                      style: context.xHeadline3,
                    ),
                  ],
                ),

                //
                const SizedBox(height: 4),

                //
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LocaleProvider.of(context).hint_date,
                            style: context.xHeadline4.copyWith(
                              color: getIt<IAppConfig>().theme.textColorPassive,
                            ),
                          ),
                          Text(
                            date,
                            style: context.xHeadline3,
                          )
                        ],
                      ),
                    ),

                    //
                    Spacer(
                      flex: type == RbioCardAppoType.result ? 2 : 1,
                    ),

                    //
                    if (type == RbioCardAppoType.appointment) ...[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocaleProvider.current.hint_time,
                              style: context.xHeadline4.copyWith(
                                color:
                                    getIt<IAppConfig>().theme.textColorPassive,
                              ),
                            ),
                            Text(
                              time ?? '',
                              style: context.xHeadline3,
                            ),
                          ],
                        ),
                      ),
                    ] else ...[
                      RbioElevatedButton(
                        title: openDetailTap != null
                            ? LocaleProvider.current.show
                            : LocaleProvider.current.waiting,
                        onTap: openDetailTap,
                        padding: RbioElevatedButton.minPadding(),
                      ),
                    ],

                    //
                    if (type == RbioCardAppoType.result) ...[
                      const SizedBox(),
                    ] else ...[
                      const Spacer()
                    ],
                  ],
                ),

                //
                if (footer != null) ...[
                  footer!,
                ] else ...[
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
