import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../core/core.dart';
import '../../../../../model/model.dart';
import '../../../../chronic_tracking/blood_pressure/blood_pressure.dart';
import '../../../../chronic_tracking/bottom_actions_of_graph.dart';
import '../../../../chronic_tracking/home/view/widgets/widgets.dart';
import '../../../notifiers/patient_notifiers.dart';
import '../../../treatment_process/view/treatment_process_screen.dart';

part '../viewmodel/bp_patient_detail_vm.dart';
part '../widget/charts/bp_line_chart.dart';
part '../widget/graph_header_section.dart';
part '../widget/measurement_list.dart';
part '../widget/blood_pressure_detail_card.dart';

class BpPatientDetailScreen extends StatefulWidget {
  const BpPatientDetailScreen({Key? key}) : super(key: key);

  @override
  _BpPatientDetailScreenState createState() => _BpPatientDetailScreenState();
}

class _BpPatientDetailScreenState extends State<BpPatientDetailScreen>
    with SingleTickerProviderStateMixin {
  int? patientId;
  String? patientName;
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
      patientId = int.parse(Atom.queryParameters['patientId'] as String);
      patientName = Atom.queryParameters['patientName'];
    } catch (_) {
      return const RbioRouteError();
    }
    MediaQuery.of(context).orientation == Orientation.landscape
        ? SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [])
        : SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: SystemUiOverlay.values);

    return ChangeNotifierProvider<BpPatientDetailVm>(
      create: (context) => BpPatientDetailVm(
        mContext: context,
        patientId: patientId as int,
      ),
      child: Consumer<BpPatientDetailVm>(
        builder: (
          BuildContext context,
          BpPatientDetailVm vm,
          Widget? child,
        ) {
          return AtomDropdownBanner(
            navigatorKey: _dropdownBannerKey,
            child: !vm.isDataLoading! &&
                    MediaQuery.of(context).orientation == Orientation.landscape
                ? _GraphHeaderSection(
                    value: vm,
                    controller: _controller,
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
          LocaleProvider.current.bp_tracking,
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

  Widget _buildBody(BpPatientDetailVm vm) => SingleChildScrollView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: vm.loading == LoadingProgress.loading
            ? const RbioLoading()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  //
                  if (MediaQuery.of(context).orientation ==
                      Orientation.portrait)
                    _buildExpandedUser(),

                  ClipRRect(
                    borderRadius: R.sizes.borderRadiusCircular,
                    child: SizeTransition(
                      sizeFactor: sizeAnimation,
                      child: _UserBloodPressureDetailCard(
                          patientDetail: vm.bpMeasurements.isNotEmpty
                              ? vm.bpMeasurements.first.bpModel
                              : null),
                    ),
                  ),

                  //
                  if (MediaQuery.of(context).orientation ==
                      Orientation.portrait)
                    const SizedBox(height: 12),

                  if (!vm.isDataLoading! &&
                      MediaQuery.of(context).orientation ==
                          Orientation.portrait) ...[
                    vm.isChartShow
                        ? _GraphHeaderSection(
                            value: vm,
                            controller: _controller,
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: context.height * .02),
                            child: RbioElevatedButton(
                              title: LocaleProvider.current.open_chart,
                              onTap: vm.changeChartShowStatus,
                            ),
                          ),
                    if (MediaQuery.of(context).orientation ==
                        Orientation.portrait)
                      //
                      SizedBox(
                        height: vm.isChartShow
                            ? context.height * .5
                            : context.height * .8,
                        child: _MeasurementList(
                            bpMeasurements: vm.bpMeasurements,
                            scrollController: vm.controller!,
                            fetchScrolledData: vm.fetchScrolledData),
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
                          patientName ?? '',
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
              final patient = context.read<PatientNotifiers>().patientDetail;

              if (patient.treatmentModelList == null ||
                  patient.treatmentModelList!.isEmpty) {
                Atom.to(
                  PagePaths.doctorTreatmentEdit,
                  queryParameters: {
                    'treatment_model': jsonEncode(TreatmentProcessItemModel(
                      dateTime: DateTime.now(),
                      description: '',
                      id: -1,
                      title: '',
                    ).toJson()),
                    'newModel': true.toString(),
                  },
                );
              } else {
                Atom.to(PagePaths.doctorTreatmentProgress);
              }
            },
            child: Container(
              height: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 32),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: getIt<IAppConfig>().theme.cardBackgroundColor,
                borderRadius: R.sizes.borderRadiusCircular,
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
