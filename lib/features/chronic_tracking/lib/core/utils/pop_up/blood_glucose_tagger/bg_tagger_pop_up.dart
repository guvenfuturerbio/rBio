import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onedosehealth/core/data/service/chronic_service/chronic_storage_service.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/core.dart';
import '../../../../../../../generated/l10n.dart';
import '../../../../database/repository/glucose_repository.dart';
import '../../../../extension/size_extension.dart';
import 'bg_tagger_vm.dart';

class BgTaggerPopUp extends StatelessWidget {
  BgTaggerPopUp({Key key, this.data, this.isEdit}) : super(key: key);
  final GlucoseData data;
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
                  ? GlucoseData().fromGlucoseData(data)
                  : GlucoseData(
                      level: "0",
                      tag: null,
                      deviceName: "Manual",
                      time: (DateTime.now()).millisecondsSinceEpoch,
                      device: 1,
                      manual: true,
                      note: "")),
          child: Consumer<BgTaggerVm>(
            builder: (_, value, __) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: SingleChildScrollView(
                  child: Column(
                    key: Key('bgTagger'),
                    children: [
                      value.data.tag == 3 || value.data.tag == null
                          ? getSquareBg(value)
                          : getCircleBg(value),
                      getDateTimePicker(
                          context, value.date, value.onChangeDate),
                      getTagState(value.data.tag, value.changeTag),
                      getImage(value),
                      getNote(value.noteController),
                      getAction(value.leftAction, value.rightAction)
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
        height: 130 * value.context.TEXTSCALE,
        width: 130 * value.context.TEXTSCALE,
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
      width: 130 * value.context.TEXTSCALE,
      height: 130 * value.context.TEXTSCALE,
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
          SizedBox(
            height: 12,
          ),
          Text(
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
        decoration: InputDecoration(
          counterText: '',
          errorStyle: TextStyle(height: 0),
        ),
        validator: (input) {
          if (input.isNotEmpty)
            return null;
          else
            return "";
        });
  } // InputSection #end

  // DateTimePickerSection #start
  Widget getDateTimePicker(
      BuildContext context, DateTime date, Function(DateTime) onChange) {
    return GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext builder) {
                return Container(
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
          padding: EdgeInsets.only(bottom: 16, top: 16),
          child: Card(
            color: R.color.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 4,
            child: Container(
                padding:
                    EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
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
          child: Text("${UtilityManager().getReadableDate(date)}"),
        ),
        Expanded(
          child: Text("${UtilityManager().getReadableHour(date)}"),
        )
      ],
    );
  } // DateTimePickerSection #end

  // TagSection #begin
  Wrap getTagState(int currentTag, Function(int) changeTag) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () => changeTag(1),
          child: getTagElement(
            currentTag == 1,
            R.image.beforemeal_icon_black,
            LocaleProvider.current.hungry,
          ),
        ),
        GestureDetector(
          onTap: () => changeTag(2),
          child: getTagElement(
            currentTag == 2,
            R.image.aftermeal_icon_black,
            LocaleProvider.current.full,
          ),
        ),
        GestureDetector(
          onTap: () => changeTag(3),
          child: getTagElement(
            currentTag == null || currentTag == 3,
            R.image.other_icon,
            LocaleProvider.current.other,
          ),
        ),
      ],
    );
  }

  Card getTagElement(bool isCurrent, String icon, String title) {
    return Card(
      color: isCurrent ? R.color.btnDarkBlue : R.color.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      elevation: 4,
      child: Container(
        decoration: getTagElementDeco(isCurrent),
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
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
      gradient: LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
        colors: isCurrent
            ? <Color>[R.color.btnLightBlue, R.color.btnDarkBlue]
            : <Color>[Colors.white, Colors.white],
      ),
    );
  } // TagSection #end

  // ImageSection #begin
  GestureDetector getImage(BgTaggerVm value) {
    return GestureDetector(
        onTap: () {
          takeImage(value.context, value);
        },
        child: Padding(
            padding: EdgeInsets.only(left: 8, top: 16),
            child: Row(
              children: <Widget>[
                Container(
                    width: 60,
                    height: 60,
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        height: 25,
                        width: 25,
                        child: value.data.imageURL == "" || Atom.isWeb
                            ? SvgPicture.asset(
                                R.image.addphoto_icon,
                              )
                            : PhotoView(
                                imageProvider: FileImage(File(
                                    getIt<GlucoseStorageImpl>()
                                        .getImagePathOfImageURL(
                                            value.data.imageURL))),
                              ),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(LocaleProvider.current.add_photo)),
              ],
            )));
  }

  takeImage(BuildContext context, BgTaggerVm value) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        String title = LocaleProvider.current.how_to_get_photo;
        return Platform.isIOS
            ? new CupertinoAlertDialog(
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
            : new AlertDialog(
                title: Text(
                  title,
                  style: TextStyle(fontSize: 22),
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
              );
      },
    );
  }
// ImageSection #end

  // NoteSection #begin
  Container getNote(TextEditingController controller) {
    return Container(
      padding: EdgeInsets.only(top: 16),
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
            border: UnderlineInputBorder(),
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
          gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: isSave
                  ? <Color>[R.color.btnLightBlue, R.color.btnDarkBlue]
                  : <Color>[R.color.white, R.color.white]),
        ),
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
}
