import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/core.dart';
import '../../../../../../core/enums/selected_scale_type.dart';
import '../../viewmodel/scale_progress_vm.dart';
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
    return Dialog(
      elevation: R.sizes.defaultElevation,
      backgroundColor: context.scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: R.sizes.borderRadiusCircular,
      ),
      child: ChangeNotifierProvider(
        create: (_) => ScaleFilterPopupVm(
          scaleType: isDoctor
              ? selected
              : Provider.of<ScaleProgressVm>(context, listen: false)
                  .currentScaleType,
        ),
        child: _buildConsumer(),
      ),
    );
  }

  Widget _buildConsumer() {
    return Consumer<ScaleFilterPopupVm>(
      builder: (BuildContext context, ScaleFilterPopupVm vm, Widget? child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            R.sizes.hSizer8,

            //
            ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              children: [
                ...vm.filterList.map(
                  (e) => RadioListTile<SelectedScaleType>(
                    title: Text(e.toStr),
                    value: e,
                    groupValue: vm.selectedScaleType,
                    onChanged: (SelectedScaleType? type) =>
                        vm.changeScaleType(type),
                    dense: true,
                    activeColor: getIt<ITheme>().mainColor,
                  ),
                ),
              ],
            ),

            //
            Wrap(
              children: [
                //
                RbioElevatedButton(
                  title: LocaleProvider.current.cancel,
                  onTap: () {
                    Atom.dismiss();
                  },
                  padding: EdgeInsets.zero,
                  backColor: getIt<ITheme>().cardBackgroundColor,
                  textColor: getIt<ITheme>().textColorSecondary,
                  showElevation: false,
                ),

                //
                R.sizes.wSizer8,

                //
                RbioElevatedButton(
                  title: LocaleProvider.current.save,
                  onTap: () {
                    if (isDoctor) {
                      changeScaleType(vm.selectedScaleType);
                    } else {
                      Provider.of<ScaleProgressVm>(context, listen: false)
                          .changeScaleType(vm.selectedScaleType);
                    }
                    Atom.dismiss();
                  },
                  padding: EdgeInsets.zero,
                  showElevation: false,
                ),
              ],
            ),

            //
            R.sizes.hSizer8,
          ],
        );
      },
    );
  }
}
