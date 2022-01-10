import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:onedosehealth/features/chronic_tracking/progress_sections/pressure_progress/view/pressure_progres_page.dart';
import 'package:provider/provider.dart';

import 'bp_chart_filter_pop_up_vm.dart';

class BpChartFilterPopUp extends StatelessWidget {
  final double width;
  final double height;
  final Map<String, bool> measurements;
  final Function(Map<String, bool>) callback;
  const BpChartFilterPopUp(
      {Key key, this.width, this.height, this.measurements, this.callback})
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
                create: (_) => BpChartFilterPopUpVm(
                    measurements: measurements ??
                        Provider.of<BpProgressPageVm>(context, listen: false)
                            .measurements),
                child: Consumer<BpChartFilterPopUpVm>(
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
                            ...value.measurements.keys
                                .map((key) => CheckboxListTile(
                                    value: value.measurements[key],
                                    activeColor: getIt<ITheme>().mainColor,
                                    title: Text(
                                      key,
                                      style: context.xHeadline2,
                                    ),
                                    onChanged: (_) => value.changeFilter(key)))
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
                                      color:
                                          getIt<ITheme>().cardBackgroundColor),
                                  padding: EdgeInsets.only(
                                      left: 16, right: 16, top: 10, bottom: 10),
                                  child: Text(
                                    LocaleProvider.current.cancel,
                                    style: context.xHeadline3,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (callback == null) {
                                  Provider.of<BpProgressPageVm>(context,
                                          listen: false)
                                      .changeFilterType(value.measurements);
                                } else {
                                  callback(value.measurements);
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
                                    color: getIt<ITheme>().mainColor,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  padding: EdgeInsets.only(
                                      left: 16, right: 16, top: 10, bottom: 10),
                                  child: Text(
                                    LocaleProvider.current.save,
                                    style: context.xHeadline3.copyWith(
                                        color: getIt<ITheme>()
                                            .cardBackgroundColor),
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
