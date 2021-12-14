import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onedosehealth/features/doctor/blood_glucose_patient_detail/widget/measurement_list.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';
import '../../../chronic_tracking/progress_sections/glucose_progress/utils/bg_measurement_list.dart';
import '../../utils//widgets.dart';
import '../../utils/graph_header_section.dart';
import '../../utils/hypo_hyper_edit/hypo_hyper_edit_view_model.dart';
import '../viewmodel/blood_glucose_patient_detail_vm.dart';

part '../widget/user_detail_card.dart';

class BloodGlucosePatientDetailScreen extends StatefulWidget {
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

  final _controller = ScrollController();
  final _navigatorKey = GlobalKey<NavigatorState>();

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

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BloodGlucosePatientDetailVm>(
      create: (context) => BloodGlucosePatientDetailVm(),
      child: Consumer<BloodGlucosePatientDetailVm>(
        builder: (
          BuildContext context,
          BloodGlucosePatientDetailVm vm,
          Widget child,
        ) {
          return RbioScaffold(
            appbar: _buildAppBar(),
            body: _buildBody(vm),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            //
            _buildExpandedUser(),

            //
            ClipRRect(
              borderRadius: R.sizes.borderRadiusCircular,
              child: SizeTransition(
                sizeFactor: sizeAnimation,
                child: _UserDetailCard(
                  patientDetail: DoctorPatientDetailModel(),
                  targetRangePresses: () {},
                  hypoEdit: () {},
                  hyperEdit: () {},
                ),
              ),
            ),

            //
            vm.stateProcessPatientDetail == StateProcess.LOADING
                ? Shimmer.fromColors(
                    child: patientDetail(
                        context: context,
                        targetRangePresses: () {},
                        hyperEdit: () {}),
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[100])
                : patientDetail(
                    context: context,
                    patientDetail: vm.patientDetail,
                    targetRangePresses: () {
                      vm.showNormalRangeEdit();
                    },
                    hypoEdit: () {
                      vm.showHypoEdit();
                    },
                    hyperEdit: () {
                      vm.showHyperEdit();
                    },
                  ),

            //
            if (!vm.isDataLoading) ...{
              BgGraphHeaderSection(value: vm, controller: _controller),
              SizedBox(
                height: context.HEIGHT * .3,
                child: MeasurementList(
                  bgMeasurements: vm.bgMeasurements,
                  scrollController: _controller,
                  useStickyGroupSeparatorsValue:
                      vm.selected == LocaleProvider.current.daily ||
                              vm.selected == LocaleProvider.current.specific
                          ? true
                          : false,
                ),
              ),
            } else ...{
              Shimmer.fromColors(
                  child: patientDetail(
                      context: context,
                      targetRangePresses: () {},
                      hyperEdit: () {}),
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.grey[100])
            }
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
                  children: [
                    CircleAvatar(
                      foregroundImage: NetworkImage(R.image.mockWomanAvatar),
                      backgroundColor: getIt<ITheme>().cardBackgroundColor,
                    ),

                    //
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Ayşe Yıldırım',
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
                'Tedavi',
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
