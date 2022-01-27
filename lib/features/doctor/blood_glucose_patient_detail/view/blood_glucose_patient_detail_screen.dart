import 'dart:convert';
import 'dart:ui';

import 'package:countup/countup.dart';
import 'package:dropdown_banner/dropdown_banner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';
import '../../../chronic_tracking/lib/widgets/utils/time_period_filters.dart';
import '../../../chronic_tracking/progress_sections/utils/date_range_picker/date_range_picker.dart';
import '../../../chronic_tracking/utils/bottom_actions_of_graph/bottom_actions_of_graph.dart';
import '../../../chronic_tracking/utils/glucose_margins_filter.dart';
import '../../notifiers/bg_measurements_notifiers.dart';
import '../../notifiers/patient_notifiers.dart';

part '../viewmodel/blood_glucose_patient_detail_vm.dart';
part '../viewmodel/blood_glucose_patient_picker_vm.dart';
part '../widget/chart_filter.dart';
part '../widget/charts/line_chart.dart';
part '../widget/charts/sample_model.dart';
part '../widget/charts/sample_view.dart';
part '../widget/charts/scatter_chart.dart';
part '../widget/custom_bar_pie.dart';
part '../widget/graph_header_section.dart';
part '../widget/hyper_picker.dart';
part '../widget/hypo_picker.dart';
part '../widget/measurement_list.dart';
part '../widget/normal_range_selection_slider.dart';
part '../widget/tagger_popup.dart';
part '../widget/user_detail_card.dart';

class BloodGlucosePatientDetailScreen extends StatefulWidget {
  int patientId;
  String patientName;

  BloodGlucosePatientDetailScreen({Key key}) : super(key: key);

  @override
  _BloodGlucosePatientDetailScreenState createState() =>
      _BloodGlucosePatientDetailScreenState();
}

class _BloodGlucosePatientDetailScreenState
    extends State<BloodGlucosePatientDetailScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> sizeAnimation;

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
      widget.patientName = Atom.queryParameters['patientName'];
      widget.patientId = int.parse(Atom.queryParameters['patientId']);
    } catch (_) {
      return RbioRouteError();
    }
    MediaQuery.of(context).orientation == Orientation.landscape
        ? SystemChrome.setEnabledSystemUIOverlays([])
        : SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    return ChangeNotifierProvider<BloodGlucosePatientDetailVm>(
      create: (context) => BloodGlucosePatientDetailVm(
          context: context, patientId: widget.patientId),
      child: Consumer<BloodGlucosePatientDetailVm>(
        builder: (
          BuildContext context,
          BloodGlucosePatientDetailVm vm,
          Widget child,
        ) {
          return DropdownBanner(
            navigatorKey: _dropdownBannerKey,
            child: !vm.isDataLoading &&
                    MediaQuery.of(context).orientation == Orientation.landscape
                ? _GraphHeaderSection(
                    value: vm,
                    controller: vm.controller,
                  )
                : RbioScaffold(
                    appbar: _buildAppBar(),
                    body: _buildBody(vm),
                    floatingActionButton: FloatingActionButton(
                      onPressed: () {
                        LoggerUtils.instance.i(vm.bgMeasurements.last.date);
                        LoggerUtils.instance.i(vm.bgMeasurements.first.date);
                      },
                      child: Icon(Icons.add),
                    ),
                  ),
          );
        },
      ),
    );
  }

  RbioAppBar _buildAppBar() => RbioAppBar(
        title: RbioAppBar.textTitle(
          context,
          LocaleProvider.current.bg_measurement_tracking,
        ),
        actions: [
          Center(
            child: RbioBadge(
              image: R.image.chat_icon,
              isDark: false,
            ),
          ),
          SizedBox(
            width: 12,
          ),
        ],
      );

  Widget _buildBody(BloodGlucosePatientDetailVm vm) => SingleChildScrollView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            //
            _buildExpandedUser(),

            //
            if (vm.stateProcessPatientDetail == LoadingProgress.LOADING) ...[
              SizedBox(height: 12),
              Shimmer.fromColors(
                child: _UserDetailCard(
                  patientDetail: DoctorPatientDetailModel(),
                  targetRangePresses: () {},
                  hypoEdit: () {},
                  hyperEdit: () {},
                ),
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
              ),
            ] else ...[
              ClipRRect(
                borderRadius: R.sizes.borderRadiusCircular,
                child: SizeTransition(
                  sizeFactor: sizeAnimation,
                  child: _UserDetailCard(
                    patientDetail: vm.patientDetail,
                    targetRangePresses: () {
                      vm.showEditAlert(_NormalRangeSelectionSlider());
                    },
                    hypoEdit: () {
                      vm.showEditAlert(_HypoPicker());
                    },
                    hyperEdit: () {
                      vm.showEditAlert(_HyperPicker());
                    },
                  ),
                ),
              ),
            ],

            //
            SizedBox(height: 12),

            //
            if (!vm.isDataLoading) ...[
              vm.isChartShow
                  ? _GraphHeaderSection(
                      value: vm,
                      controller: vm.controller,
                    )
                  : Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: context.HEIGHT * .02),
                      child: RbioElevatedButton(
                        title: LocaleProvider.current.open_chart,
                        onTap: vm.changeChartShowStatus,
                      ),
                    ),
              if (MediaQuery.of(context).orientation == Orientation.portrait)
                //
                SizedBox(
                  height: vm.isChartShow
                      ? context.HEIGHT * .5
                      : context.HEIGHT * .8,
                  child: _MeasurementList(
                    bgMeasurements: vm.bgMeasurements,
                    scrollController: vm.controller,
                    useStickyGroupSeparatorsValue:
                        vm.selected == LocaleProvider.current.daily ||
                                vm.selected == LocaleProvider.current.specific
                            ? true
                            : false,
                  ),
                ),
            ] else ...[
              Shimmer.fromColors(
                child: _UserDetailCard(
                  patientDetail: DoctorPatientDetailModel(),
                  targetRangePresses: () {},
                  hypoEdit: () {},
                  hyperEdit: () {},
                ),
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
              ),
            ],
          ],
        ),
      );

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
                          widget.patientName ?? '',
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
                      R.image.arrow_down_icon,
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),

          //
          SizedBox(width: 6),

          //
          GestureDetector(
            onTap: () {
              Atom.to(PagePaths.DOCTOR_TREATMENT_PROCESS);
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
