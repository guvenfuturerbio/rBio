import 'package:flutter/material.dart';

import '../core.dart';

enum RbioCardAppoType { result, appointment }

class RbioCardAppoCard extends StatelessWidget {
  final String tenantName;
  final String doctorName;
  final String departmentName;
  final String date;
  final String time;
  final Widget suffix;
  final RbioCardAppoType widgetype;
  final VoidCallback onTap;
  Color bannerColor;
  List<Widget> bottomButtons;

  RbioCardAppoCard(
      {Key key,
      this.tenantName,
      this.doctorName,
      this.departmentName,
      this.date,
      this.time,
      this.suffix,
      this.widgetype,
      this.onTap,
      this.bannerColor,
      this.bottomButtons})
      : super(key: key);

  factory RbioCardAppoCard.appointment(
      {String tenantName,
      String doctorName,
      String departmentName,
      String date,
      String time,
      Widget suffix,
      Color bannerColor,
      List<Widget> bottomButtons}) {
    return RbioCardAppoCard(
      date: date,
      departmentName: departmentName,
      doctorName: doctorName,
      tenantName: tenantName,
      time: time,
      suffix: suffix ?? SizedBox(),
      bannerColor: bannerColor,
      widgetype: RbioCardAppoType.appointment,
      bottomButtons: bottomButtons ?? [],
    );
  }

  factory RbioCardAppoCard.result({
    String tenantName,
    String doctorName,
    String departmentName,
    String date,
    VoidCallback onTap,
  }) {
    return RbioCardAppoCard(
      date: date,
      departmentName: departmentName,
      doctorName: doctorName,
      tenantName: tenantName,
      onTap: onTap,
      widgetype: RbioCardAppoType.result,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (Atom.height * .06) + (Atom.height * .2),
      margin: EdgeInsets.only(top: 14),
      child: Column(
        children: [
          //
          Expanded(
            flex: 20,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: bannerColor ?? getIt<ITheme>().secondaryColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                padding: const EdgeInsets.only(left: 10.0),
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
                        style: context.xHeadline3,
                      ),
                    ),

                    //
                    suffix ?? SizedBox(),
                  ],
                ),
              ),
            ),
          ),

          //
          Expanded(
            flex: 85,
            child: Container(
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
                  Row(
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
                        flex: widgetype == RbioCardAppoType.result ? 2 : 1,
                      ),

                      //
                      widgetype == RbioCardAppoType.appointment
                          ? Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Saat",
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
                            )
                          : RbioElevatedButton(
                              title: onTap != null ? "Görüntüle" : "Bekleniyor",
                              onTap: onTap != null ? onTap : null,
                            ),

                      //
                      if (widgetype == RbioCardAppoType.result) ...[
                        const SizedBox(),
                      ] else ...[
                        const Spacer()
                      ],
                    ],
                  ),
                  bottomButtons?.length != 0
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: bottomButtons ?? [],
                        )
                      : SizedBox()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
