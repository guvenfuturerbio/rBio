import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../../../generated/l10n.dart';
import '../../lib/widgets/utils/glucose_margins_filter.dart';
import '../glucose_progress/view_model/bg_progress_page_view_model.dart';

class BGChartFilterPopUp extends StatelessWidget {
  final double width;
  final double height;
  const BGChartFilterPopUp(
      {Key key, @required this.width, @required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(10),
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.WIDTH * .03),
          child: SizedBox(
            height: height * context.TEXTSCALE,
            width: width * context.TEXTSCALE,
            child: Card(
              color: R.color.bg_gray,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Consumer<BgProgressPageViewModel>(
                builder: (_, value, __) => ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: context.HEIGHT * .01),
                      child: SingleChildScrollView(
                        child: Column(
                          children: value.colorInfo.keys
                              .map((color) => _colorFilterItem(
                                  text: value.colorInfo[color].toShortString(),
                                  status: value
                                      .isFilterSelected(value.colorInfo[color]),
                                  color: color,
                                  size: 15,
                                  statCallback: (_) => value
                                      .setFilterState(value.colorInfo[color]),
                                  isHungry: false))
                              .toList(),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: context.HEIGHT * .01),
                      child: SingleChildScrollView(
                        child: Column(
                          children: value.states
                              .map((state) => _colorFilterItem(
                                  text: state.toShortString(),
                                  status: value.isFilterSelected(state),
                                  color: R.color.state_color,
                                  size: 15,
                                  style: state == GlucoseMarginsFilter.FULL ||
                                          state == GlucoseMarginsFilter.HUNGRY
                                      ? BoxShape.circle
                                      : BoxShape.rectangle,
                                  statCallback: (_) =>
                                      value.setFilterState(state),
                                  isHungry:
                                      state == GlucoseMarginsFilter.HUNGRY))
                              .toList(),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            value.cancelSelections();
                            Navigator.of(context).pop();
                          },
                          child: SizedBox(
                            width: context.WIDTH / 4,
                            child: Card(
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
                                      colors: <Color>[
                                        R.color.white,
                                        R.color.white
                                      ]),
                                ),
                                padding: EdgeInsets.only(
                                    left: 16, right: 16, top: 10, bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    /*Container(
                                                  height: 24,
                                                  child: SvgPicture.asset(
                                                      R.image.power_icon),
                                                ),*/
                                    Center(
                                      child: Text(
                                        LocaleProvider.current.cancel,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: MediaQuery.of(context)
                                                    .textScaleFactor *
                                                17),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            value.updateFilterState();
                            Navigator.of(context).pop();
                          },
                          child: SizedBox(
                            width: context.WIDTH / 4,
                            child: Card(
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
                                      colors: <Color>[
                                        R.color.btnLightBlue,
                                        R.color.btnDarkBlue
                                      ]),
                                ),
                                padding: EdgeInsets.only(
                                    left: 16, right: 16, top: 10, bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    /*Container(
                                                  height: 24,
                                                  child: SvgPicture.asset(
                                                      R.image.power_icon),
                                                ),*/
                                    Center(
                                      child: Text(
                                        LocaleProvider.current.save,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: MediaQuery.of(context)
                                                    .textScaleFactor *
                                                17),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                        onPressed: () => value.resetFilterValues(),
                        child: Text(
                            '${LocaleProvider.current.reset_filter_value}',
                            style: TextStyle(
                                decoration: TextDecoration.underline)))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding _colorFilterItem(
      {double size,
      String text,
      Color color,
      bool status,
      BoxShape style,
      Function(bool) statCallback,
      bool isHungry}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25),
            height: size,
            width: size,
            decoration: BoxDecoration(
              shape: style ?? BoxShape.circle,
              color: isHungry ? Colors.transparent : color,
              border: Border.all(
                color: color,
                width: 2.0,
              ),
            ),
          ),
          Expanded(flex: 2, child: Text('$text')),
          //TODO: will be change to Sinem's design
          Expanded(
              child: SizedBox(
                  height: size,
                  width: size,
                  child: Checkbox(value: status, onChanged: statCallback)))
        ],
      ),
    );
  }
}
