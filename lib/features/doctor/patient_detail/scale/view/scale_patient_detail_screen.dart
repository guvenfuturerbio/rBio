import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:scale_calculations/scale_calculations.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../core/core.dart';
import '../../../../../model/model.dart';
import '../../../../chronic_tracking/bottom_actions_of_graph.dart';
import '../../../../chronic_tracking/progress_sections/scale/viewmodel/scale_progress_vm.dart';
import '../../../../chronic_tracking/progress_sections/scale/widgets/scale_filter_pop_up/scale_filter_pop_up.dart';
import '../../../../chronic_tracking/progress_sections/widgets/date_range_picker/date_range_picker.dart';
import '../../../notifiers/patient_notifiers.dart';

import '../../../../../../core/core.dart';
import '../../../../../../model/model.dart';

part '../viewmodel/scale_patient_detail_vm.dart';
part '../widget/graph_header_section.dart';
part '../widget/measurement_list.dart';
part '../widget/charts/scale_bubble_chart.dart';
part '../widget/charts/scale_line_chart.dart';
part '../widget/tagger_popup.dart';

class ScalePatientDetailScreen extends StatefulWidget {
  const ScalePatientDetailScreen({Key? key}) : super(key: key);

  @override
  _ScalePatientDetailScreenState createState() =>
      _ScalePatientDetailScreenState();
}

class _ScalePatientDetailScreenState extends State<ScalePatientDetailScreen>
    with SingleTickerProviderStateMixin {
  // Page Params Section
  late int patientId;
  late String patientName;
  // #Page Params Section End

  late AnimationController animationController;
  late Animation<double> sizeAnimation;

  final _controller = ScrollController();
  final _dropdownBannerKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    sizeAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn,
    );
    Utils.instance.releaseOrientation();

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    Utils.instance.forcePortraitOrientation();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      patientName = Atom.queryParameters['patientName']!;
      patientId = int.parse(Atom.queryParameters['patientId']!);
    } catch (_) {
      return const RbioRouteError();
    }

    MediaQuery.of(context).orientation == Orientation.landscape
        ? SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [])
        : SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: SystemUiOverlay.values);

    return ChangeNotifierProvider<ScalePatientDetailVm>(
      create: (ctx) => ScalePatientDetailVm(ctx, patientId),
      child: Consumer<ScalePatientDetailVm>(
        builder: (_, vm, __) => AtomDropdownBanner(
          navigatorKey: _dropdownBannerKey,
          child: !vm.isDataLoading &&
                  MediaQuery.of(context).orientation == Orientation.landscape
              ? _GraphHeaderSection(
                  value: vm,
                  controller: _controller,
                )
              : RbioScaffold(
                  appbar: _buildAppBar(),
                  body: _buildBody(vm),
                ),
        ),
      ),
    );
  }

  RbioAppBar _buildAppBar() => RbioAppBar(
        title: RbioAppBar.textTitle(
          context,
          LocaleProvider.current.bmi_tracking,
        ),
        actions: [
          Center(
            child: RbioBadge(
              image: R.image.chat,
              isDark: false,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
        ],
      );

  Widget _buildBody(ScalePatientDetailVm vm) => SingleChildScrollView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            //
            _buildExpandedUser(),

            //
            const SizedBox(height: 12),

            //
            if (!vm.isDataLoading) ...[
              vm.isChartShow
                  ? _GraphHeaderSection(
                      value: vm,
                      controller: _controller,
                    )
                  : Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: context.height * .02),
                      child: RbioElevatedButton(
                        title: LocaleProvider.current.open_chart,
                        onTap: vm.changeChartShowStatus,
                      ),
                    ),

              //
              if (MediaQuery.of(context).orientation == Orientation.portrait)
                SizedBox(
                  height: vm.isChartShow
                      ? context.height * .5
                      : context.height * .8,
                  child: _MeasurementList(
                    scaleMeasurements: vm.scaleMeasurement,
                    fetchScrolledData: vm.fetchScrolledData,
                    scrollController: vm.controller,
                    useStickyGroupSeparatorsValue:
                        vm.selected == TimePeriodFilter.daily ||
                                vm.selected == TimePeriodFilter.spesific
                            ? true
                            : false,
                    selected: vm.currentScaleType,
                  ),
                ),
            ] else ...[
              Shimmer.fromColors(
                child: SizedBox(
                  height: context.height * .3,
                  width: double.infinity,
                ),
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
              ),
            ],
          ],
        ),
      );

  Widget _buildExpandedUser() {
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
            child: GestureDetector(
              onTap: () {
                if (animationController.status == AnimationStatus.completed) {
                  animationController.reverse();
                } else if (animationController.status ==
                    AnimationStatus.dismissed) {
                  animationController.forward();
                }
              },
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
                      foregroundImage: NetworkImage(R.image.circlevatar),
                      backgroundColor: getIt<ITheme>().cardBackgroundColor,
                    ),

                    //
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          patientName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.xHeadline5.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    //
                    SvgPicture.asset(
                      R.image.arrowDown,
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),

          //
          const SizedBox(width: 6),

          //
          GestureDetector(
            onTap: () {
              Atom.to(PagePaths.doctorTreatmentProgress);
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
