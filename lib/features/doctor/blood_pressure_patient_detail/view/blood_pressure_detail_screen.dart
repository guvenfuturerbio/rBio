import 'package:dropdown_banner/dropdown_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onedosehealth/features/chronic_tracking/progress_sections/utils/date_range_picker/date_range_picker.dart';
import 'package:onedosehealth/features/doctor/blood_pressure_patient_detail/viewmodel/blood_pressure_vm.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:onedosehealth/features/chronic_tracking/progress_sections/pressure_progress/utils/pressure_tagger/pressure_tagger.dart';
import 'package:onedosehealth/features/chronic_tracking/progress_sections/pressure_progress/view_model/pressure_measurement_view_model.dart';

import '../../../../../core/core.dart';

part '../widget/graph_header_section.dart';
part '../widget/measurement_list.dart';

class BloodPressurePatientDetailScreen extends StatefulWidget {
  BloodPressurePatientDetailScreen({Key key}) : super(key: key);

  @override
  _BloodPressurePatientDetailScreenState createState() =>
      _BloodPressurePatientDetailScreenState();
}

class _BloodPressurePatientDetailScreenState
    extends State<BloodPressurePatientDetailScreen>
    with SingleTickerProviderStateMixin {
  int patientId;
  String patientName;
  AnimationController animationController;
  Animation<double> sizeAnimation;

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

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      patientName = Atom.queryParameters['patientName'];
      patientId = int.parse(Atom.queryParameters['patientId']);
    } catch (_) {
      return RbioRouteError();
    }

    return ChangeNotifierProvider<BloodPressurePatientDetailVm>(
      create: (context) =>
          BloodPressurePatientDetailVm(context: context, patientId: patientId),
      child: Consumer<BloodPressurePatientDetailVm>(
        builder: (
          BuildContext context,
          BloodPressurePatientDetailVm vm,
          Widget child,
        ) {
          return DropdownBanner(
            navigatorKey: _dropdownBannerKey,
            child: RbioScaffold(
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
              image: R.image.chat_icon,
              isDark: false,
            ),
          ),
          SizedBox(
            width: 12,
          ),
        ],
      );

  Widget _buildBody(BloodPressurePatientDetailVm vm) => SingleChildScrollView(
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
            SizedBox(height: 12),

            //
            if (!vm.isDataLoading) ...[
              _GraphHeaderSection(
                value: vm,
                controller: _controller,
              ),
              if (MediaQuery.of(context).orientation == Orientation.portrait)
                //
                SizedBox(
                  height: context.HEIGHT * .3,
                  child: _MeasurementList(
                    bpMeasurements: vm.bpMeasurements,
                    scrollController: _controller,
                  ),
                ),
            ] else ...[
              Shimmer.fromColors(
                child: SizedBox(
                  height: context.HEIGHT * .3,
                  width: double.infinity,
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
