import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../../../../core/core.dart';
import '../../../chronic_tracking/progress_sections/scale/viewmodel/scale_measurement_vm.dart';
import '../../../../core/enums/selected_scale_type.dart';

class ScaleTagger extends StatelessWidget {
  final ScaleMeasurementViewModel scaleModel;
  ScaleTagger({Key? key, required this.scaleModel}) : super(key: key);
  final ScrollController scrollController = ScrollController();

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
            child: GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: Card(
                  elevation: R.sizes.defaultElevation,
                  color: context.scaffoldBackgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: R.sizes.borderRadiusCircular,
                  ),
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
                            controller: scrollController,
                            child: Column(
                              children: [
                                weightInputSection(context),
                                _dateTimeSection(context),
                                otherBodyParameterMeasurementSection(context),
                                // _imageSection( context),
                                _noteSection(context),
                              ],
                            ),
                          ),
                        ),
                      ),
                      getAction(Atom.dismiss, context)
                    ],
                  ),
                )),
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

  getAction(VoidCallback leftButtonAction, BuildContext context) {
    return Wrap(
      children: [
        GestureDetector(
            onTap: leftButtonAction, child: actionButton(false, context)),
      ],
    );
  }

  Widget actionButton(bool isSave, BuildContext context) {
    return Card(
      elevation: R.sizes.defaultElevation,
      shape: RoundedRectangleBorder(
        borderRadius: R.sizes.borderRadiusCircular,
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: getIt<ITheme>().mainColor),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Text(
          LocaleProvider.current.done,
          style: context.xButton.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Container _noteSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: Card(
          elevation: R.sizes.defaultElevation,
          color: R.color.white,
          shape: RoundedRectangleBorder(
            borderRadius: R.sizes.borderRadiusCircular,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                SizedBox(width: double.infinity, child: Text(scaleModel.note)),
          )),
    );
  }

  Padding _dateTimeSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, top: 16),
      child: Card(
        elevation: R.sizes.defaultElevation,
        color: R.color.white,
        shape: RoundedRectangleBorder(
          borderRadius: R.sizes.borderRadiusCircular,
        ),
        child: Container(
            width: double.infinity,
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(UtilityManager().getReadableDate(scaleModel.dateTime)),
                Text(UtilityManager().getReadableHour(scaleModel.dateTime))
              ],
            )),
      ),
    );
  }

  GridView otherBodyParameterMeasurementSection(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 5 / 4,
      padding: const EdgeInsets.all(15),
      children: _sectionItems(context),
    );
  }

  List<Widget> _sectionItems(BuildContext context) {
    return [
      scaleSection(
        measurement: scaleModel.bmi,
        name: LocaleProvider.current.scale_data_bmi,
        color: scaleModel.getColor(SelectedScaleType.bmi),
        type: '',
        index: 1,
        crossAxisCount: 1,
        context: context,
      ),
      scaleSection(
        measurement: scaleModel.bodyFat,
        name: LocaleProvider.current.scale_data_body_fat,
        color: scaleModel.getColor(SelectedScaleType.bodyFat),
        type: '%',
        index: 2,
        crossAxisCount: 1,
        context: context,
      ),
      scaleSection(
        measurement: scaleModel.boneMass,
        name: LocaleProvider.current.scale_data_bone_mass,
        color: scaleModel.getColor(SelectedScaleType.boneMass),
        type: '${scaleModel.scaleModel.unit ?? ScaleUnit.kg.toStr}',
        index: 3,
        crossAxisCount: 2,
        context: context,
      ),
      scaleSection(
        name: LocaleProvider.current.scale_data_muscle,
        measurement: scaleModel.muscle,
        color: scaleModel.getColor(SelectedScaleType.muscle),
        type: '%',
        index: 4,
        crossAxisCount: 2,
        context: context,
      ),
      scaleSection(
        measurement: scaleModel.visceralFat,
        name: LocaleProvider.current.scale_data_visceral_fat,
        color: scaleModel.getColor(SelectedScaleType.visceralFat),
        type: '',
        index: 5,
        crossAxisCount: 3,
        context: context,
      ),
      scaleSection(
        measurement: scaleModel.water,
        name: LocaleProvider.current.scale_data_water,
        color: scaleModel.getColor(SelectedScaleType.water),
        type: '%',
        index: 6,
        crossAxisCount: 3,
        context: context,
      ),
    ];
  }

  SizedBox weightInputSection(BuildContext context) {
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
                  color: scaleModel.getColor(
                    SelectedScaleType.weight,
                  ),
                ),
                shape: BoxShape.circle,
                color: R.color.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _inputSection(
                    measurement: scaleModel.weight!,
                    context: context,
                  ),

                  //
                  Text(
                    scaleModel.unit.toStr,
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

  Theme _inputSection({double? measurement, required BuildContext context}) {
    return Theme(
        data: ThemeData(primaryColor: Colors.black),
        child: Text(
          '${measurement ?? ''}',
          style: context.xHeadline2,
        ));
  }

  scaleSection({
    required BuildContext context,
    double? measurement,
    required String name,
    Color? color,
    required String type,
    required int index,
    required int crossAxisCount,
  }) {
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
                  border: Border.all(
                      width: 6, color: color ?? R.color.grey.withOpacity(.2)),
                  shape: BoxShape.rectangle,
                  color: R.color.white),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _inputSection(
                    context: context,
                    measurement: measurement,
                  )),
            ),
          ),
          Expanded(child: Center(child: Text(type)))
        ],
      ),
    );
  }
}
