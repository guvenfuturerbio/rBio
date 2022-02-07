import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/core.dart';
import '../../../../utils/gallery_pop_up/gallery_pop_up.dart';
import '../../../../utils/selected_scale_type.dart';
import '../scale_measurements/scale_measurement_vm.dart';
import 'scale_tagger_vm.dart';

class ScaleTagger extends StatelessWidget {
  final ScaleModel? scaleModel;
  final bool isUpdate;
  const ScaleTagger({Key? key, this.scaleModel, this.isUpdate = false})
      : super(key: key);

  BoxDecoration boxDeco(int index, int gridViewCrossAxisCount) {
    return BoxDecoration(
      border: Border(
        left: BorderSide(
          //                   <--- left side
          color:
              index.isEven ? Colors.black.withOpacity(.04) : Colors.transparent,
          width: 1.5,
        ),
        top: BorderSide(
          //                   <--- top side
          color: gridViewCrossAxisCount != 1
              ? Colors.black.withOpacity(.04)
              : Colors.transparent,
          width: 1.5,
        ),
      ),
    );
  }

  static double height = 0;
  static double width = 0;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (_, orientation) {
        if (orientation == Orientation.landscape) {
          height = context.width;
          width = context.height;
        } else {
          height = context.height;
          width = context.width;
        }
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: ChangeNotifierProvider(
              create: (_) => ScaleTaggerVm(
                  context: context,
                  scaleModel: scaleModel == null
                      ? null
                      : ScaleMeasurementViewModel(
                          scaleModel: scaleModel!.copy()),
                  isManuel: scaleModel == null,
                  key: scaleModel?.key),
              child: GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: Consumer<ScaleTaggerVm>(
                  builder: (_, value, __) {
                    return Card(
                      color: R.color.background,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: height * .03,
                                right: width * .02,
                                left: width * .02,
                              ),
                              child: SingleChildScrollView(
                                controller: value.scrollController,
                                child: Column(
                                  children: [
                                    weightInputSection(value, context),
                                    _dateTimeSection(context, value),
                                    otherBodyParameterMeasurementSection(value),
                                    _imageSection(value, context),
                                    _noteSection(value, context),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          getAction(Atom.dismiss,
                              isUpdate ? value.update : value.save)
                        ],
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

  GestureDetector _infoButton(BuildContext context) {
    // Don't Touch this show dialog this workin fine!!!!
    return GestureDetector(
      onTap: () => showDialog(
          context: context,
          barrierColor: Colors.transparent,
          builder: (_) => BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Dialog(
                    child: ListView(
                  shrinkWrap: true,
                  children: [
                    _itemOfColorInfoDialog(context, R.color.very_low,
                        LocaleProvider.current.very_low),
                    _itemOfColorInfoDialog(
                        context, R.color.low, LocaleProvider.current.low),
                    _itemOfColorInfoDialog(
                        context, R.color.target, LocaleProvider.current.target),
                    _itemOfColorInfoDialog(
                        context, R.color.high, LocaleProvider.current.high),
                    _itemOfColorInfoDialog(context, R.color.very_high,
                        LocaleProvider.current.very_high),
                  ],
                )),
              )),
      child: Icon(
        Icons.info,
        size: 40 * context.textScale,
      ),
    );
  }

  Row _itemOfColorInfoDialog(BuildContext context, Color color, String title) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: Container(
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            height: 18 * context.textScale,
            width: 18 * context.textScale,
          ),
        ),
        Expanded(child: Text(title))
      ],
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

  Widget _imageSection(ScaleTaggerVm value, BuildContext context) {
    return SizedBox(
      height: height * .1,
      child: Row(
        children: [
          ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: value.scaleModel?.images.length == 3
                ? 3
                : value.scaleModel!.images.length + 1,
            itemBuilder: (_, index) => Stack(
              children: [
                SizedBox(
                    width: height * .1,
                    height: height * .1,
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: SizedBox(
                        height: height * .1,
                        width: height * .1,
                        child: value.scaleModel!.images.isEmpty ||
                                index >= value.scaleModel!.images.length
                            ? GestureDetector(
                                onTap: () {
                                  value.getImage(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.asset(
                                    R.image.addphotoIcon,
                                  ),
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: GestureDetector(
                                  onTap: () => _galeryView(context, value),
                                  child: Image(
                                    image: FileImage(File(
                                        getIt<ScaleStorageImpl>()
                                            .getImagePathOfImageURL(value
                                                .scaleModel!.images[index]))),
                                  ),
                                ),
                              ),
                      ),
                    )),
                Visibility(
                  visible: !(value.scaleModel!.images.isEmpty ||
                      index >= value.scaleModel!.images.length),
                  child: Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => value.deleteImageFromIndex(index),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: R.color.very_low,
                        ),
                        height: height * .03,
                        width: height * .03,
                        child: Icon(
                          Icons.close,
                          size: height * .02,
                          color: R.color.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          if (value.scaleModel!.images.length < 3)
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(LocaleProvider.current.add_photo)),
            ),
        ],
      ),
    );
  }

  Future<dynamic> _galeryView(BuildContext context, ScaleTaggerVm value) {
    return showDialog(
        context: context,
        barrierColor: Colors.transparent,
        barrierDismissible: false,
        builder: (_) => GalleryView(images: [
              ...value.scaleModel!.images
                  .map((e) =>
                      getIt<ScaleStorageImpl>().getImagePathOfImageURL(e))
                  .toList()
            ]));
  }

  Container _noteSection(ScaleTaggerVm value, BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
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

  GestureDetector _dateTimeSection(BuildContext context, ScaleTaggerVm value) {
    return GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return SizedBox(
                    height: 260,
                    child: CupertinoDatePicker(
                      initialDateTime: DateTime.now(),
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
            color: R.color.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 4,
            child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(UtilityManager()
                        .getReadableDate(value.scaleModel!.dateTime)),
                    Text(UtilityManager()
                        .getReadableHour(value.scaleModel!.dateTime))
                  ],
                )),
          ),
        ));
  }

  GridView otherBodyParameterMeasurementSection(ScaleTaggerVm value) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 5 / 4,
      padding: const EdgeInsets.all(15),
      children: _sectionItems(value),
    );
  }

  List<Widget> _sectionItems(ScaleTaggerVm value) {
    return [
      scaleSection(
        controller: value.bmiController,
        name: LocaleProvider.current.scale_data_bmi,
        color: value.scaleModel!.getColor(SelectedScaleType.bmi),
        type: '',
        index: 1,
        isBmi: true,
        crossAxisCount: 1,
        onChanged: value.changeBmi,
      ),
      scaleSection(
        controller: value.bodyFatController,
        name: LocaleProvider.current.scale_data_body_fat,
        color: value.scaleModel!.getColor(SelectedScaleType.bodyFat),
        type: '%',
        index: 2,
        crossAxisCount: 1,
        onChanged: value.changeBodyFat,
      ),
      scaleSection(
        controller: value.boneMassController,
        name: LocaleProvider.current.scale_data_bone_mass,
        color: value.scaleModel!.getColor(SelectedScaleType.boneMass),
        type: '${value.scaleModel!.unit}',
        index: 3,
        crossAxisCount: 2,
        onChanged: value.changeBoneMass,
      ),
      scaleSection(
        name: LocaleProvider.current.scale_data_muscle,
        controller: value.muscleController,
        color: value.scaleModel!.getColor(SelectedScaleType.muscle),
        type: '%',
        index: 4,
        crossAxisCount: 2,
        onChanged: value.changeMuscle,
      ),
      scaleSection(
        controller: value.visceralController,
        name: LocaleProvider.current.scale_data_visceral_fat,
        color: value.scaleModel!.getColor(SelectedScaleType.visceralFat),
        type: '',
        index: 5,
        crossAxisCount: 3,
        onChanged: value.changeVisceral,
      ),
      scaleSection(
        controller: value.waterController,
        name: LocaleProvider.current.scale_data_water,
        color: value.scaleModel!.getColor(SelectedScaleType.water),
        type: '%',
        index: 6,
        crossAxisCount: 3,
        onChanged: value.changeWater,
      ),
    ];
  }

  SizedBox weightInputSection(ScaleTaggerVm value, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          Center(
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
                      offset: const Offset(3, 3))
                ],
                border: Border.all(
                  width: 13,
                  color: value.scaleModel!.getColor(
                    SelectedScaleType.weight,
                  ),
                ),
                shape: BoxShape.circle,
                color: isUpdate || scaleModel == null
                    ? R.color.white
                    : R.color.background,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _inputSection(value.weightController, validator: (input) {
                    if (input?.isNotEmpty ?? false) {
                      return "";
                    } else {
                      return "";
                    }
                  }, onChanged: value.changeWeight),
                  Text(
                    value.scaleModel!.unit.toStr,
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          _infoButton(context)
        ],
      ),
    );
  }

  Theme _inputSection(TextEditingController controller,
      {String Function(String?)? validator,
      required void Function(String) onChanged,
      bool isBmi = false}) {
    return Theme(
        data: ThemeData(primaryColor: Colors.black),
        child: TextFormField(
            enabled: !isBmi &&
                (scaleModel == null || (scaleModel?.isManuel ?? true)),
            style: const TextStyle(fontWeight: FontWeight.bold),
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
            validator: validator));
  }

  scaleSection(
      {required TextEditingController controller,
      required String name,
      required Color color,
      required String type,
      required int index,
      required int crossAxisCount,
      required void Function(String) onChanged,
      bool isBmi = false}) {
    return Container(
      decoration: boxDeco(index, crossAxisCount),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
              child: Center(
            child: Text(
              name,
            ),
          )),
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
                      : R.color.background),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _inputSection(
                    controller,
                    isBmi: isBmi,
                    onChanged: onChanged,
                  )),
            ),
          ),
          Expanded(child: Center(child: Text(type)))
        ],
      ),
    );
  }
}
