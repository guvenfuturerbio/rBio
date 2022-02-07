import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/core.dart';
import 'bg_tagger_vm.dart';

class BgTaggerPopUp extends StatelessWidget {
  const BgTaggerPopUp({Key? key, this.data, this.isEdit = false})
      : super(key: key);
  final GlucoseData? data;
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        child: ChangeNotifierProvider(
          create: (_) => BgTaggerVm(
              context: context,
              isEdit: isEdit,
              isManual: data == null,
              data: data != null
                  ? data!.copy()
                  : GlucoseData(
                      level: "0",
                      tag: null,
                      deviceName: "",
                      time: (DateTime.now()).millisecondsSinceEpoch,
                      device: 103,
                      manual: true,
                      note: ""),
              key: data?.key),
          child: Consumer<BgTaggerVm>(
            builder: (_, value, __) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: SingleChildScrollView(
                  child: Column(
                    key: const Key('bgTagger'),
                    children: [
                      value.data.tag == 3 || value.data.tag == null
                          ? getSquareBg(value)
                          : getCircleBg(value),
                      getDateTimePicker(
                          context, value.date, value.onChangeDate),
                      getTagState(value.data.tag, value.changeTag),
                      getImage(value),
                      getNote(value.noteController),
                      getAction(value.leftAction,
                          isEdit ? value.update : value.rightAction)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // InputSection #start
  Widget getSquareBg(BgTaggerVm value) {
    return Container(
        height: 130 * value.context.textScale,
        width: 130 * value.context.textScale,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: UtilityManager()
              .getGlucoseMeasurementColor(int.parse(value.data.level)),
          border: Border.all(
            color: UtilityManager().getGlucoseMeasurementColor(int.parse(
                value.data.level)), //                   <--- border color
            width: 5.0,
          ),
        ), //             <--- BoxDecoration here
        child: boxInsideSection(value, true));
  }

  Widget getCircleBg(BgTaggerVm value) {
    return Container(
      alignment: Alignment.center,
      width: 130 * value.context.textScale,
      height: 130 * value.context.textScale,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: value.data.tag == 2
            ? UtilityManager()
                .getGlucoseMeasurementColor(int.parse(value.data.level))
            : Colors.white,
        border: Border.all(
          color: UtilityManager().getGlucoseMeasurementColor(int.parse(
              value.data.level)), //                   <--- border color
          width: 10.0,
        ),
      ),
      child: boxInsideSection(value, value.data.tag == 2),
    );
  }

  Padding boxInsideSection(BgTaggerVm value, bool isFill) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: getBgInputWidget(
                      value.controller, isFill, value.onChanged))),
          const SizedBox(
            height: 12,
          ),
          const Text(
            "mg/dL",
          ),
        ],
      ),
    );
  }

  Widget getBgInputWidget(TextEditingController controller, bool isFill,
      Function(String) onChanged) {
    return TextFormField(
      enabled: data == null,
      controller: controller,
      style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: isFill ? Colors.white : Colors.black),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      maxLength: 3,
      textAlignVertical: TextAlignVertical.bottom,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      onChanged: onChanged,
      decoration: const InputDecoration(
        counterText: '',
        errorStyle: TextStyle(height: 0),
      ),
    );
  } // InputSection #end

  // DateTimePickerSection #start
  Widget getDateTimePicker(
      BuildContext context, DateTime date, Function(DateTime) onChange) {
    return GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext builder) {
                return SizedBox(
                    height: 260,
                    child: CupertinoDatePicker(
                      initialDateTime: DateTime.now(),
                      onDateTimeChanged: onChange,
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
            color: R.color.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 4,
            child: Container(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 10, bottom: 10),
                child: readableDateTime(date)),
          ),
        ));
  }

  Row readableDateTime(DateTime date) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Text(UtilityManager().getReadableDate(date)),
        ),
        Expanded(
          child: Text(UtilityManager().getReadableHour(date)),
        )
      ],
    );
  } // DateTimePickerSection #end

  // TagSection #begin
  Wrap getTagState(int? currentTag, Function(int) changeTag) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () => changeTag(1),
          child: getTagElement(
            currentTag == 1,
            R.image.beforeMealIconBlack,
            LocaleProvider.current.hungry,
          ),
        ),
        GestureDetector(
          onTap: () => changeTag(2),
          child: getTagElement(
            currentTag == 2,
            R.image.aftermealIconBlack,
            LocaleProvider.current.full,
          ),
        ),
        GestureDetector(
          onTap: () => changeTag(3),
          child: getTagElement(
            currentTag == null || currentTag == 3,
            R.image.otherIcon,
            LocaleProvider.current.other,
          ),
        ),
      ],
    );
  }

  Card getTagElement(bool isCurrent, String icon, String title) {
    return Card(
      color: isCurrent
          ? getIt<ITheme>().mainColor
          : getIt<ITheme>().cardBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      elevation: 4,
      child: Container(
        decoration: getTagElementDeco(isCurrent),
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 20,
              width: 20,
              child: SvgPicture.asset(
                icon,
                color: isCurrent ? Colors.white : Colors.black,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.left,
              style: TextStyle(color: isCurrent ? Colors.white : Colors.black),
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration getTagElementDeco(bool isCurrent) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      color: isCurrent
          ? getIt<ITheme>().mainColor
          : getIt<ITheme>().cardBackgroundColor,
    );
  } // TagSection #end

  // ImageSection #begin
  GestureDetector getImage(BgTaggerVm value) {
    return GestureDetector(
        onTap: () {
          takeImage(value.context, value);
        },
        child: Padding(
            padding: const EdgeInsets.only(left: 8, top: 16),
            child: Row(
              children: <Widget>[
                SizedBox(
                    width: 60,
                    height: 60,
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        height: 25,
                        width: 25,
                        child: (value.data.imageURL != null &&
                                    value.data.imageURL == "") ||
                                Atom.isWeb
                            ? SvgPicture.asset(
                                R.image.addphotoIcon,
                              )
                            : PhotoView(
                                imageProvider: FileImage(File(
                                    getIt<GlucoseStorageImpl>()
                                        .getImagePathOfImageURL(
                                            value.data.imageURL!))),
                              ),
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(LocaleProvider.current.add_photo)),
              ],
            )));
  }

  takeImage(BuildContext context, BgTaggerVm value) async {
    String title = LocaleProvider.current.how_to_get_photo;

    Atom.show(Platform.isIOS
        ? CupertinoAlertDialog(
            title: Text(title),
            content: Text(LocaleProvider.current.pick_a_photo_option),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(
                  LocaleProvider.current.camera,
                ),
                isDefaultAction: true,
                onPressed: () {
                  value.getPhotoFromSource(ImageSource.camera);
                },
              ),
              CupertinoDialogAction(
                child: Text(
                  LocaleProvider.current.gallery,
                ),
                isDefaultAction: true,
                onPressed: () {
                  value.getPhotoFromSource(ImageSource.gallery);
                },
              ),
            ],
          )
        : AlertDialog(
            title: Text(
              title,
              style: const TextStyle(fontSize: 22),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(LocaleProvider.current.camera),
                onPressed: () {
                  value.getPhotoFromSource(ImageSource.camera);
                },
              ),
              TextButton(
                child: Text(LocaleProvider.current.gallery),
                onPressed: () {
                  value.getPhotoFromSource(ImageSource.gallery);
                },
              )
            ],
          ));
  }
// ImageSection #end

  // NoteSection #begin
  Container getNote(TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      height: 120,
      child: Card(
        color: R.color.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        elevation: 4,
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.multiline,
          maxLines: null,
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
            border: const UnderlineInputBorder(),
          ),
        ),
      ),
    );
  } // NoteSection #end

  // GetAction #begin
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
}
