import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../../core/core.dart';
import '../../widgets/chronic_graph_header.dart';
import '../../widgets/landscape_chronic_component.dart';
import '../viewmodel/bp_progres_vm.dart';
import '../widgets/bp_chart_filter/bp_chart_filter_pop_up.dart';
import '../widgets/bp_measurement_list.dart';

class BpProgressScreen extends StatelessWidget {
  final Function()? callback;

  const BpProgressScreen({
    Key? key,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BpProgressVm>(
      builder: (BuildContext context, BpProgressVm vm, Widget? child) {
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
            filterAction: () => Atom.show(
              BpChartFilterPopUp(
                width: context.width * .3,
              ),
            ),
          );
        }
      },
    );
  }

  RbioAppBar _buildAppBar(BuildContext context) {
    return RbioAppBar(
      title: RbioAppBar.textTitle(
        context,
        LocaleProvider.current.bp_tracking,
      ),
    );
  }

  Widget _buildBody(BuildContext context, BpProgressVm vm) {
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
          R.sizes.hSizer8,
          R.sizes.stackedTopPadding(context),

          //
          if (vm.isChartShow) ...[
            //
            SizedBox(
              height: (context.height * .4) * context.textScale,
              child: ChronicGraphHeader(
                value: vm,
                callBack: () =>
                    context.read<BpProgressVm>().changeChartShowStatus(),
              ),
            ),

            //
            R.sizes.hSizer8,

            //
            Wrap(
              spacing: 12,
              children: [
                //
                _buildInfoSection(context),

                //
                vm.filterButton(
                  context: context,
                  onPressed: () {
                    vm.showFilter(context);
                  },
                ),
              ],
            ),
          ] else ...[
            Padding(
              padding: EdgeInsets.symmetric(vertical: context.height * .02),
              child: RbioElevatedButton(
                title: LocaleProvider.current.open_chart,
                onTap: () =>
                    context.read<BpProgressVm>().changeChartShowStatus(),
              ),
            ),
          ],

          //
          SizedBox(
            height: vm.isChartShow
                ? (context.height * .4) * context.textScale
                : (context.height * .8),
            child: BpMeasurementList(
              bpMeasurements: vm.bpMeasurements,
              scrollController: vm.controller,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFAB(BpProgressVm vm, BuildContext context) {
    return FloatingActionButton(
      backgroundColor: getIt<IAppConfig>().theme.mainColor,
      onPressed: () => vm.manuelEntry(context),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: SvgPicture.asset(
          R.image.add,
          color: getIt<IAppConfig>().theme.white,
        ),
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //
        Wrap(
          children: [
            SizedBox(
              width: context.width * .06,
              child: Divider(
                thickness: 3,
                color: Colors.red[900],
              ),
            ),

            //
            SizedBox(width: context.width * .02),

            //
            Text(
              LocaleProvider.current.sys,
              style: context.xHeadline4,
            ),
          ],
        ),

        //
        Wrap(
          children: [
            //
            SizedBox(
              width: context.width * .06,
              child: const Divider(
                thickness: 3,
                color: Colors.amber,
              ),
            ),

            //
            SizedBox(width: context.width * .02),

            //
            Text(
              LocaleProvider.current.dia,
              style: context.xHeadline4,
            ),
          ],
        ),

        //
        Wrap(
          children: [
            //
            SizedBox(
              width: context.width * .06,
              child: Divider(
                thickness: 3,
                color: Colors.lime[800],
              ),
            ),

            //
            SizedBox(width: context.width * .02),

            //
            Text(
              LocaleProvider.current.pulse,
              style: context.xHeadline4,
            ),
          ],
        ),
      ],
    );
  }
}
