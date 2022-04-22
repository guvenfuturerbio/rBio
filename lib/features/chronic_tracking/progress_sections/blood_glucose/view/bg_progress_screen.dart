import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../../core/core.dart';
import '../../../../doctor/treatment_process/view/treatment_process_screen.dart';
import '../../../bottom_actions_of_graph.dart';
import '../../widgets/chronic_graph_header.dart';
import '../../widgets/landscape_chronic_component.dart';
import '../viewmodel/bg_progress_vm.dart';
import '../widgets/bg_chart_filter/bg_chart_filter_pop_up.dart';
import '../widgets/bg_custom_bar_pie.dart';
import '../widgets/bg_measurement_list.dart';

/// MG19
class BgProgressScreen extends StatelessWidget {
  final void Function()? callBack;

  const BgProgressScreen({
    Key? key,
    this.callBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BgProgressVm>(
      builder: (BuildContext context, BgProgressVm vm, Widget? child) {
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
                BgChartFilterPopUp(
                  width: context.height * .9,
                  height: context.width * .3,
                ),
                barrierColor: Colors.black12,
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
        LocaleProvider.current.bg_measurement_tracking,
      ),
    );
  }

  Widget _buildBody(BuildContext context, BgProgressVm vm) {
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
          _buildExpandedUser(context),

          //
          if (vm.isChartShow) ...[
            //
            SizedBox(
              height: (context.height * .4) * context.textScale,
              child: ChronicGraphHeader(
                value: vm,
                callBack: () =>
                    context.read<BgProgressVm>().changeChartShowStatus(),
              ),
            ),

            //
            BottomActionsOfGraph(
              value: vm,
            ),

            //
            LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(20),
                        blurRadius: 5,
                        spreadRadius: 0,
                        offset: const Offset(5, 5),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BgCustomBarPie(
                      width: constraints.maxWidth,
                      height: (context.height * .05) * context.textScale,
                    ),
                  ),
                );
              },
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
          SizedBox(
            height: vm.isChartShow ? context.height * .4 : context.height * .8,
            child: BgMeasurementListWidget(
              bgMeasurements: vm.bgMeasurements,
              scrollController: vm.controller,
              useStickyGroupSeparatorsValue: true,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFAB(BgProgressVm vm, BuildContext context) {
    return FloatingActionButton(
      backgroundColor: getIt<ITheme>().mainColor,
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

  Widget _buildExpandedUser(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          //
          Expanded(
            child: Container(
              height: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: getIt<ITheme>().cardBackgroundColor,
                borderRadius: R.sizes.borderRadiusCircular,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    foregroundImage: Utils.instance.getCacheProfileImage,
                    backgroundColor: getIt<ITheme>().cardBackgroundColor,
                  ),

                  //
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        getIt<ProfileStorageImpl>().getFirst().name ?? 'Name',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.xHeadline5.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //
          const SizedBox(width: 6),

          //
          GestureDetector(
            onTap: () {
              final treatmentList =
                  getIt<ProfileStorageImpl>().getFirst().treatmentList;
              if ((treatmentList ?? []).isEmpty) {
                Atom.to(
                  PagePaths.treatmentEditProgress,
                  queryParameters: {
                    'treatment_model': jsonEncode(
                      TreatmentProcessItemModel(
                        dateTime: DateTime.now(),
                        description: '',
                        id: -1,
                        title: '',
                      ).toJson(),
                    ),
                    'newModel': true.toString(),
                  },
                );
              } else {
                Atom.to(PagePaths.treatmentProgress);
              }
            },
            child: Container(
              height: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 32),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: getIt<ITheme>().cardBackgroundColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                LocaleProvider.current.treatment,
                style: context.xHeadline5.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
