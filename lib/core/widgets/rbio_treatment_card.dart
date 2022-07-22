import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../features/chronic_tracking/scale/scale.dart';
import '../core.dart';

class RbioTreatmentCard extends StatelessWidget {
  final RbioTreatmentModel item;
  final VoidCallback onTap;
  final String subTitle;

  const RbioTreatmentCard._({
    Key? key,
    required this.item,
    required this.onTap,
    required this.subTitle,
  }) : super(key: key);

  factory RbioTreatmentCard.createdBy({
    required RbioTreatmentModel item,
    required VoidCallback onTap,
  }) {
    return RbioTreatmentCard._(
      item: item,
      onTap: onTap,
      subTitle: LocaleProvider.current.created_by,
    );
  }

  factory RbioTreatmentCard.title({
    required RbioTreatmentModel item,
    required VoidCallback onTap,
  }) {
    return RbioTreatmentCard._(
      item: item,
      onTap: onTap,
      subTitle: LocaleProvider.current.title,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                  color: item.type!.xBackColor(context),
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
                        item.type!.xGetTitle(context),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.xHeadline2.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    //
                    Text(
                      item.dateTime == null
                          ? ''
                          : item.dateTime!.xFormatTime1(),
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
                  color: context.xCardColor,
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
                            subTitle,
                            style: context.xHeadline3.copyWith(
                              color: context.xAppColors.textDisabledColor,
                            ),
                          ),

                          //
                          R.widgets.hSizer4,

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
  final int id;
  final String description;
  final DateTime? dateTime;
  final TreatmentType? type;

  RbioTreatmentModel({
    required this.id,
    required this.description,
    required this.dateTime,
    this.type,
  });

  RbioTreatmentModel copyWith({
    int? id,
    String? description,
    DateTime? dateTime,
    VoidCallback? onTap,
    TreatmentType? type,
  }) {
    return RbioTreatmentModel(
      id: id ?? this.id,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      type: type ?? this.type,
    );
  }
}
