part of '../all_reminder_list_screen.dart';

class FilterDialog extends StatelessWidget {
  const FilterDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: Atom.height * 0.75,
        ),
        margin: const EdgeInsets.all(36),
        decoration: BoxDecoration(
          color: context.scaffoldBackgroundColor,
          borderRadius: R.sizes.borderRadiusCircular,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: 8,
          ),
          scrollDirection: Axis.vertical,
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              ..._buildPersonalList(context),

              //
              R.sizes.hSizer8,

              //
              ..._buildStatusList(context),

              //
              R.sizes.hSizer8,

              //
              ..._buildTypeList(context),

              //
              R.sizes.hSizer8,

              //
              _buildButtons(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildPersonalList(BuildContext context) => [
        //
        Text(
          LocaleProvider.current.person,
          style: context.xHeadline3,
        ),

        //
        _buildCheckboxWithText(context, "Ayşe Yıldırım"),
        _buildCheckboxWithText(context, "Ahmet Yıldırım"),
        _buildCheckboxWithText(context, "Zeynep Yıldırım"),
      ];

  List<Widget> _buildStatusList(BuildContext context) => [
        //
        Text(
          LocaleProvider.current.status,
          style: context.xHeadline3,
        ),

        //
        _buildCheckboxWithText(context, LocaleProvider.current.not_done),
        _buildCheckboxWithText(context, LocaleProvider.current.future),
      ];

  List<Widget> _buildTypeList(BuildContext context) => [
        //
        Text(
          LocaleProvider.current.type,
          style: context.xHeadline3,
        ),

        //
        _buildCheckboxWithText(
          context,
          LocaleProvider.current.medication_reminders,
        ),
        _buildCheckboxWithText(
          context,
          LocaleProvider.current.blood_glucose_measurement,
        ),
        _buildCheckboxWithText(
          context,
          LocaleProvider.current.strip_tracker,
        ),
        _buildCheckboxWithText(
          context,
          LocaleProvider.current.hbA1c_measurement,
        ),
      ];

  Widget _buildButtons() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        //
        Expanded(
          child: RbioElevatedButton(
            onTap: () {},
            title: LocaleProvider.current.btn_cancel,
            showElevation: false,
            padding: EdgeInsets.zero,
            backColor: getIt<ITheme>().cardBackgroundColor,
            textColor: getIt<ITheme>().textColorSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),

        //
        R.sizes.wSizer8,

        //
        Expanded(
          child: RbioElevatedButton(
            onTap: () {},
            title: LocaleProvider.current.apply,
            showElevation: false,
            padding: EdgeInsets.zero,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildCheckboxWithText(
    BuildContext context,
    String text,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          //
          Flexible(
            child: SizedBox.fromSize(
              size: const Size(20, 20),
              child: Checkbox(
                value: true,
                onChanged: (newValue) {},
                activeColor: getIt<ITheme>().mainColor,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ),

          //
          R.sizes.wSizer8,

          //
          Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.xHeadline4,
          ),
        ],
      ),
    );
  }
}
