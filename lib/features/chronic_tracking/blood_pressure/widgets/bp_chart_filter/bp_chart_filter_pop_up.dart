import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/core.dart';
import '../../viewmodel/bp_progres_vm.dart';
import 'bp_chart_filter_pop_up_vm.dart';

class BpChartFilterPopUp extends StatelessWidget {
  final double width;
  final Map<String, bool>? measurements;
  final Function(Map<String, bool>)? callback;

  const BpChartFilterPopUp({
    Key? key,
    this.measurements,
    this.callback,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: R.sizes.defaultElevation,
      backgroundColor: context.scaffoldBackgroundColor,
      shape: R.sizes.defaultShape,
      child: ChangeNotifierProvider(
        create: (_) => BpChartFilterPopUpVm(
          measurements: measurements ??
              Provider.of<BpProgressVm>(
                context,
                listen: false,
              ).measurements,
        ),
        child: _buildConsumer(),
      ),
    );
  }

  Widget _buildConsumer() {
    return Consumer<BpChartFilterPopUpVm>(
      builder: (BuildContext context, BpChartFilterPopUpVm vm, Widget? child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            R.widgets.hSizer8,

            //
            ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              children: [
                ...vm.measurements.keys.map(
                  (key) => CheckboxListTile(
                    title: Text(key, style: context.xHeadline5),
                    value: vm.measurements[key],
                    activeColor: context.xPrimaryColor,
                    dense: true,
                    onChanged: (_) => vm.changeFilter(key),
                  ),
                )
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
                  backColor: context.xCardColor,
                  textColor: context.xTextInverseColor,
                ),

                //
                R.widgets.wSizer8,

                //
                RbioElevatedButton(
                  title: LocaleProvider.current.save,
                  onTap: () {
                    if (callback == null) {
                      Provider.of<BpProgressVm>(context, listen: false)
                          .changeFilterType(vm.measurements);
                    } else {
                      callback!(vm.measurements);
                    }
                    Atom.dismiss();
                  },
                  padding: EdgeInsets.zero,
                ),
              ],
            ),

            //
            R.widgets.hSizer8,
          ],
        );
      },
    );
  }
}
