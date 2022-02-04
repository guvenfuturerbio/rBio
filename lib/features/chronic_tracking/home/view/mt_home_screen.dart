import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../../dashboard/not_chronic_screen.dart';
import '../../progress_sections/glucose_progress/view_model/bg_progress_page_view_model.dart';
import '../../progress_sections/pressure_progress/view/pressure_progres_page.dart';
import '../../progress_sections/scale_progress/view_model/scale_progress_page_view_model.dart';
import '../model/page_model.dart';
import '../utils/card_widget.dart';

part '../vm/mt_home_vm.dart';

class MeasurementTrackingHomeScreen extends StatefulWidget {
  final bool fromBottomBar;

  const MeasurementTrackingHomeScreen({Key? key, this.fromBottomBar = false})
      : super(key: key);

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
        ? NotChronicScreen(LocaleProvider.current.chronic_track_home)
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
                  floatingActionButton: _buildFAB(vm),
                );
              },
            ),
          );
  }

  RbioAppBar? _buildAppBar(bool isLandscape, BuildContext context) {
    return isLandscape
        ? null
        : RbioAppBar(
            leadingWidth: !widget.fromBottomBar ? null : 0,
            leading: !widget.fromBottomBar
                ? null
                : const SizedBox(width: 0, height: 0),
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
        return const RbioBodyError();

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
                    (parentElement) => SectionCard(
                      isActive: vm.activeItem != null &&
                          vm.activeItem!.key == parentElement.key,
                      isVisible: vm.activeItem == null,
                      smallChild: parentElement.smallChild ?? const SizedBox(),
                      largeChild: parentElement.largeChild ?? const SizedBox(),
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

  FloatingActionButton? _buildFAB(MeasurementTrackingVm val) {
    return val.activeItem != null
        ? FloatingActionButton(
            heroTag: 'adder',
            onPressed: () {
              final manuelEntry = val.activeItem?.manuelEntry;
              if (manuelEntry != null) {
                manuelEntry();
              }
            },
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: getIt<ITheme>().mainColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: SvgPicture.asset(
                  R.image.add,
                  color: R.color.white,
                ),
              ),
            ),
            backgroundColor: R.color.white,
          )
        : null;
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
                        getIt<ProfileStorageImpl>().getFirst().name,
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
              Atom.to(PagePaths.treatmentProgress);
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
