import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/core.dart';
import 'bg_tagger_vm.dart';

class BgTaggerPopUp extends StatelessWidget {
  final GlucoseData? data;
  final bool isEdit;

  const BgTaggerPopUp({
    Key? key,
    this.data,
    this.isEdit = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BgTaggerVm(
        key: data?.key,
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
                note: "",
              ),
      ),
      child: RbioDarkStatusBar(
        child: KeyboardDismissOnTap(
          child: _buildConsumer(),
        ),
      ),
    );
  }

  Widget _buildConsumer() {
    return Consumer<BgTaggerVm>(
      builder: (BuildContext context, BgTaggerVm vm, Widget? child) {
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
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.only(
                      top: 8,
                      left: 8,
                      right: 8,
                      bottom: context.xMediaQuery.viewInsets.bottom,
                    ),
                    child: Column(
                      children: [
                        vm.data.tag == 3 || vm.data.tag == null
                            ? _buildSquareBg(context, vm)
                            : _buildCircleBg(context, vm),
                        _buildDateTimeSection(
                            context, vm.date, vm.onChangeDate),
                        _buildTags(context, vm.data.tag, vm.changeTag),
                        _buildImageSection(context, vm),
                        _buildNoteSection(context, vm.noteController),
                      ],
                    ),
                  ),
                ),
              ),

              //
              R.sizes.hSizer8,

              //
              _buildActions(
                vm.leftAction,
                isEdit ? vm.update : vm.rightAction,
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

  // #region _buildSquareBg
  Widget _buildSquareBg(BuildContext context, BgTaggerVm value) {
    return Container(
      height: 130 * value.context.textScale,
      width: 130 * value.context.textScale,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: UtilityManager()
            .getGlucoseMeasurementColor(int.parse(value.data.level)),
        border: Border.all(
          color: UtilityManager().getGlucoseMeasurementColor(
            int.parse(
              value.data.level,
            ),
          ),
          width: 5.0,
        ),
      ),
      child: _buildInsideSection(context, value, true),
    );
  }
  // #endregion

  // #region _buildCircleBg
  Widget _buildCircleBg(BuildContext context, BgTaggerVm value) {
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
          color: UtilityManager().getGlucoseMeasurementColor(
            int.parse(value.data.level),
          ),
          width: 10.0,
        ),
      ),
      child: _buildInsideSection(context, value, value.data.tag == 2),
    );
  }
  // #endregion

  // #region _buildInsideSection
  Widget _buildInsideSection(
    BuildContext context,
    BgTaggerVm value,
    bool isFill,
  ) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: TextFormField(
                enabled: data?.manual ?? true,
                controller: value.controller,
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
                onChanged: value.onChanged,
                decoration: const InputDecoration(
                  counterText: '',
                  errorStyle: TextStyle(height: 0),
                ),
              ),
            ),
          ),

          //
          R.sizes.hSizer12,

          //
          Text(
            "mg/dL",
            style: context.xHeadline5,
          ),
        ],
      ),
    );
  }
  // #endregion

  // #region _buildDateTimeSection
  Widget _buildDateTimeSection(
    BuildContext context,
    DateTime date,
    Function(DateTime) onChange,
  ) {
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
              ),
            );
          },
        );
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
                    UtilityManager().getReadableDate(date),
                    style: context.xHeadline4,
                  ),
                ),
                Text(
                  UtilityManager().getReadableHour(date),
                  style: context.xHeadline4,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  // #endregion

  // #region _buildTags
  Widget _buildTags(
      BuildContext context, int? currentTag, Function(int) changeTag) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () => changeTag(1),
          child: _buildTagItem(
            context,
            currentTag == 1,
            R.image.beforeMealIconBlack,
            LocaleProvider.current.hungry,
          ),
        ),
        GestureDetector(
          onTap: () => changeTag(2),
          child: _buildTagItem(
            context,
            currentTag == 2,
            R.image.aftermealIconBlack,
            LocaleProvider.current.full,
          ),
        ),
        GestureDetector(
          onTap: () => changeTag(3),
          child: _buildTagItem(
            context,
            currentTag == null || currentTag == 3,
            R.image.otherIcon,
            LocaleProvider.current.other,
          ),
        ),
      ],
    );
  }
  // #endregion

  // #region _buildTagItem
  Widget _buildTagItem(
      BuildContext context, bool isCurrent, String icon, String title) {
    return Card(
      elevation: R.sizes.defaultElevation,
      color: isCurrent
          ? getIt<ITheme>().mainColor
          : getIt<ITheme>().cardBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: R.sizes.borderRadiusCircular,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 10,
          bottom: 10,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            //
            SizedBox(
              height: 20,
              width: 20,
              child: SvgPicture.asset(
                icon,
                color: isCurrent ? Colors.white : Colors.black,
              ),
            ),

            //
            Text(
              title,
              textAlign: TextAlign.left,
              style: context.xHeadline5.copyWith(
                color: isCurrent ? Colors.white : Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
  // #endregion

  // #region _buildImageSection
  Widget _buildImageSection(BuildContext context, BgTaggerVm value) {
    return GestureDetector(
      onTap: () {
        takeImage(value.context, value);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8, top: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            //
            SizedBox(
              width: 60,
              height: 60,
              child: Card(
                elevation: R.sizes.defaultElevation,
                shape: RoundedRectangleBorder(
                  borderRadius: R.sizes.borderRadiusCircular,
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
                          imageProvider: FileImage(
                            File(
                              getIt<GlucoseStorageImpl>()
                                  .getImagePathOfImageURL(value.data.imageURL!),
                            ),
                          ),
                        ),
                ),
              ),
            ),

            //
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  LocaleProvider.current.add_photo,
                  style: context.xHeadline4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  // #endregion

  // #region takeImage
  Future<void> takeImage(BuildContext context, BgTaggerVm value) async {
    String title = LocaleProvider.current.how_to_get_photo;

    Atom.show(
      Platform.isIOS
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
            ),
    );
  }
  // #endregion

  // #region _buildNoteSection
  Widget _buildNoteSection(
      BuildContext context, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Card(
        elevation: R.sizes.defaultElevation,
        shape: RoundedRectangleBorder(
          borderRadius: R.sizes.borderRadiusCircular,
        ),
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

        //
        R.sizes.wSizer8,

        //
        _buildActionButton(
          isSave: true,
          onTap: rightButtonAction,
        ),
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
      backColor: isSave ? null : getIt<ITheme>().cardBackgroundColor,
      textColor: isSave ? null : getIt<ITheme>().textColorSecondary,
    );
  }
  // #endregion
}
