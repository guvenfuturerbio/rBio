import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/core.dart';
import '../../../../../config/config.dart';
import '../../model/model.dart';
import '../../viewmodel/bp_measurement_vm.dart';
import 'bp_tagger_vm.dart';

class BpTaggerPopUp extends StatelessWidget {
  final BloodPressureModel? bpModel;
  final bool isUpdate;
  final bool isEdit;

  const BpTaggerPopUp({
    Key? key,
    this.bpModel,
    this.isUpdate = false,
    this.isEdit = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        return ChangeNotifierProvider<BpTaggerVm>(
          create: (_) => BpTaggerVm(
            key: bpModel?.key,
            context: context,
            bpModel: bpModel == null
                ? null
                : BpMeasurementViewModel(bpModel: bpModel!.copy()),
            isManuel: bpModel == null,
          ),
          child: RbioDarkStatusBar(
            child: KeyboardDismissOnTap(
              child: _buildConsumer(orientation),
            ),
          ),
        );
      },
    );
  }

  Widget _buildConsumer(Orientation orientation) {
    return Consumer<BpTaggerVm>(
      builder: (BuildContext context, value, Widget? child) {
        if (orientation == Orientation.landscape) {
          value.height = context.width;
          value.width = context.height;
        } else {
          value.height = context.height;
          value.width = context.width;
        }

        return Container(
          color: context.xScaffoldBackgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              SizedBox(height: Atom.safeTop),

              //
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    controller: value.scrollController,
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.only(
                      top: 8,
                      left: 8,
                      right: 8,
                      bottom: context.xMediaQuery.viewInsets.bottom,
                    ),
                    child: Column(
                      children: [
                        _buildInputSection(context, value),
                        _buildDateTimeSection(context, value),
                        _buildNoteSection(context, value),
                      ],
                    ),
                  ),
                ),
              ),

              //
              _buildActions(
                context,
                Atom.dismiss,
                isEdit ? value.update : value.save,
              ),

              //
              R.widgets.hSizer8,
              SizedBox(height: Atom.safeBottom),
            ],
          ),
        );
      },
    );
  }

  // #region _buildInputSection
  Widget _buildInputSection(BuildContext context, BpTaggerVm value) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        _buildInsideSection(
          LocaleProvider.current.sys,
          value.changeSys,
          value.context.xHeadline1,
          value.bpModel!.systolicColor(context),
          value.sysController,
          value.context.textScale * (value.height * .1),
          value.context,
        ),
        _buildInsideSection(
          LocaleProvider.current.dia,
          value.changeDia,
          value.context.xHeadline1,
          value.bpModel!.diastolicColor(context),
          value.diaController,
          value.context.textScale * (value.height * .1),
          value.context,
        ),
        _buildInsideSection(
          LocaleProvider.current.pulse,
          value.changePulse,
          value.context.xHeadline1,
          value.bpModel!.pulseColor(context),
          value.pulseController,
          value.context.textScale * (value.height * .1),
          value.context,
        ),
      ],
    );
  }
  // #endregion

  // #region _buildInsideSection
  Widget _buildInsideSection(
    String title,
    Function(String) onChanged,
    TextStyle style,
    Color color,
    TextEditingController controller,
    double height,
    BuildContext context,
  ) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: R.sizes.borderRadiusCircular,
        side: BorderSide(width: 7, color: color),
      ),
      child: SizedBox(
        height: context.height * .2 * context.textScale,
        width: context.width * .30 * context.textScale,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //
              Text(
                title,
                style: style,
              ),

              //
              Expanded(
                child: Center(
                  child: TextField(
                    controller: controller,
                    onChanged: onChanged,
                    enabled: (bpModel?.isManual ?? true),
                    maxLength: 3,
                    keyboardType: TextInputType.number,
                    style: style,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // #endregion

  // #region _buildDateTimeSection
  Widget _buildDateTimeSection(BuildContext context, BpTaggerVm value) {
    return GestureDetector(
      onTap: () async {
        final DateTime? pickedDate = await showRbioDatePicker(
          context,
          title: LocaleProvider.of(context).date,
          initialDateTime: value.bpModel!.date,
          maximumDate: DateTime.now(),
          minimumDate: DateTime(2000),
          mode: CupertinoDatePickerMode.dateAndTime,
        );

        if (pickedDate != null) {
          value.changeDate(pickedDate);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16, top: 20),
        child: Card(
          color: getIt<IAppConfig>().theme.white,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 10,
              bottom: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                //
                Expanded(
                  child: Text(
                    (value.bpModel?.date ?? DateTime.now()).xGetReadableDate,
                    style: context.xHeadline4,
                  ),
                ),

                //
                Text(
                  (value.bpModel?.date ?? DateTime.now()).xGetReadableHour,
                  style: context.xHeadline4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // #endregion

  // #region _buildNoteSection
  Widget _buildNoteSection(BuildContext context, BpTaggerVm value) {
    return Container(
      padding: const EdgeInsets.only(top: 12),
      child: Card(
        child: TextField(
          controller: value.noteController,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          onChanged: value.addNote,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 12, right: 12),
            hintText: LocaleProvider.current.notes,
            hintStyle: const TextStyle(fontSize: 12),
            labelText: LocaleProvider.current.notes,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            border: const UnderlineInputBorder(),
          ),
        ),
      ),
    );
  }
  // #endregion

  // #region _buildActions
  Widget _buildActions(
    BuildContext context,
    VoidCallback leftButtonAction,
    VoidCallback rightButtonAction,
  ) {
    return Wrap(
      children: [
        //
        _buildActionButton(
          context,
          isSave: false,
          onTap: leftButtonAction,
        ),

        //
        R.widgets.wSizer8,

        //
        _buildActionButton(
          context,
          isSave: true,
          onTap: rightButtonAction,
        ),
      ],
    );
  }
  // #endregion

  // #region _buildActionButton
  Widget _buildActionButton(
    BuildContext context, {
    required bool isSave,
    required void Function()? onTap,
  }) {
    return RbioElevatedButton(
      title:
          isSave ? LocaleProvider.current.save : LocaleProvider.current.cancel,
      onTap: onTap,
      backColor: isSave ? null : context.xCardColor,
      textColor: isSave ? null : context.xTextInverseColor,
    );
  }
  // #endregion
}
