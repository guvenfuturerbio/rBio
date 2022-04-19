import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/core.dart';
import 'scale_tagger_vm.dart';

class ScaleTaggerPopUp extends StatelessWidget {
  final ScaleEntity? scaleModel;
  final bool isUpdate;

  const ScaleTaggerPopUp({
    Key? key,
    this.scaleModel,
    this.isUpdate = false,
  }) : super(key: key);

  static double height = 0;
  static double width = 0;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        if (orientation == Orientation.landscape) {
          height = context.width;
          width = context.height;
        } else {
          height = context.height;
          width = context.width;
        }

        return ChangeNotifierProvider(
          create: (_) => ScaleTaggerVm(
            // key: scaleModel?.key,
            context: context,
            scale: scaleModel == null ? null : scaleModel!.copy(),
            isManuel: scaleModel == null,
          ),
          child: RbioDarkStatusBar(
            child: KeyboardDismissOnTap(
              child: _buildConsumer(),
            ),
          ),
        );
      },
    );
  }

  // #region _buildConsumer
  Widget _buildConsumer() {
    return Consumer<ScaleTaggerVm>(
      builder: (BuildContext context, ScaleTaggerVm vm, Widget? child) {
        return Container(
          color: context.scaffoldBackgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              SizedBox(height: Atom.safeTop),

              //
              Expanded(
                child: SingleChildScrollView(
                  controller: vm.scrollController,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.only(
                    top: 8,
                    left: 8,
                    right: 8,
                    bottom: context.xMediaQuery.viewInsets.bottom,
                  ),
                  child: Column(
                    children: [
                      _buildWeightInputSection(vm, context),
                      _buildDateTimeSection(context, vm),
                      _buildParametersSection(context, vm),
                      _buildNoteSection(context, vm),
                    ],
                  ),
                ),
              ),

              //
              R.sizes.hSizer8,

              //
              _buildActions(
                Atom.dismiss,
                isUpdate ? vm.update : vm.save,
              ),

              //
              R.sizes.hSizer8,
              SizedBox(height: Atom.safeBottom),
            ],
          ),
        );
      },
    );
  }
  // #endregion

  // #region _buildWeightInputSection
  Widget _buildWeightInputSection(ScaleTaggerVm value, BuildContext context) {
    return Stack(
      children: [
        //
        Align(
          alignment: Alignment.center,
          child: Container(
            height: height * .2,
            width: height * .2,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(50),
                  blurRadius: 5,
                  spreadRadius: 0,
                  offset: const Offset(3, 3),
                ),
              ],
              border: Border.all(
                width: 10,
                color: value.scaleModel.getColor(
                  SelectedScaleType.weight,
                ),
              ),
              shape: BoxShape.circle,
              color: isUpdate || scaleModel == null
                  ? R.color.white
                  : context.scaffoldBackgroundColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //
                _buildInputSection(
                  value.weightController,
                  validator: (input) {
                    if (input?.isNotEmpty ?? false) {
                      return "";
                    } else {
                      return "";
                    }
                  },
                  onChanged: value.changeWeight,
                ),

                //
                Text(
                  value.scaleModel.unit.toStr,
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                ),
              ],
            ),
          ),
        ),

        //
        _buildInfoButton(context)
      ],
    );
  }
  // #endregion

  // #region _buildInfoButton
  Widget _buildInfoButton(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        barrierColor: Colors.transparent,
        builder: (_) => BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Dialog(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: R.sizes.borderRadiusCircular,
            ),
            child: ListView(
              shrinkWrap: true,
              children: [
                _buildItemOfColorInfoDialog(
                  context,
                  R.color.very_low,
                  LocaleProvider.current.very_low,
                ),
                _buildItemOfColorInfoDialog(
                  context,
                  R.color.low,
                  LocaleProvider.current.low,
                ),
                _buildItemOfColorInfoDialog(
                  context,
                  R.color.target,
                  LocaleProvider.current.target,
                ),
                _buildItemOfColorInfoDialog(
                  context,
                  R.color.high,
                  LocaleProvider.current.high,
                ),
                _buildItemOfColorInfoDialog(
                  context,
                  R.color.very_high,
                  LocaleProvider.current.very_high,
                ),
              ],
            ),
          ),
        ),
      ),
      child: Icon(
        Icons.info,
        size: 40 * context.textScale,
      ),
    );
  }
  // #endregion

  // #region _buildItemOfColorInfoDialog
  Widget _buildItemOfColorInfoDialog(
    BuildContext context,
    Color color,
    String title,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: Container(
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            height: 18 * context.textScale,
            width: 18 * context.textScale,
          ),
        ),

        //
        Expanded(
          child: Text(
            title,
            style: context.xHeadline4,
          ),
        ),
      ],
    );
  }
  // #endregion

  // #region _buildDateTimeSection
  Widget _buildDateTimeSection(BuildContext context, ScaleTaggerVm value) {
    return GestureDetector(
      onTap: () async {
        final DateTime? pickedDate = await showRbioDatePicker(
          context,
          title: LocaleProvider.of(context).date,
          initialDateTime: value.scaleModel.dateTime,
          maximumDate: DateTime.now(),
          minimumDate: DateTime(2000),
          mode: CupertinoDatePickerMode.dateAndTime,
        );

        if (pickedDate != null) {
          value.changeDate(pickedDate);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16, top: 16),
        child: Card(
          elevation: R.sizes.defaultElevation,
          color: R.color.white,
          shape: RoundedRectangleBorder(
            borderRadius: R.sizes.borderRadiusCircular,
          ),
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
                Expanded(
                  child: Text(
                    UtilityManager().getReadableDate(
                      value.scaleModel.dateTime,
                    ),
                    style: context.xHeadline4,
                  ),
                ),
                Text(
                  UtilityManager().getReadableHour(
                    value.scaleModel.dateTime,
                  ),
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

  // #region _buildParametersSection
  Widget _buildParametersSection(
    BuildContext context,
    ScaleTaggerVm value,
  ) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 5 / 4,
      padding: const EdgeInsets.all(15),
      children: [
        _buildParameter(
          context: context,
          controller: value.bmiController,
          name: LocaleProvider.current.scale_data_bmi,
          color: value.scaleModel.getColor(SelectedScaleType.bmi),
          type: '',
          index: 1,
          isBmi: true,
          crossAxisCount: 1,
          onChanged: value.changeBmi,
        ),
        _buildParameter(
          context: context,
          controller: value.bodyFatController,
          name: LocaleProvider.current.scale_data_body_fat,
          color: value.scaleModel.getColor(SelectedScaleType.bodyFat),
          type: '%',
          index: 2,
          crossAxisCount: 1,
          onChanged: value.changeBodyFat,
        ),
        _buildParameter(
          context: context,
          controller: value.boneMassController,
          name: LocaleProvider.current.scale_data_bone_mass,
          color: value.scaleModel.getColor(SelectedScaleType.boneMass),
          type: '${value.scaleModel.unit}',
          index: 3,
          crossAxisCount: 2,
          onChanged: value.changeBoneMass,
        ),
        _buildParameter(
          context: context,
          name: LocaleProvider.current.scale_data_muscle,
          controller: value.muscleController,
          color: value.scaleModel.getColor(SelectedScaleType.muscle),
          type: '%',
          index: 4,
          crossAxisCount: 2,
          onChanged: value.changeMuscle,
        ),
        _buildParameter(
          context: context,
          controller: value.visceralController,
          name: LocaleProvider.current.scale_data_visceral_fat,
          color: value.scaleModel.getColor(SelectedScaleType.visceralFat),
          type: '',
          index: 5,
          crossAxisCount: 3,
          onChanged: value.changeVisceral,
        ),
        _buildParameter(
          context: context,
          controller: value.waterController,
          name: LocaleProvider.current.scale_data_water,
          color: value.scaleModel.getColor(SelectedScaleType.water),
          type: '%',
          index: 6,
          crossAxisCount: 3,
          onChanged: value.changeWater,
        ),
      ],
    );
  }
  // #endregion

  // #region _buildParameter
  Widget _buildParameter({
    required BuildContext context,
    required TextEditingController controller,
    required String name,
    required Color color,
    required String type,
    required int index,
    required int crossAxisCount,
    required void Function(String) onChanged,
    bool isBmi = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: index.isEven
                ? Colors.black.withOpacity(.04)
                : Colors.transparent,
            width: 1.5,
          ),
          top: BorderSide(
            color: crossAxisCount != 1
                ? Colors.black.withOpacity(.04)
                : Colors.transparent,
            width: 1.5,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //
          Expanded(
            child: Center(
              child: Text(
                name,
                style: context.xHeadline5,
              ),
            ),
          ),

          //
          Expanded(
            flex: 3,
            child: Container(
              width: width * .24,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
                border: Border.all(width: 6, color: color),
                shape: BoxShape.rectangle,
                color: !isBmi &&
                        (scaleModel == null || (scaleModel?.isManuel ?? true))
                    ? R.color.white
                    : context.scaffoldBackgroundColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildInputSection(
                  controller,
                  isBmi: isBmi,
                  onChanged: onChanged,
                ),
              ),
            ),
          ),

          //
          Expanded(
            child: Center(
              child: Text(
                type,
                style: context.xHeadline5,
              ),
            ),
          )
        ],
      ),
    );
  }
  // #endregion

  // #region _buildNoteSection
  Widget _buildNoteSection(BuildContext context, ScaleTaggerVm value) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Card(
        elevation: R.sizes.defaultElevation,
        shape: RoundedRectangleBorder(
          borderRadius: R.sizes.borderRadiusCircular,
        ),
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
    VoidCallback leftButtonAction,
    VoidCallback rightButtonAction,
  ) {
    return Wrap(
      children: [
        //
        _buildActionButton(
          isSave: false,
          onTap: leftButtonAction,
        ),

        if (!isUpdate) ...[
          //
          R.sizes.wSizer8,

          //
          _buildActionButton(
            isSave: true,
            onTap: rightButtonAction,
          ),
        ],
      ],
    );
  }
  // #endregion

  // #region _buildActionButton
  Widget _buildActionButton({
    required bool isSave,
    required void Function()? onTap,
  }) {
    return RbioElevatedButton(
      title:
          isSave ? LocaleProvider.current.save : LocaleProvider.current.cancel,
      onTap: onTap,
      showElevation: false,
      backColor: isSave ? null : getIt<IAppConfig>().theme.cardBackgroundColor,
      textColor: isSave ? null : getIt<IAppConfig>().theme.textColorSecondary,
    );
  }
  // #endregion

  // #region _buildInputSection
  Widget _buildInputSection(
    TextEditingController controller, {
    String Function(String?)? validator,
    required void Function(String) onChanged,
    bool isBmi = false,
  }) {
    return TextFormField(
      enabled: !isBmi && (scaleModel == null || (scaleModel?.isManuel ?? true)),
      style: Utils.instance
          .inputTextStyle(getIt<IAppConfig>().theme.textColorSecondary),
      controller: controller,
      maxLength: 5,
      maxLines: 1,
      textAlign: TextAlign.center,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      onChanged: onChanged,
      decoration: const InputDecoration(
        border: InputBorder.none,
        counterText: '',
        errorStyle: TextStyle(height: 0),
      ),
      validator: validator,
    );
  }
  // #endregion
}
