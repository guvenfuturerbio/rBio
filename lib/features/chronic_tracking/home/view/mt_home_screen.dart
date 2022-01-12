import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../progress_sections/glucose_progress/view_model/bg_progress_page_view_model.dart';
import '../../progress_sections/pressure_progress/view/pressure_progres_page.dart';
import '../../progress_sections/scale_progress/view_model/scale_progress_page_view_model.dart';
import '../model/page_model.dart';
import '../utils/card_widget.dart';

part '../vm/mt_home_vm.dart';

class MeasurementTrackingHomeScreen extends StatelessWidget {
  const MeasurementTrackingHomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MeasurementTrackingVm(),
      child: Consumer<MeasurementTrackingVm>(
        builder: (BuildContext context, MeasurementTrackingVm vm, Widget chil) {
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

  RbioAppBar _buildAppBar(bool isLandscape, BuildContext context) {
    return isLandscape
        ? null
        : RbioAppBar(
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
      case LoadingProgress.LOADING:
        return RbioLoading();

      case LoadingProgress.DONE:
        return _buildList(context, vm, isLandscape);

      case LoadingProgress.ERROR:
        return RbioBodyError();

      default:
        return SizedBox();
    }
  }

  Widget _buildList(
    BuildContext context,
    MeasurementTrackingVm vm,
    bool isLandscape,
  ) {
    return ListView(
      physics: ClampingScrollPhysics(),
      padding: isLandscape
          ? null
          : EdgeInsets.only(top: RbioStackedScaffold.kHeight(context)),
      children: [
        //
        Card(
          child: getIt<ProfileStorageImpl>().getAll().length > 1
              ? ExpandablePanel(
                  header: RbioUserTile(
                    width: Atom.width,
                    name: getIt<ProfileStorageImpl>().getFirst().name,
                    onTap: () {},
                    leadingImage: UserLeadingImage.Circle,
                  ),
                  collapsed: SizedBox(),
                  expanded: getIt<ProfileStorageImpl>().getAll().length > 1
                      ? Column(
                          children: getIt<ProfileStorageImpl>()
                              .getAll()
                              .map(
                                (e) => RbioUserTile(
                                  width: Atom.width,
                                  name: e.name,
                                  onTap: () {},
                                  leadingImage: UserLeadingImage.Circle,
                                ),
                              )
                              .cast<Widget>()
                              .toList(),
                        )
                      : SizedBox(),
                )
              : RbioUserTile(
                  width: Atom.width,
                  name: getIt<ProfileStorageImpl>().getFirst().name,
                  onTap: () {},
                  leadingImage: UserLeadingImage.Circle,
                ),
        ),

        //
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            color: vm.activeItem != null ? Colors.transparent : Colors.white,
            boxShadow: vm.activeItem != null
                ? [BoxShadow(color: Colors.transparent)]
                : null,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(17),
            child: Column(
              children: vm.items
                  .map(
                    (parentElement) => SectionCard(
                      isActive: vm.activeItem != null &&
                          vm.activeItem.key == parentElement.key,
                      isVisible: vm.activeItem == null,
                      smallChild: parentElement.smallChild,
                      largeChild: parentElement.largeChild,
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

  FloatingActionButton _buildFAB(MeasurementTrackingVm val) {
    return val.activeItem != null
        ? FloatingActionButton(
            heroTag: 'adder',
            onPressed: () {
              val.activeItem.manuelEntry();
            },
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: getIt<ITheme>().mainColor,
              ),
              child: Padding(
                padding: EdgeInsets.all(15),
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
}
