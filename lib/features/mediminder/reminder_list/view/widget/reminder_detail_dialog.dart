part of '../reminder_list_screen.dart';

class ReminderDetailDialog extends StatelessWidget {
  final ReminderListModel model;

  const ReminderDetailDialog({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RbioBaseDialog(
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        physics: context.xBouncingScroll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                //
                Center(
                  child: Text(
                    LocaleProvider.current.blood_glucose_measurement_title,
                    style: context.xDialogTheme.titleTextStyle,
                  ),
                ),

                //
                R.widgets.hSizer32,

                //
                Center(
                  child: Text(
                    getIt<UserFacade>().getNameAndSurname(),
                    style: context.xDialogTheme.descriptionTextStyle,
                  ),
                ),

                //
                R.widgets.hSizer12,

                //
                if ((model.subTitle ?? '').isNotEmpty) ...[
                  Center(
                    child: Text(
                      model.subTitle!,
                      style: context.xDialogTheme.subTitleTextStyle,
                    ),
                  ),
                ],

                //
                R.widgets.hSizer40,

                //
                Row(
                  children: [
                    Expanded(
                      child: RbioSmallDialogButton.white(
                        context,
                        onPressed: () {
                          Atom.dismiss();
                          Future.delayed(
                            const Duration(milliseconds: 500),
                            () {
                              Atom.to(
                                PagePaths.reminderDetail,
                                queryParameters: <String, String>{
                                  'title': model.title,
                                  'remindable':
                                      model.remindable.toRouteString(),
                                  'createdDate': model.createdDate.toString(),
                                  'notificationId':
                                      model.notificationId.toString(),
                                },
                              );
                            },
                          );
                        },
                        title: LocaleProvider.current.details,
                      ),
                    ),

                    //
                    R.widgets.wSizer8,

                    //
                    Expanded(
                      child: RbioSmallDialogButton.red(
                        context,
                        onPressed: () {
                          context
                              .read<ReminderListCubit>()
                              .removeReminder(model);
                          Atom.dismiss();
                        },
                        title: LocaleProvider.current.delete,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
