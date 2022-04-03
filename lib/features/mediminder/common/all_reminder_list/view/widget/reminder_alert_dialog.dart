part of '../all_reminder_list_screen.dart';

class ReminderAlertDialog extends StatelessWidget {
  final AllReminderListModel model;

  const ReminderAlertDialog({
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
              "İlacınızı almanız gerekmektedir",
              style: context.xHeadline3,
            ),

            //
            R.sizes.hSizer8,

            //
            Text(
              model.title,
              style: context.xHeadline2.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            //
            Text(
              model.scheduledDate.toString(),
              style: context.xHeadline3.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            //
            Text(
              model.nameAndSurname,
              style: context.xHeadline3,
            ),

            //
            R.sizes.hSizer4,

            //
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                //
                const Expanded(
                  child: ExpandablePostponeComponent(),
                ),

                //
                R.sizes.wSizer8,

                //
                Expanded(
                  child: RbioElevatedButton(
                    onTap: () {},
                    title: LocaleProvider.current.done_text,
                    showElevation: false,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            //
            R.sizes.hSizer4,

            //
            RbioRedButton(
              onTap: () {
                Atom.dismiss();
                Future.delayed(
                  const Duration(milliseconds: 500),
                  () {
                    Atom.to(PagePaths.reminderDetail);
                  },
                );
              },
              title: LocaleProvider.current.discard,
              infinityWidth: true,
            ),
          ],
        ),
      ),
    );
  }
}
