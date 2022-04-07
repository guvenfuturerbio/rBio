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
            RbioElevatedButton(
              onTap: () {},
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

class ExpandablePostponeComponent extends StatefulWidget {
  const ExpandablePostponeComponent({
    Key? key,
  }) : super(key: key);

  @override
  _ExpandablePostponeComponentState createState() =>
      _ExpandablePostponeComponentState();
}

class _ExpandablePostponeComponentState
    extends State<ExpandablePostponeComponent> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: kTabScrollDuration,
      decoration: BoxDecoration(
        color: getIt<ITheme>().cardBackgroundColor,
        borderRadius: _isExpanded
            ? R.sizes.borderRadiusCircular
            : BorderRadius.circular(50),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          GestureDetector(
            onTap: () {
              if (mounted) {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              }
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Text(
                LocaleProvider.current.postpone,
                textAlign: TextAlign.center,
                style: context.xHeadline3.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          //
          SizedBox(
            width: double.infinity,
            child: RbioAnimatedClipRect(
              open: _isExpanded,
              alignment: Alignment.centerLeft,
              duration: const Duration(milliseconds: 250),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  //
                  ..._buildTimeCard("5 dk", false),

                  //
                  ..._buildTimeCard("10 dk", false),

                  //
                  ..._buildTimeCard("30 dk", false),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTimeCard(String value, bool cancelButton) => [
        //
        R.sizes.hSizer4,

        //
        Center(
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: context.xHeadline3,
          ),
        ),

        //
        R.sizes.hSizer4,

        if (!cancelButton) ...[
          //
          Container(
            color: Colors.black12,
            width: double.infinity,
            height: 0.5,
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
          ),
        ],

        //
        R.sizes.hSizer4,
      ];
}
