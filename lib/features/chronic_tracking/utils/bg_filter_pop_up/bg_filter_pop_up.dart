import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/core.dart';
import '../../progress_sections/blood_glucose/viewmodel/bg_progress_vm.dart';
import '../glucose_margins_filter.dart';
import 'bg_filter_pop_up_vm.dart';

class BgFilterPopUp extends StatelessWidget {
  final double width;
  final double height;

  const BgFilterPopUp({
    Key? key,
    required this.width,
    required this.height,
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
        create: (_) => BgFilterPopUpVm(
            filters:
                Provider.of<BgProgressVm>(context, listen: false).filterState),
        child: _buildConsumer(),
      ),
    );
  }

  Widget _buildConsumer() {
    return Consumer<BgFilterPopUpVm>(
      builder: (BuildContext context, BgFilterPopUpVm vm, Widget? child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            R.sizes.hSizer8,

            //
            ...vm.colorInfo.keys
                .map(
                  (color) => _colorFilterItem(
                    context: context,
                    text: vm.colorInfo[color]!.toShortString(),
                    status: vm.isFilterSelected(vm.colorInfo[color]!),
                    color: color,
                    statCallback: (_) => vm.changeFilter(vm.colorInfo[color]!),
                    isHungry: false,
                  ),
                )
                .toList(),

            //
            ...vm.states
                .map(
                  (state) => _colorFilterItem(
                    context: context,
                    text: state.toShortString(),
                    status: vm.isFilterSelected(state),
                    color: R.color.state_color,
                    style: state == GlucoseMarginsFilter.full ||
                            state == GlucoseMarginsFilter.hungry
                        ? BoxShape.circle
                        : BoxShape.rectangle,
                    statCallback: (_) => vm.changeFilter(state),
                    isHungry: state == GlucoseMarginsFilter.hungry,
                  ),
                )
                .toList(),

            //
            Wrap(
              children: [
                //
                RbioElevatedButton(
                  title: LocaleProvider.current.cancel,
                  onTap: () {
                    Provider.of<BgProgressVm>(context, listen: false)
                        .cancelSelections();
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
                    Provider.of<BgProgressVm>(context, listen: false)
                        .updateFilterState();
                    Atom.dismiss();
                  },
                  padding: EdgeInsets.zero,
                  showElevation: false,
                ),
              ],
            ),

            //
            RbioTextButton(
              onPressed: () {
                Provider.of<BgProgressVm>(context, listen: false)
                    .resetFilterValues();
                vm.resetFilterValues();
              },
              child: Text(
                LocaleProvider.current.reset_filter_value,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _colorFilterItem({
    required BuildContext context,
    required String text,
    required Color color,
    bool? status,
    BoxShape? style,
    Function(bool?)? statCallback,
    required bool isHungry,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          //
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            height: 16,
            width: 16,
            decoration: BoxDecoration(
              shape: style ?? BoxShape.circle,
              color: isHungry ? Colors.transparent : color,
              border: Border.all(
                color: color,
                width: 2.0,
              ),
            ),
          ),

          //
          Expanded(
            flex: 2,
            child: Text(
              text,
              style: context.xHeadline5,
            ),
          ),

          //
          Expanded(
            child: SizedBox(
              height: 16,
              width: 16,
              child: Checkbox(
                value: status,
                onChanged: statCallback,
                activeColor: getIt<ITheme>().mainColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
