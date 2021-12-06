import 'package:flutter/material.dart';

import '../core.dart';

enum RbioCardAppoType { result, appointment }

class RbioCardAppoCard extends StatelessWidget {
  final RbioCardAppoType type;
  final String tenantName;
  final String departmentName;
  final String doctorName;
  final String date;
  final String time;
  final VoidCallback openDetailTap;
  final bool isActiveHeader;
  final Widget suffix;
  final Widget footer;

  RbioCardAppoCard({
    Key key,
    this.type,
    this.tenantName,
    this.departmentName,
    this.doctorName,
    this.date,
    this.time,
    this.openDetailTap,
    this.isActiveHeader,
    this.suffix,
    this.footer,
  }) : super(key: key);

  factory RbioCardAppoCard.appointment({
    String tenantName,
    String departmentName,
    String doctorName,
    String date,
    String time,
    bool isActiveHeader,
    Widget suffix,
    Widget footer,
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
    String tenantName,
    String departmentName,
    String doctorName,
    String date,
    VoidCallback openDetailTap,
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
      margin: EdgeInsets.only(top: 14),
      child: Column(
        children: [
          //
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(15),
            ),
            child: Container(
              height: 42,
              decoration: BoxDecoration(
                color: isActiveHeader
                    ? getIt<ITheme>().mainColor
                    : getIt<ITheme>().secondaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
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
                            ? getIt<ITheme>().textColor
                            : getIt<ITheme>().textColorSecondary,
                      ),
                    ),
                  ),

                  //
                  suffix ?? SizedBox(),
                ],
              ),
            ),
          ),

          //
          Container(
            decoration: BoxDecoration(
              color: getIt<ITheme>().cardBackgroundColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                SizedBox(height: 4),

                //
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      LocaleProvider.of(context).hint_doctor,
                      style: context.xHeadline4.copyWith(
                        color: getIt<ITheme>().textColorPassive,
                      ),
                    ),
                    Text(
                      doctorName,
                      style: context.xHeadline3,
                    ),
                  ],
                ),

                //
                SizedBox(height: 4),

                //
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      LocaleProvider.of(context).department,
                      style: context.xHeadline4.copyWith(
                        color: getIt<ITheme>().textColorPassive,
                      ),
                    ),
                    Text(
                      departmentName,
                      style: context.xHeadline3,
                    ),
                  ],
                ),

                //
                SizedBox(height: 4),

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
                              color: getIt<ITheme>().textColorPassive,
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
                                color: getIt<ITheme>().textColorPassive,
                              ),
                            ),
                            Text(
                              time,
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
                        onTap: openDetailTap != null ? openDetailTap : null,
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
                  footer,
                ] else ...[
                  SizedBox(
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
