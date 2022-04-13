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
        margin: const EdgeInsets.all(36),
        padding: const EdgeInsets.all(18),
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
            Text(
              model.title,
              style: context.xHeadline3,
            ),

            //
            if ((model.subTitle ?? '').isNotEmpty) ...[
              Text(
                model.subTitle!,
                style: context.xHeadline3,
              ),
            ],

            //
            Text(
              model.nameAndSurname,
              style: context.xHeadline3,
            ),

            //
            R.sizes.hSizer8,

            //
            RbioElevatedButton(
              onTap: () {
                Atom.dismiss();
              },
              title: LocaleProvider.current.done_text,
              padding: const EdgeInsets.symmetric(vertical: 10),
              fontWeight: FontWeight.bold,
            ),

            //
            R.sizes.hSizer4,

            //
            RbioElevatedButton(
              onTap: () {
                Atom.dismiss();
                Future.delayed(
                  const Duration(milliseconds: 500),
                  () {
                    Atom.to(
                      PagePaths.reminderDetail,
                      queryParameters: <String, String>{
                        'title': model.title,
                        'remindable': model.remindable.toRouteString(),
                        'notificationId': model.notificationId.toString(),
                      },
                    );
                  },
                );
              },
              title: LocaleProvider.current.details,
              padding: const EdgeInsets.symmetric(vertical: 10),
              backColor: getIt<ITheme>().cardBackgroundColor,
              textColor: getIt<ITheme>().textColorSecondary,
              fontWeight: FontWeight.bold,
            ),

            //
            R.sizes.hSizer4,

            //
            RbioRedButton(
              onTap: () {
                context.read<ReminderListCubit>().removeReminder(model);
                Atom.dismiss();
              },
              title: LocaleProvider.current.btn_delete_reminder,
              infinityWidth: true,
            ),
          ],
        ),
      ),
    );
  }
}
