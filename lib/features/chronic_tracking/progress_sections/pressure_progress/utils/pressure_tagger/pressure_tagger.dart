import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onedosehealth/core/domain/blood_pressure_model.dart';
import 'package:onedosehealth/features/chronic_tracking/progress_sections/pressure_progress/utils/pressure_tagger/pressure_tagger_vm.dart';
import 'package:onedosehealth/features/chronic_tracking/progress_sections/pressure_progress/view_model/pressure_measurement_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/core.dart';

class PressureTagger extends StatelessWidget {
  final BloodPressureModel bpModel;
  final bool isUpdate;
  final bool isEdit;
  PressureTagger(
      {Key key, this.bpModel, this.isUpdate = false, this.isEdit = false})
      : super(key: key);

  static double height = 0;
  static double width = 0;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (_, orientation) {
        if (orientation == Orientation.landscape) {
          height = context.WIDTH;
          width = context.HEIGHT;
        } else {
          height = context.HEIGHT;
          width = context.WIDTH;
        }
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
                        : BpMeasurementViewModel(bpModel: bpModel.copy()),
                    isManuel: bpModel == null,
                    key: bpModel?.key),
                child: Consumer<PressureTaggerVm>(
                  builder: (_, value, __) {
                    return Card(
                      color: R.color.background,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: height * .03,
                                right: width * .02,
                                left: width * .02,
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
                            getAction(Atom.dismiss,
                                isEdit ? value.update : value.save)
                          ],
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
        GestureDetector(onTap: leftButtonAction, child: actionButton(false)),
        GestureDetector(onTap: rightButtonAction, child: actionButton(true)),
      ],
    );
  }

  Widget actionButton(bool isSave) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: isSave
                ? getIt<ITheme>().mainColor
                : getIt<ITheme>().cardBackgroundColor),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
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
      padding: EdgeInsets.only(top: 16),
      child: Card(
        color: R.color.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        elevation: 4,
        child: TextField(
            controller: value.noteController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            onChanged: value.addNote,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 12, right: 12),
                hintText: LocaleProvider.current.notes,
                hintStyle: TextStyle(fontSize: 12),
                labelText: LocaleProvider.current.notes,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  //  when the TextFormField in unfocused
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  //  when the TextFormField in focused
                ),
                border: UnderlineInputBorder())),
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
                return Container(
                    height: 260,
                    child: CupertinoDatePicker(
                      initialDateTime: value.bpModel.date ?? DateTime.now(),
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
          padding: EdgeInsets.only(bottom: 16, top: 16),
          child: Card(
            color: R.color.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 4,
            child: Container(
                width: double.infinity,
                padding:
                    EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                        "${UtilityManager().getReadableDate(value.bpModel?.date ?? DateTime.now())}"),
                    Text(
                        "${UtilityManager().getReadableHour(value.bpModel?.date ?? DateTime.now())}")
                  ],
                )),
          ),
        ));
  }

  Widget _inputSection(PressureTaggerVm value) {
    return Row(
      children: [
        _inputInsideSection(
            LocaleProvider.current.sys,
            value.changeSys,
            value.context.xHeadline1,
            value.bpModel.systolicColor,
            value.sysController),
        _inputInsideSection(
            LocaleProvider.current.dia,
            value.changeDia,
            value.context.xHeadline1,
            value.bpModel.diastolicColor,
            value.diaController),
        _inputInsideSection(
            LocaleProvider.current.pulse,
            value.changePulse,
            value.context.xHeadline1,
            value.bpModel.pulseColor,
            value.pulseController)
      ],
    );
  }

  Widget _inputInsideSection(String title, Function(String) onChanged,
      TextStyle style, Color color, TextEditingController controller) {
    return Expanded(
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: BorderSide(width: 7, color: color)),
            child: SizedBox(
              height: height * .1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$title',
                      style: style,
                    ),
                    Expanded(
                      child: Center(
                        child: TextField(
                          controller: controller,
                          onChanged: onChanged,
                          maxLength: 3,
                          keyboardType: TextInputType.number,
                          style: style,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide.none)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
