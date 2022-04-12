import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:onedosehealth/features/doctor/patient_detail/scale/cubit/scale_doctor_cubit.dart';
import 'package:onedosehealth/features/doctor/patient_detail/scale/widget/measurement_list.dart';

import '../../../../../core/core.dart';

import '../../../../../../core/core.dart';

class ScalePatientDetailScreen extends StatelessWidget {
  const ScalePatientDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late int patientId;
    late String patientName;
    try {
      patientName = Atom.queryParameters['patientName']!;
      patientId = int.parse(Atom.queryParameters['patientId']!);
    } catch (_) {
      return const RbioRouteError();
    }
    return BlocProvider(
      create: (context) => ScaleDoctorCubit(patientId)..fetchScaleData(),
      child: ScalePatientDetailView(patientName),
    );
  }
}

class ScalePatientDetailView extends StatefulWidget {
  String patientName;
  ScalePatientDetailView(this.patientName, {Key? key}) : super(key: key);

  @override
  _ScalePatientDetailViewState createState() => _ScalePatientDetailViewState();
}

class _ScalePatientDetailViewState extends State<ScalePatientDetailView>
    with SingleTickerProviderStateMixin {
  // Page Params Section

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
    MediaQuery.of(context).orientation == Orientation.landscape
        ? SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [])
        : SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: SystemUiOverlay.values);

    return BlocBuilder<ScaleDoctorCubit, ScaleDoctorState>(
      builder: (context, state) {
        return AtomDropdownBanner(
            navigatorKey: _dropdownBannerKey,
            child: RbioScaffold(
              appbar: _buildAppBar(),
              body: state.when(
                error: () => const SizedBox(),
                initial: () => const SizedBox(),
                loading: () => const CircularProgressIndicator(),
                loaded: (result) => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(height: 50, child: _buildExpandedUser()),
                      MeasurementList(
                          scaleMeasurements: result.patientScaleMeasurements),
                    ]),
              ),
            ));
      },
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
                          widget.patientName,
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
