import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../features/chronic_tracking/progress_sections/scale/treatment/model/treatment_type.dart';
import '../core.dart';

class RbioTreatmentCard extends StatelessWidget {
  final RbioTreatmentModel item;

  const RbioTreatmentCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: item.onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 20),
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
                  vertical: 9,
                  horizontal: 19,
                ),
                decoration: BoxDecoration(
                  color: item.type!.xBackColor,
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
                        item.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.xHeadline2.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    //
                    Text(
                      item.dateTime.xFormatTime1(),
                      style: context.xHeadline4,
                    ),
                  ],
                ),
              ),

              //
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 23,
                  horizontal: 19,
                ),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //
                          Text(
                            LocaleProvider.of(context).created_by,
                            style: context.xHeadline3.copyWith(
                              color: getIt<IAppConfig>().theme.textColorPassive,
                            ),
                          ),

                          //
                          R.sizes.hSizer4,

                          //
                          Text(
                            item.description,
                            style: context.xHeadline3.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    //
                    SizedBox(
                      height: R.sizes.iconSize2,
                      width: R.sizes.iconSize2,
                      child: SvgPicture.asset(
                        R.image.arrowRightIcon,
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

class RbioTreatmentModel {
  final String title;
  final String description;
  final DateTime dateTime;
  final VoidCallback? onTap;
  final TreatmentType? type;

  RbioTreatmentModel({
    required this.title,
    required this.description,
    required this.dateTime,
    this.onTap,
    this.type,
  });

  RbioTreatmentModel copyWith({
    String? title,
    String? description,
    DateTime? dateTime,
    VoidCallback? onTap,
    TreatmentType? type,
  }) {
    return RbioTreatmentModel(
      title: title ?? this.title,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      onTap: onTap ?? this.onTap,
      type: type ?? this.type,
    );
  }
}
