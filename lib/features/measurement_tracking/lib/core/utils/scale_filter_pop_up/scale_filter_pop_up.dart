import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/core/services/enum/selected_scale_type.dart';
import 'package:provider/provider.dart';

import '../../../extension/size_extension.dart';
import '../../../generated/l10n.dart';
import '../../../helper/resources.dart';
import '../../../pages/progress_pages/scale_progress_page/scale_progress_page_view_model.dart';
import 'scale_filter_pop_up_vm.dart';

class ScaleChartFilterPopup extends StatelessWidget {
  final double width;
  final double height;
  const ScaleChartFilterPopup(
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
            width: width,
            child: Card(
              color: R.color.bg_gray,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: ChangeNotifierProvider(
                create: (_) => ScaleFilterPopupVm(
                    scaleType: Provider.of<ScaleProgressPageViewModel>(context,
                            listen: false)
                        .currentScaleType),
                child: Consumer<ScaleFilterPopupVm>(
                  builder: (_, value, __) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: context.HEIGHT * .01),
                          child: ListView(shrinkWrap: true, children: [
                            ...value.filterList
                                .map((e) => RadioListTile<SelectedScaleType>(
                                      title: Text(e.toStr),
                                      value: e,
                                      groupValue: value.selectedScaleType,
                                      onChanged: (SelectedScaleType type) =>
                                          value.changeScaleType(type),
                                      dense: true,
                                    ))
                          ]),
                        ),
                        Wrap(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
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
                                  child: Text(
                                    LocaleProvider.current.cancel,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Provider.of<ScaleProgressPageViewModel>(context,
                                        listen: false)
                                    .changeScaleType(value.selectedScaleType);
                                Navigator.of(context).pop('dialog');
                              },
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
                                          R.btnLightBlue,
                                          R.btnDarkBlue
                                        ]),
                                  ),
                                  padding: EdgeInsets.only(
                                      left: 16, right: 16, top: 10, bottom: 10),
                                  child: Text(
                                    LocaleProvider.current.save,
                                    style: TextStyle(color: R.color.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
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
