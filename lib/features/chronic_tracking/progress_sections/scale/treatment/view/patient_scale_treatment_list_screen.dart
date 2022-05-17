import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';

class PatientScaleTreatmentListScreen extends StatelessWidget {
  const PatientScaleTreatmentListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: RbioAppBar(),
      body: Column(
        children: [
          RbioTreatmentCard(
            title: "Diyet Listesi",
            description: "Tedavi notları",
            dateTime: DateTime.now(),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class RbioTreatmentCard extends StatelessWidget {
  final String title;
  final String description;
  final DateTime dateTime;
  final VoidCallback onTap;

  const RbioTreatmentCard({
    Key? key,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: getIt<IAppConfig>().theme.mainColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    //
                    Expanded(
                      child: Text(
                        "model.title",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.xHeadline4.copyWith(
                          color: getIt<IAppConfig>().theme.textColor,
                        ),
                      ),
                    ),

                    //
                    Text(
                      "model.subTitle",
                      style: context.xHeadline4.copyWith(
                        color: getIt<IAppConfig>().theme.textColor,
                      ),
                    ),
                  ],
                ),
              ),

              //
              Container(
                decoration: BoxDecoration(
                  color: getIt<IAppConfig>().theme.cardBackgroundColor,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(12),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    //
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(
                          left: 12,
                        ),
                        child: Text(
                          "sadasd",
                          style: context.xHeadline3.copyWith(
                            fontWeight: FontWeight.bold,
                            color: getIt<IAppConfig>().theme.mainColor,
                          ),
                        ),
                      ),
                    ),

                    //
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(
                          top: 12,
                          bottom: 12,
                          right: 12,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            //
                            Text(
                              "sad",
                              style: context.xHeadline4.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            //
                            R.sizes.hSizer8,

                            //
                            Text(
                              "sad",
                              style: context.xHeadline4.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
