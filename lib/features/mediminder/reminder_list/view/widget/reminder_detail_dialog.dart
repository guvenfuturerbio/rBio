part of '../reminder_list_screen.dart';

class ReminderDetailDialog extends StatelessWidget {
  final ReminderListModel model;

  const ReminderDetailDialog({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: context.width - 50,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: context.scaffoldBackgroundColor,
          borderRadius: R.sizes.borderRadiusCircular,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            Center(
              child: Text(
                LocaleProvider.current.blood_glucose_measurement_title,
                style: getIt<IAppConfig>().theme.dialogTheme.title(context),
              ),
            ),

            R.sizes.hSizer32,

            Center(
              child: Text(
                getIt<UserNotifier>().getCurrentUserNameAndSurname(),
                style:
                    getIt<IAppConfig>().theme.dialogTheme.description(context),
              ),
            ),

            R.sizes.hSizer12,

            //
            if ((model.subTitle ?? '').isNotEmpty) ...[
              Center(
                child: Text(
                  model.subTitle!,
                  style:
                      context.xHeadline3.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],

            //

            //
            R.sizes.hSizer32,

            // //
            // RbioElevatedButton(
            //   onTap: () {
            //     Atom.dismiss();
            //   },
            //   title: LocaleProvider.current.done_text,
            //   padding: const EdgeInsets.symmetric(vertical: 10),
            //   fontWeight: FontWeight.bold,
            // ),

            // //
            // R.sizes.hSizer4,

            //
            Row(
              children: [
                Expanded(
                  child: RbioSmallDialogButton.white(
                    onPressed: () {
                      Atom.dismiss();
                      Future.delayed(
                        const Duration(milliseconds: 500),
                        () {
                          Atom.to(
                            PagePaths.reminderDetail,
                            queryParameters: <String, String>{
                              'title': model.title,
                              'remindable': model.remindable.toRouteString(),
                              'createdDate': model.createdDate.toString(),
                              'notificationId': model.notificationId.toString(),
                            },
                          );
                        },
                      );
                    },
                    title: LocaleProvider.current.details,
                  ),
                ),

                //
                R.sizes.wSizer8,

                //
                Expanded(
                  child: RbioSmallDialogButton.red(
                    onPressed: () {
                      context.read<ReminderListCubit>().removeReminder(model);
                      Atom.dismiss();
                    },
                    title: LocaleProvider.current.delete,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
