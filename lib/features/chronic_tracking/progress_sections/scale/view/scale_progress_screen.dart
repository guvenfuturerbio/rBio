import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../../core/core.dart';
import '../../../bottom_actions_of_graph.dart';
import '../../widgets/chronic_graph_header.dart';
import '../../widgets/landscape_chronic_component.dart';
import '../widgets/scale_filter_pop_up/scale_filter_pop_up.dart';
import '../widgets/scale_measurement_list.dart';
import '../viewmodel/scale_progress_vm.dart';

class ScaleProgressScreen extends StatelessWidget {
  final Function()? callBack;

  const ScaleProgressScreen({
    Key? key,
    this.callBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ScaleProgressVm>(
      builder: (BuildContext context, ScaleProgressVm vm, Widget? child) {
        if (context.xIsPortrait || Atom.isWeb) {
          return RbioStackedScaffold(
            appbar: _buildAppBar(context),
            body: _buildBody(context, vm),
            floatingActionButton: _buildFAB(vm, context),
          );
        } else {
          return LandScapeChronicComponent(
            graph: vm.currentGraph,
            value: vm,
            filterAction: () {
              Atom.show(
                ScaleChartFilterPopup(
                  height: context.height * .9,
                  width: context.width * .3,
                  changeScaleType: vm.changeScaleType,
                ),
              );
            },
          );
        }
      },
    );
  }

  RbioAppBar _buildAppBar(BuildContext context) {
    return RbioAppBar(
      title: RbioAppBar.textTitle(
        context,
        LocaleProvider.current.bmi_tracking,
      ),
    );
  }

  Widget _buildBody(BuildContext context, ScaleProgressVm vm) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          //
          R.sizes.stackedTopPadding(context),

          //
          if (vm.isChartShow) ...[
            SizedBox(
              height: (context.height * .4) * context.textScale,
              child: ChronicGraphHeader(
                value: vm,
                callBack: () =>
                    context.read<ScaleProgressVm>().changeChartShowStatus(),
              ),
            ),

            //
            BottomActionsOfGraph(
              value: vm,
            ),
          ] else ...[
            Padding(
              padding: EdgeInsets.symmetric(vertical: context.height * .02),
              child: RbioElevatedButton(
                title: LocaleProvider.current.open_chart,
                onTap: vm.changeChartShowStatus,
              ),
            ),
          ],

          //
          Container(
            height: vm.isChartShow
                ? (context.height * .4) * context.textScale
                : (context.height * .8),
            margin: const EdgeInsets.only(top: 8),
            child: ScaleMeasurementList(
              scaleMeasurements: vm.scaleMeasurements,
              scrollController: vm.controller,
              useStickyGroupSeparatorsValue: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAB(ScaleProgressVm vm, BuildContext context) {
    return FloatingActionButton(
      backgroundColor: getIt<IAppConfig>().theme.mainColor,
      onPressed: () => vm.manuelEntry(context),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: SvgPicture.asset(
          R.image.add,
          color: R.color.white,
        ),
      ),
    );
  }
}
