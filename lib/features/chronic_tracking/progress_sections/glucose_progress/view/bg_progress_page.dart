import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/core.dart';
import '../../../utils/bottom_actions_of_graph/bottom_actions_of_graph.dart';
import '../../utils/chart_filter_pop_up.dart';
import '../../utils/graph_header_widget.dart';
import '../../utils/landscape_graph_widget.dart';
import '../utils/bg_measurement_list.dart';
import '../utils/custom_bar_pie.dart';
import '../view_model/bg_progress_page_view_model.dart';

/// MG19
class BgProgressPage extends StatefulWidget {
  final Function() callBack;

  const BgProgressPage({Key key, this.callBack}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BgProgressPage();
  }
}

class _BgProgressPage extends State<BgProgressPage> {
  @override
  Widget build(BuildContext context) {
    var value = Provider.of<BgProgressPageViewModel>(context);
    return MediaQuery.of(context).orientation == Orientation.portrait ||
            Atom.isWeb
        ? RbioStackedScaffold(
            appbar: RbioAppBar(
              title: RbioAppBar.textTitle(
                context,
                LocaleProvider.current.bg_measurement_tracking,
              ),
            ),
            body: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: R.sizes.stackedTopPaddingValue(context) + 8,
                  ),
                  _buildExpandedUser(),
                  if (value.isChartShow) ...[
                    SizedBox(
                        height: (context.HEIGHT * .4) * context.TEXTSCALE,
                        child: GraphHeader(
                          value: value,
                          callBack: () => context
                              .read<BgProgressPageViewModel>()
                              .changeChartShowStatus(),
                        )),
                    BottomActionsOfGraph(
                      value: value,
                    ),
                    LayoutBuilder(builder: (context, constraints) {
                      return Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: Colors.black.withAlpha(20),
                              blurRadius: 5,
                              spreadRadius: 0,
                              offset: Offset(5, 5))
                        ]),
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: CustomBarPie(
                            width: constraints.maxWidth,
                            height: (context.HEIGHT * .05) * context.TEXTSCALE,
                          ),
                        ),
                      );
                    }),
                  ],
                  if (!value.isChartShow)
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: context.HEIGHT * .02),
                      child: RbioElevatedButton(
                        title: LocaleProvider.current.open_chart,
                        onTap: value.changeChartShowStatus,
                      ),
                    ),
                  SizedBox(
                    height: value.isChartShow
                        ? context.HEIGHT * .4
                        : context.HEIGHT * .8,
                    child: BgMeasurementListWidget(
                      bgMeasurements: value.bgMeasurements,
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
              Atom.show(
                  BGChartFilterPopUp(
                    height: context.HEIGHT * .9,
                    width: context.WIDTH * .3,
                  ),
                  barrierColor: Colors.black12);
            },
            changeGraphAction: () => value.changeGraphType(),
          );
  }

  Widget _buildExpandedUser() {
    return Container(
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
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: getIt<ITheme>().cardBackgroundColor,
                borderRadius: R.sizes.borderRadiusCircular,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    foregroundImage: NetworkImage(R.image.circlevatar),
                    backgroundColor: getIt<ITheme>().cardBackgroundColor,
                  ),

                  //
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        getIt<ProfileStorageImpl>().getFirst().name ?? '',
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
          SizedBox(width: 6),

          //
          GestureDetector(
            onTap: () {
              Atom.to(PagePaths.TREATMENT_PROGRESS);
            },
            child: Container(
              height: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 32),
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
