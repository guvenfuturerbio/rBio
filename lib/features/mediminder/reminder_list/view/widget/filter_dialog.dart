part of '../reminder_list_screen.dart';

class FilterDialog extends StatelessWidget {
  const FilterDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReminderListCubit, ReminderListState>(
      builder: (context, state) {
        return state.whenOrNull(
              success: (result) {
                final filterResult = result.filterResult;
                return _FilterDialogView(filterResult: filterResult);
              },
            ) ??
            const SizedBox();
      },
    );
  }
}

class _FilterDialogView extends StatefulWidget {
  final ReminderListFilterResult filterResult;

  const _FilterDialogView({
    Key? key,
    required this.filterResult,
  }) : super(key: key);

  @override
  __FilterDialogViewState createState() => __FilterDialogViewState();
}

class __FilterDialogViewState extends State<_FilterDialogView> {
  late ReminderListFilterResult currentResult;

  @override
  void initState() {
    currentResult = widget.filterResult;
    super.initState();
  }

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
              ..._buildPersonalList(),

              //
              R.widgets.hSizer8,

              //
              ..._buildStatusList(),

              //
              R.widgets.hSizer8,

              //
              ..._buildTypeList(),

              //
              R.widgets.hSizer8,

              //
              _buildButtons(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildPersonalList() => [
        //
        Text(
          LocaleProvider.current.person,
          style: context.xHeadline3,
        ),

        //
        for (int index = 0;
            index < currentResult.relativeList.length;
            index++) ...[
          FilterRow(
            text: currentResult.relativeList[index].nameAndSurname,
            isEnabled: currentResult.relativeList[index].isEnabled,
            onChanged: (newValue) {
              var relativeList = currentResult.relativeList;
              relativeList = relativeList.update(
                index,
                ReminderRelativePerson(
                  id: currentResult.relativeList[index].id,
                  isEnabled: newValue,
                  nameAndSurname:
                      currentResult.relativeList[index].nameAndSurname,
                ),
              );
              currentResult = currentResult.copyWith(
                relativeList: relativeList,
              );
            },
          ),
        ],
      ];

  List<Widget> _buildStatusList() => [
        //
        Text(
          LocaleProvider.current.status,
          style: context.xHeadline3,
        ),

        //
        FilterRow(
          text: LocaleProvider.current.not_done,
          isEnabled: currentResult.isNotCompleted,
          onChanged: (newValue) {
            currentResult = currentResult.copyWith(
              isNotCompleted: newValue,
            );
          },
        ),
        FilterRow(
          text: LocaleProvider.current.future,
          isEnabled: currentResult.isCompleted,
          onChanged: (newValue) {
            currentResult = currentResult.copyWith(
              isCompleted: newValue,
            );
          },
        ),
      ];

  List<Widget> _buildTypeList() => [
        //
        Text(
          LocaleProvider.current.type,
          style: context.xHeadline3,
        ),

        //
        FilterRow(
          text: LocaleProvider.current.medication_reminders,
          isEnabled: currentResult.isMedication,
          onChanged: (newValue) {
            currentResult = currentResult.copyWith(
              isMedication: newValue,
            );
          },
        ),
        FilterRow(
          text: LocaleProvider.current.blood_glucose_measurement,
          isEnabled: currentResult.isBloodGlucose,
          onChanged: (newValue) {
            currentResult = currentResult.copyWith(
              isBloodGlucose: newValue,
            );
          },
        ),
        FilterRow(
          text: LocaleProvider.current.strip_tracker,
          isEnabled: currentResult.isStrip,
          onChanged: (newValue) {
            currentResult = currentResult.copyWith(
              isStrip: newValue,
            );
          },
        ),
        FilterRow(
          text: LocaleProvider.current.hbA1c_measurement,
          isEnabled: currentResult.isHbA1c,
          onChanged: (newValue) {
            currentResult = currentResult.copyWith(
              isHbA1c: newValue,
            );
          },
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
            onTap: () {
              Atom.dismiss();
            },
            title: LocaleProvider.current.btn_cancel,
            padding: EdgeInsets.zero,
            backColor: context.xCardColor,
            textColor: getIt<IAppConfig>().theme.textColorSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),

        //
        R.widgets.wSizer8,

        //
        Expanded(
          child: RbioElevatedButton(
            onTap: () {
              context
                  .read<ReminderListCubit>()
                  .changeFilterResult(currentResult);
              Atom.dismiss();
            },
            title: LocaleProvider.current.apply,
            padding: EdgeInsets.zero,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class FilterRow extends StatefulWidget {
  final String text;
  final bool isEnabled;
  final void Function(bool) onChanged;

  const FilterRow({
    Key? key,
    required this.text,
    required this.isEnabled,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<FilterRow> createState() => _FilterRowState();
}

class _FilterRowState extends State<FilterRow> {
  late bool currentValue;

  @override
  void initState() {
    currentValue = widget.isEnabled;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              child: RbioCheckbox(
                value: currentValue,
                onChanged: (newValue) {
                  if (newValue == null) return;
                  setState(() {
                    currentValue = newValue;
                  });
                  widget.onChanged(newValue);
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ),

          //
          R.widgets.wSizer8,

          //
          Text(
            widget.text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.xHeadline4,
          ),
        ],
      ),
    );
  }
}
