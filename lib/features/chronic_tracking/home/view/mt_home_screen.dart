import 'dart:convert';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../../dashboard/not_chronic_screen.dart';
import '../../../doctor/treatment_process/view/treatment_process_screen.dart';
import '../../progress_sections/blood_glucose/viewmodel/bg_progress_vm.dart';
import '../../progress_sections/blood_pressure/viewmodel/bp_progres_vm.dart';
import '../../progress_sections/scale/viewmodel/scale_progress_vm.dart';
import '../model/home_page_model.dart';
import '../../../../core/widgets/rbio_error_screen.dart';

part '../viewmodel/mt_home_vm.dart';
part '../widgets/section_card.dart';

class MeasurementTrackingHomeScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState>? drawerKey;

  const MeasurementTrackingHomeScreen({
    Key? key,
    this.drawerKey,
  }) : super(key: key);

  @override
  State<MeasurementTrackingHomeScreen> createState() =>
      _MeasurementTrackingHomeScreenState();
}

class _MeasurementTrackingHomeScreenState
    extends State<MeasurementTrackingHomeScreen> {
  @override
  void dispose() {
    Utils.instance.forcePortraitOrientation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !getIt<UserNotifier>().isCronic
        ? NotChronicScreen(
            title: LocaleProvider.current.chronic_track_home,
            drawerKey: widget.drawerKey,
          )
        : ChangeNotifierProvider(
            create: (_) => MeasurementTrackingVm(),
            child: Consumer<MeasurementTrackingVm>(
              builder: (
                BuildContext context,
                MeasurementTrackingVm vm,
                Widget? child,
              ) {
                bool isLandscape =
                    context.xMediaQuery.orientation == Orientation.landscape &&
                        !Atom.isWeb;

                return RbioStackedScaffold(
                  appbar: _buildAppBar(isLandscape, context),
                  body: _buildBody(context, vm, isLandscape),
                );
              },
            ),
          );
  }

  RbioAppBar? _buildAppBar(bool isLandscape, BuildContext context) {
    return isLandscape
        ? null
        : RbioAppBar(
            leading: widget.drawerKey != null
                ? RbioLeadingMenu(drawerKey: widget.drawerKey)
                : null,
            title: RbioAppBar.textTitle(
              context,
              LocaleProvider.current.chronic_track_home,
            ),
          );
  }

  Widget _buildBody(
    BuildContext context,
    MeasurementTrackingVm vm,
    bool isLandscape,
  ) {
    switch (vm.state) {
      case LoadingProgress.loading:
        return const RbioLoading();

      case LoadingProgress.done:
        return _buildList(context, vm, isLandscape);

      case LoadingProgress.error:
        return RbioErrorScreenBody(
          errorMsg: LocaleProvider.current.chronic_track_error,
        );

      default:
        return const SizedBox();
    }
  }

  Widget _buildList(
    BuildContext context,
    MeasurementTrackingVm vm,
    bool isLandscape,
  ) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      padding: isLandscape
          ? null
          : EdgeInsets.only(top: RbioStackedScaffold.kHeight(context)),
      children: [
        //
        if (MediaQuery.of(context).orientation == Orientation.portrait)
          _buildExpandedUser(),

        //
        R.sizes.hSizer12,

        //
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            color: vm.activeItem != null ? Colors.transparent : Colors.white,
            boxShadow: vm.activeItem != null
                ? [
                    const BoxShadow(color: Colors.transparent),
                  ]
                : null,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(17),
            child: Column(
              children: vm.items
                  .map(
                    (parentElement) => _SectionCard(
                      isVisible: vm.activeItem == null,
                      smallChild: parentElement.smallChild ?? const SizedBox(),
                      hasDivider: vm.activeItem == null &&
                          vm.items.indexWhere((element) =>
                                  element.key == parentElement.key) <
                              vm.items.length - 1,
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

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
                    foregroundImage: Utils.instance.getCacheProfileImage,
                    backgroundColor:
                        getIt<IAppConfig>().theme.cardBackgroundColor,
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
              getIt<FirebaseAnalyticsManager>()
                  .logEvent(SaglikTakibiButonlarEvent('Tedavi'));

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
