part of '../reminder_alert_dialog.dart';

class _ExpandablePostponeComponent extends StatefulWidget {
  const _ExpandablePostponeComponent({
    Key? key,
  }) : super(key: key);

  @override
  __ExpandablePostponeComponentState createState() =>
      __ExpandablePostponeComponentState();
}

class __ExpandablePostponeComponentState
    extends State<_ExpandablePostponeComponent> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: kTabScrollDuration,
      decoration: BoxDecoration(
        color: getIt<IAppConfig>().theme.cardBackgroundColor,
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
                children: ReminderPostponeType.values
                    .map(
                      (e) => GestureDetector(
                        onTap: () {
                          context
                              .read<ReminderAlertDialogCubit>()
                              .createPostponeNotification(e);
                        },
                        child: _buildTimeCard(e.xGetTitle),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeCard(String value) => Container(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
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

            //
            Container(
              color: Colors.black12,
              width: double.infinity,
              height: 0.5,
              margin: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
            ),

            //
            R.sizes.hSizer4,
          ],
        ),
      );
}
