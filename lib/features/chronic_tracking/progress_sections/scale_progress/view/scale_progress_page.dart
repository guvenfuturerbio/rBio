import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../../core/core.dart';
import '../../../utils/bottom_actions_of_graph/bottom_actions_of_graph.dart';
import '../../utils/graph_header_widget.dart';
import '../../utils/landscape_graph_widget.dart';
import '../utils/scale_filter_pop_up/scale_filter_pop_up.dart';
import '../utils/scale_measurement_list.dart';
import '../view_model/scale_progress_page_view_model.dart';

class ScaleProgressPage extends StatefulWidget {
  final Function()? callBack;

  const ScaleProgressPage({Key? key, this.callBack}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ScaleProgressPage();
  }
}

class _ScaleProgressPage extends State<ScaleProgressPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ScaleProgressPageViewModel>(
      builder: (context, value, child) {
        return MediaQuery.of(context).orientation == Orientation.portrait ||
                Atom.isWeb
            ? RbioStackedScaffold(
                appbar: RbioAppBar(
                  title: RbioAppBar.textTitle(
                    context,
                    LocaleProvider.current.bmi_tracking,
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  heroTag: 'adder',
                  onPressed: () => value.manuelEntry(context),
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: getIt<ITheme>().mainColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: SvgPicture.asset(
                        R.image.add,
                        color: R.color.white,
                      ),
                    ),
                  ),
                  backgroundColor: R.color.white,
                ),
                body: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: R.sizes.stackedTopPaddingValue(context) + 8,
                      ),
                      if (value.isChartShow) ...[
                        SizedBox(
                          height: (context.height * .4) * context.textScale,
                          child: GraphHeader(
                            value: value,
                            callBack: () => context
                                .read<ScaleProgressPageViewModel>()
                                .changeChartShowStatus(),
                          ),
                        ),
                        BottomActionsOfGraph(
                          value: value,
                        ),
                      ],
                      if (!value.isChartShow)
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: context.height * .02),
                          child: RbioElevatedButton(
                            title: LocaleProvider.current.open_chart,
                            onTap: value.changeChartShowStatus,
                          ),
                        ),
                      Container(
                        height: value.isChartShow
                            ? (context.height * .4) * context.textScale
                            : (context.height * .8),
                        margin: const EdgeInsets.only(top: 8),
                        child: ScaleMeasurementListWidget(
                          scaleMeasurements: value.scaleMeasurements,
                          scrollController: value.controller,
                          useStickyGroupSeparatorsValue: true,
                        ),
                      )
                    ],
                  ),
                ),
              )
            : LandScapeGraphWidget(
                graph: value.currentGraph,
                value: value,
                filterAction: () {
                  Atom.show(ScaleChartFilterPopup(
                    height: context.height * .9,
                    width: context.width * .3,
                    changeScaleType: value.changeScaleType,
                  ));
                },
              );
      },
    );
  }
}
