import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/core.dart';
import '../../home/view/widgets/widgets.dart';
import '../widgets/widgets.dart';
import '../viewmodel/bp_progres_vm.dart';

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
      context: context,
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
          R.widgets.hSizer8,
          R.widgets.stackedTopPadding(context),

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
            R.widgets.hSizer8,

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
    return RbioSVGFAB.primaryColor(
      context,
      imagePath: R.image.add,
      onPressed: () => vm.manuelEntry(context),
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
