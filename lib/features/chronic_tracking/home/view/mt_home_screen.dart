import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../../core/widgets/rbio_error_screen.dart';
import '../../../dashboard/onedose/not_chronic_screen.dart';
import '../../../doctor/treatment_process/view/treatment_process_screen.dart';
import '../../blood_glucose/blood_glucose.dart';
import '../../blood_glucose/model/model.dart';
import '../../blood_pressure/blood_pressure.dart';
import '../../blood_pressure/model/model.dart';
import '../model/home_page_model.dart';
import '../viewmodel/scale_progress_vm.dart';

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
    return !getIt<UserNotifier>().user.xGetChronicTrackingOrFalse
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
            context: context,
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
        R.widgets.hSizer12,

        //
        Card(
          margin: EdgeInsets.zero,
          child: Column(
            children: vm.items
                .map(
                  (parentElement) => _SectionCard(
                    isVisible: vm.activeItem == null,
                    smallChild: parentElement.smallChild ?? const SizedBox(),
                    hasDivider: vm.activeItem == null &&
                        vm.items.indexWhere(
                                (element) => element.key == parentElement.key) <
                            vm.items.length - 1,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildExpandedUser() {
    return RbioUserAndTreatmentTile(
      horizontalPadding: false,
      onTap: () {
        getIt<IAppConfig>()
            .platform
            .adjustManager
            ?.trackEvent(HealthTrackerButtonsEvent());
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
    );
  }
}
