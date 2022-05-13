import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../../../../../core/data/service/model/patient_scale_measurement.dart';

class ScaleTagger extends StatelessWidget {
  final PatientScaleMeasurement scaleModel;
  final ScrollController scrollController = ScrollController();

  ScaleTagger({
    Key? key,
    required this.scaleModel,
  }) : super(key: key);

  BoxDecoration boxDeco(int index, int gridViewCrossAxisCount) {
    return BoxDecoration(
      border: Border(
        left: BorderSide(
          color:
              index.isEven ? Colors.black.withOpacity(.04) : Colors.transparent,
          width: 1.5,
        ),
        top: BorderSide(
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
                    _itemOfColorInfoDialog(context, getIt<IAppConfig>().theme.veryLow,
                        LocaleProvider.current.very_low),
                    _itemOfColorInfoDialog(
                        context, getIt<IAppConfig>().theme.low, LocaleProvider.current.low),
                    _itemOfColorInfoDialog(
                        context, getIt<IAppConfig>().theme.target, LocaleProvider.current.target),
                    _itemOfColorInfoDialog(
                        context, getIt<IAppConfig>().theme.high, LocaleProvider.current.high),
                    _itemOfColorInfoDialog(context, getIt<IAppConfig>().theme.veryHigh,
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
            borderRadius: R.sizes.borderRadiusCircular,
            color: getIt<IAppConfig>().theme.mainColor),
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
          color: getIt<IAppConfig>().theme.white,
          shape: RoundedRectangleBorder(
            borderRadius: R.sizes.borderRadiusCircular,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                SizedBox(width: double.infinity, child: Text(scaleModel.note!)),
          )),
    );
  }

  Padding _dateTimeSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, top: 16),
      child: Card(
        elevation: R.sizes.defaultElevation,
        color: getIt<IAppConfig>().theme.white,
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
                Text(UtilityManager().getReadableDate(
                    DateTime.parse(scaleModel.occurrenceTime!))),
                Text(UtilityManager().getReadableHour(
                    DateTime.parse(scaleModel.occurrenceTime!)))
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
        measurement:
            scaleModel.bmi == null ? null : scaleModel.bmi!.toStringAsFixed(2),
        name: LocaleProvider.current.scale_data_bmi,
        type: '',
        index: 1,
        crossAxisCount: 1,
        context: context,
      ),
      scaleSection(
        measurement: scaleModel.bmi == null
            ? null
            : scaleModel.bodyFat?.toStringAsFixed(2),
        name: LocaleProvider.current.scale_data_body_fat,
        type: '%',
        index: 2,
        crossAxisCount: 1,
        context: context,
      ),
      scaleSection(
        measurement: scaleModel.boneMass == null
            ? null
            : scaleModel.boneMass!.toStringAsFixed(2),
        name: LocaleProvider.current.scale_data_bone_mass,
        type: scaleModel.scaleUnit!.getScaleUnit(),
        index: 3,
        crossAxisCount: 2,
        context: context,
      ),
      scaleSection(
        name: LocaleProvider.current.scale_data_muscle,
        measurement: scaleModel.muscle == null
            ? null
            : scaleModel.muscle!.toStringAsFixed(2),
        type: '%',
        index: 4,
        crossAxisCount: 2,
        context: context,
      ),
      scaleSection(
        measurement: scaleModel.visceralFat == null
            ? null
            : scaleModel.visceralFat!.toStringAsFixed(2),
        name: LocaleProvider.current.scale_data_visceral_fat,
        type: '',
        index: 5,
        crossAxisCount: 3,
        context: context,
      ),
      scaleSection(
        measurement: scaleModel.water == null
            ? null
            : scaleModel.water!.toStringAsFixed(2),
        name: LocaleProvider.current.scale_data_water,
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
                ),
                shape: BoxShape.circle,
                color: getIt<IAppConfig>().theme.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _inputSection(
                    measurement: scaleModel.weight.toString(),
                    context: context,
                  ),
                  //
                  Text(
                    scaleModel.scaleUnit!.getScaleUnit(),
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

  Theme _inputSection({String? measurement, required BuildContext context}) {
    return Theme(
        data: ThemeData(primaryColor: Colors.black),
        child: Text(
          measurement ?? '',
          style: context.xHeadline2,
        ));
  }

  scaleSection({
    required BuildContext context,
    String? measurement,
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
                  borderRadius: R.sizes.borderRadiusCircular,
                  border: Border.all(
                      width: 6, color: color ?? getIt<IAppConfig>().theme.grey.withOpacity(.2)),
                  shape: BoxShape.rectangle,
                  color: getIt<IAppConfig>().theme.white),
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
