import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/core.dart';
import '../../viewmodel/scale_progress_vm.dart';
import '../../../../utils/selected_scale_type.dart';
import 'scale_filter_pop_up_vm.dart';

class ScaleChartFilterPopup extends StatelessWidget {
  final double width;
  final double height;
  final bool isDoctor;
  final SelectedScaleType? selected;
  final Function(SelectedScaleType) changeScaleType;
  const ScaleChartFilterPopup({
    Key? key,
    required this.changeScaleType,
    required this.width,
    required this.height,
    this.isDoctor = false,
    this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(10),
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width * .03),
          child: SizedBox(
            width: width,
            child: Card(
              elevation: R.sizes.defaultElevation,
              color: R.color.bg_gray,
              shape: RoundedRectangleBorder(
                borderRadius: R.sizes.borderRadiusCircular,
              ),
              child: ChangeNotifierProvider(
                create: (_) => ScaleFilterPopupVm(
                  scaleType: isDoctor
                      ? selected
                      : Provider.of<ScaleProgressVm>(context,
                              listen: false)
                          .currentScaleType,
                ),
                child: Consumer<ScaleFilterPopupVm>(
                  builder: (_, value, __) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: context.height * .01),
                          child: ListView(shrinkWrap: true, children: [
                            ...value.filterList
                                .map((e) => RadioListTile<SelectedScaleType>(
                                      title: Text(e.toStr),
                                      value: e,
                                      groupValue: value.selectedScaleType,
                                      onChanged: (SelectedScaleType? type) =>
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
                                elevation: R.sizes.defaultElevation,
                                shape: RoundedRectangleBorder(
                                  borderRadius: R.sizes.borderRadiusCircular,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: R.sizes.borderRadiusCircular,
                                    gradient: LinearGradient(
                                        begin: Alignment.bottomRight,
                                        end: Alignment.topLeft,
                                        colors: <Color>[
                                          R.color.white,
                                          R.color.white
                                        ]),
                                  ),
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16, top: 10, bottom: 10),
                                  child: Text(
                                    LocaleProvider.current.cancel,
                                    style: const TextStyle(
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
                                  Provider.of<ScaleProgressVm>(
                                          context,
                                          listen: false)
                                      .changeScaleType(value.selectedScaleType);
                                }
                                Atom.dismiss();
                              },
                              child: Card(
                                elevation: R.sizes.defaultElevation,
                                shape: RoundedRectangleBorder(
                                  borderRadius: R.sizes.borderRadiusCircular,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: R.sizes.borderRadiusCircular,
                                    gradient: LinearGradient(
                                        begin: Alignment.bottomRight,
                                        end: Alignment.topLeft,
                                        colors: <Color>[
                                          R.color.btnLightBlue,
                                          R.color.btnDarkBlue
                                        ]),
                                  ),
                                  padding: const EdgeInsets.only(
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
