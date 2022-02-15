import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/core.dart';
import '../../view_model/pressure_measurement_view_model.dart';
import 'pressure_tagger_vm.dart';

class PressureTagger extends StatelessWidget {
  final BloodPressureModel? bpModel;
  final bool isUpdate;
  final bool isEdit;
  const PressureTagger(
      {Key? key, this.bpModel, this.isUpdate = false, this.isEdit = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (_, orientation) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Dialog(
              backgroundColor: Colors.transparent,
              child: ChangeNotifierProvider(
                create: (_) => PressureTaggerVm(
                    context: context,
                    bpModel: bpModel == null
                        ? null
                        : BpMeasurementViewModel(bpModel: bpModel!.copy()),
                    isManuel: bpModel == null,
                    key: bpModel?.key),
                child: Consumer<PressureTaggerVm>(
                  builder: (_, value, __) {
                    if (orientation == Orientation.landscape) {
                      value.height = context.width;
                      value.width = context.height;
                    } else {
                      value.height = context.height;
                      value.width = context.width;
                    }
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: context.xMediaQuery.padding.vertical,
                      ),
                      child: Card(
                        elevation: R.sizes.defaultElevation,
                        color: R.color.background,
                        shape: RoundedRectangleBorder(
                          borderRadius: R.sizes.borderRadiusCircular,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: value.height * .03,
                                    right: value.width * .02,
                                    left: value.width * .02,
                                  ),
                                  child: SingleChildScrollView(
                                    controller: value.scrollController,
                                    child: Column(
                                      children: [
                                        _inputSection(value),
                                        _dateTimeSection(context, value),
                                        _noteSection(value, context),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              getAction(Atom.dismiss,
                                  isEdit ? value.update : value.save)
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  getAction(VoidCallback leftButtonAction, VoidCallback rightButtonAction) {
    return Wrap(
      children: [
        GestureDetector(
            onTap: () {
              LoggerUtils.instance.w(bpModel?.toJson());
              leftButtonAction();
            },
            child: actionButton(false)),
        GestureDetector(onTap: rightButtonAction, child: actionButton(true)),
      ],
    );
  }

  Widget actionButton(bool isSave) {
    return Card(
      elevation: R.sizes.defaultElevation,
      shape: RoundedRectangleBorder(
        borderRadius: R.sizes.borderRadiusCircular,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: R.sizes.borderRadiusCircular,
          color: isSave
              ? getIt<ITheme>().mainColor
              : getIt<ITheme>().cardBackgroundColor,
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Text(
          isSave ? LocaleProvider.current.save : LocaleProvider.current.cancel,
          style: TextStyle(
            color: isSave ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Container _noteSection(PressureTaggerVm value, BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: Card(
        elevation: R.sizes.defaultElevation,
        color: R.color.white,
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
                  //  when the TextFormField in unfocused
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  //  when the TextFormField in focused
                ),
                border: const UnderlineInputBorder())),
      ),
    );
  }

  GestureDetector _dateTimeSection(
      BuildContext context, PressureTaggerVm value) {
    return GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return SizedBox(
                    height: 260,
                    child: CupertinoDatePicker(
                      initialDateTime: value.bpModel!.date,
                      onDateTimeChanged: value.changeDate,
                      use24hFormat: true,
                      maximumDate: DateTime.now(),
                      minimumYear: DateTime.now().year,
                      maximumYear: DateTime.now().year,
                      minuteInterval: 1,
                      mode: CupertinoDatePickerMode.dateAndTime,
                    ));
              });
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
                    Text(UtilityManager().getReadableDate(
                        value.bpModel?.date ?? DateTime.now())),
                    Text(UtilityManager()
                        .getReadableHour(value.bpModel?.date ?? DateTime.now()))
                  ],
                )),
          ),
        ));
  }

  Widget _inputSection(PressureTaggerVm value) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        _inputInsideSection(
            LocaleProvider.current.sys,
            value.changeSys,
            value.context.xHeadline1,
            value.bpModel!.systolicColor,
            value.sysController,
            value.context.textScale * (value.height * .1),
            value.context),
        _inputInsideSection(
            LocaleProvider.current.dia,
            value.changeDia,
            value.context.xHeadline1,
            value.bpModel!.diastolicColor,
            value.diaController,
            value.context.textScale * (value.height * .1),
            value.context),
        _inputInsideSection(
            LocaleProvider.current.pulse,
            value.changePulse,
            value.context.xHeadline1,
            value.bpModel!.pulseColor,
            value.pulseController,
            value.context.textScale * (value.height * .1),
            value.context)
      ],
    );
  }

  Widget _inputInsideSection(
      String title,
      Function(String) onChanged,
      TextStyle style,
      Color color,
      TextEditingController controller,
      double height,
      BuildContext context) {
    return Card(
        elevation: R.sizes.defaultElevation,
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
                Text(
                  title,
                  style: style,
                ),
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
                              borderSide: BorderSide.none)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
