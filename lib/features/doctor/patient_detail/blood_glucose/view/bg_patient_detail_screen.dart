import 'dart:ui';

import 'package:countup/countup.dart';
import 'package:flutter/cupertino.dart';
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

import '../../../../../core/core.dart';
import '../../../../../model/model.dart';
import '../../../../chronic_tracking/progress_sections/widgets/date_range_picker/date_range_picker.dart';
import '../../../../chronic_tracking/bottom_actions_of_graph.dart';
import '../../../../../core/enums/glucose_margins_filter.dart';
import '../../../notifiers/bg_measurements_notifiers.dart';
import '../../../notifiers/patient_notifiers.dart';

part '../viewmodel/bg_patient_detail_vm.dart';
part '../viewmodel/bg_patient_picker_vm.dart';
part '../widget/chart_filter.dart';
part '../widget/charts/line_chart.dart';
part '../widget/charts/scatter_chart.dart';
part '../widget/custom_bar_pie.dart';
part '../widget/graph_header_section.dart';
part '../widget/hyper_picker.dart';
part '../widget/hypo_picker.dart';
part '../widget/measurement_list.dart';
part '../widget/normal_range_selection_slider.dart';
part '../widget/tagger_popup.dart';
part '../widget/user_detail_card.dart';

class BgPatientDetailScreen extends StatefulWidget {
  const BgPatientDetailScreen({Key? key}) : super(key: key);

  @override
  _BgPatientDetailScreenState createState() => _BgPatientDetailScreenState();
}

class _BgPatientDetailScreenState extends State<BgPatientDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> sizeAnimation;

  final _dropdownBannerKey = GlobalKey<NavigatorState>();
  late String patientName;
  late int patientId;

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

    return ChangeNotifierProvider<BgPatientDetailVm>(
      create: (context) => BgPatientDetailVm(
        context: context,
        patientId: patientId,
      ),
      child: Consumer<BgPatientDetailVm>(
        builder: (
          BuildContext context,
          BgPatientDetailVm vm,
          Widget? child,
        ) {
          return AtomDropdownBanner(
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
          // Center(
          //   child: RbioBadge(
          //     image: R.image.chat,
          //     isDark: false,
          //     onTap: () {
          //       // final chatPerson = ChatPerson(
          //       //   id: patientId.toString(),
          //       //   name: patientName,
          //       //   firebaseToken: '',
          //       // );
          //       // Atom.to(
          //       //   PagePaths.chat,
          //       //   queryParameters: {
          //       //     'otherPerson': chatPerson.toJson(),
          //       //   },
          //       // );
          //     },
          //   ),
          // ),
          // const SizedBox(
          //   width: 12,
          // ),
        ],
      );

  Widget _buildBody(BgPatientDetailVm vm) => SingleChildScrollView(
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
            if (vm.stateProcessPatientDetail == LoadingProgress.loading) ...[
              const SizedBox(height: 12),
              Shimmer.fromColors(
                child: _UserDetailCard(
                  patientDetail: DoctorPatientDetailModel(),
                  targetRangePresses: () {},
                  hypoEdit: () {},
                  hyperEdit: () {},
                ),
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
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
            const SizedBox(height: 12),

            //
            if (!vm.isDataLoading) ...[
              vm.isChartShow
                  ? _GraphHeaderSection(
                      value: vm,
                      controller: vm.controller,
                    )
                  : Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: context.height * .02),
                      child: RbioElevatedButton(
                        title: LocaleProvider.current.open_chart,
                        onTap: vm.changeChartShowStatus,
                      ),
                    ),
              if (MediaQuery.of(context).orientation == Orientation.portrait)
                //
                SizedBox(
                  height: vm.isChartShow
                      ? context.height * .5
                      : context.height * .8,
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
                  color: getIt<IAppConfig>().theme.cardBackgroundColor,
                  borderRadius: R.sizes.borderRadiusCircular,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      foregroundImage: NetworkImage(R.image.circlevatar),
                      backgroundColor:
                          getIt<IAppConfig>().theme.cardBackgroundColor,
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
                color: getIt<IAppConfig>().theme.cardBackgroundColor,
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
