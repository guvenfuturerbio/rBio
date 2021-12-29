import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/core.dart';
import '../../../../progress_sections/scale_progress/view_model/scale_progress_page_view_model.dart';
import '../../../../utils/selected_scale_type.dart';
import 'scale_filter_pop_up_vm.dart';

class ScaleChartFilterPopup extends StatelessWidget {
  final double width;
  final double height;
  final bool isDoctor;
  final SelectedScaleType selected;
  final Function(SelectedScaleType) changeScaleType;
  const ScaleChartFilterPopup(
      {Key key,
      @required this.width,
      @required this.height,
      this.isDoctor = false,
      this.selected,
      this.changeScaleType})
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
                    scaleType: isDoctor
                        ? selected
                        : Provider.of<ScaleProgressPageViewModel>(context,
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
                                Atom.dismiss();
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
                                if (isDoctor) {
                                  changeScaleType(value.selectedScaleType);
                                } else {
                                  Provider.of<ScaleProgressPageViewModel>(
                                          context,
                                          listen: false)
                                      .changeScaleType(value.selectedScaleType);
                                }
                                Atom.dismiss();
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
                                          R.color.btnLightBlue,
                                          R.color.btnDarkBlue
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
}
