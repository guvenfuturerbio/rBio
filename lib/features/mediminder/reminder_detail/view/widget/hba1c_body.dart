part of '../reminder_detail_screen.dart';

class _Hba1cBody extends StatelessWidget {
  final Hba1CReminderModel model;

  const _Hba1cBody({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        //
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: getIt<IAppConfig>().theme.cardBackgroundColor,
            borderRadius: R.sizes.borderRadiusCircular,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              _buildDetailsTitle(context),

              //
              _buildTitleRow(
                context,
                LocaleProvider.current.last_test_date,
                LocaleProvider.current.last_result,
                false,
              ),

              //
              _buildTitleRow(
                context,
                model.lastTestDate == null
                    ? ''
                    : model.lastTestDate!.xDateFormat,
                model.lastTestValue == null ? '' : '${model.lastTestValue} %',
                true,
              ),

              //
              _buildGap(),

              //
              _buildTitleRow(
                context,
                LocaleProvider.current.reminder_date,
                LocaleProvider.current.time,
                false,
              ),

              //
              _buildTitleRow(
                context,
                model.scheduledDate.xDateFormat,
                model.scheduledDate.xHourFormat,
                true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
