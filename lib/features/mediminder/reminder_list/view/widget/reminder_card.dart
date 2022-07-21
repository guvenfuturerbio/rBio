part of '../reminder_list_screen.dart';

class ReminderCard extends StatelessWidget {
  final tz.TZDateTime currentTime;
  final ReminderListModel model;

  const ReminderCard({
    Key? key,
    required this.currentTime,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Atom.show(
          BlocProvider.value(
            value: context.read<ReminderListCubit>(),
            child: ReminderDetailDialog(
              model: model,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: ClipRRect(
          borderRadius: R.sizes.borderRadiusCircular,
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              model.status ? Colors.transparent : Colors.grey,
              BlendMode.saturation,
            ),
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
                    color: context.xPrimaryColor,
                    borderRadius: BorderRadius.vertical(
                      top: R.sizes.radiusCircular,
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
                          model.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.xHeadline4.copyWith(
                            color: getIt<IAppConfig>().theme.textColor,
                          ),
                        ),
                      ),

                      //
                      Text(
                        model.subTitle ?? '',
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
                    color: context.xCardColor,
                    borderRadius: BorderRadius.vertical(
                      bottom: R.sizes.radiusCircular,
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
                            model.status
                                ? currentTime.xCalculateTimeDifferenceBetween(
                                    endDate: TZHelper.instance
                                        .fromMillisecondsSinceEpoch(
                                            model.scheduledDate))
                                : '',
                            style: context.xHeadline3.copyWith(
                              fontWeight: FontWeight.bold,
                              color: context.xPrimaryColor,
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
                                '${model.scheduledDate.xDateFormat} : ${model.scheduledDate.xHourFormat}',
                                style: context.xHeadline4.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              //
                              R.widgets.hSizer8,

                              //
                              Text(
                                getIt<UserFacade>().getNameAndSurname(),
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
      ),
    );
  }
}
