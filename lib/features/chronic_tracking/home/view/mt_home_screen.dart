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
        child: Consumer<MeasurementTrackingVm>(builder: (_, val, __) {
          bool isLandscape =
              context.xMediaQuery.orientation == Orientation.landscape &&
                  !Atom.isWeb;
          return RbioStackedScaffold(
            appbar: isLandscape
                ? null
                : RbioAppBar(
                    title: RbioAppBar.textTitle(
                        context, LocaleProvider.current.chronic_track_home),
                  ),
            floatingActionButton: val.activeItem != null
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
                : null,
            body: val.state == LoadingProgress.LOADING
                ? Center(child: CircularProgressIndicator())
                : val.state == LoadingProgress.ERROR
                    ? Center(
                        child: Text('Error'),
                      )
                    : ListView(
                        physics: ClampingScrollPhysics(),
                        padding: isLandscape
                            ? null
                            : EdgeInsets.only(
                                top: RbioStackedScaffold.kHeight(context)),
                        children: [
                          //
                          Card(
                            child: getIt<ProfileStorageImpl>().getAll().length >
                                    1
                                ? ExpandablePanel(
                                    header: RbioUserTile(
                                      width: Atom.width,
                                      name: getIt<ProfileStorageImpl>()
                                          .getFirst()
                                          .name,
                                      onTap: () {},
                                      leadingImage: UserLeadingImage.Circle,
                                    ),
                                    collapsed: SizedBox(),
                                    expanded: getIt<ProfileStorageImpl>()
                                                .getAll()
                                                .length >
                                            1
                                        ? Column(
                                            children:
                                                getIt<ProfileStorageImpl>()
                                                    .getAll()
                                                    .map((e) => RbioUserTile(
                                                          width: Atom.width,
                                                          name: e.name,
                                                          onTap: () {},
                                                          leadingImage:
                                                              UserLeadingImage
                                                                  .Circle,
                                                        ))
                                                    .cast<Widget>()
                                                    .toList(),
                                          )
                                        : SizedBox(),
                                  )
                                : RbioUserTile(
                                    width: Atom.width,
                                    name: getIt<ProfileStorageImpl>()
                                        .getFirst()
                                        .name,
                                    onTap: () {},
                                    leadingImage: UserLeadingImage.Circle,
                                  ),
                          ),

                          //
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17),
                              color: val.activeItem != null
                                  ? Colors.transparent
                                  : Colors.white,
                              boxShadow: val.activeItem != null
                                  ? [BoxShadow(color: Colors.transparent)]
                                  : null,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(17),
                              child: Column(
                                children: val.items
                                    .map(
                                      (parentElement) => SectionCard(
                                          isActive: val.activeItem != null &&
                                              val.activeItem.key ==
                                                  parentElement.key,
                                          isVisible: val.activeItem == null,
                                          smallChild: parentElement.smallChild,
                                          largeChild: parentElement.largeChild,
                                          hasDivider: val.activeItem == null &&
                                              val.items.indexWhere((element) =>
                                                      element.key ==
                                                      parentElement.key) <
                                                  val.items.length - 1),
                                    )
                                    .toList(),
                              ),
                            ),
                          )
                        ],
                      ),
          );
        }));
  }
}
