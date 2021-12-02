import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/core.dart';
import '../../../../core/widgets/rbio_stacked_scaffold.dart';
import '../model/page_model.dart';
import '../utils/card_widget.dart';
import '../../progress_sections/glucose_progress/view_model/bg_progress_page_view_model.dart';
import '../../progress_sections/scale_progress/view_model/scale_progress_page_view_model.dart';
import 'package:provider/provider.dart';

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
                    title: RbioAppBar.textTitle(context, "Kronik Takip"),
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
                          R.image.add_icon,
                          color: R.color.white,
                        ),
                      ),
                    ),
                    backgroundColor: R.color.white,
                  )
                : null,
            body: ListView(
              physics: ClampingScrollPhysics(),
              padding: isLandscape
                  ? null
                  : EdgeInsets.only(top: RbioStackedScaffold.kHeight(context)),
              children: [
                Card(
                  child: ExpandablePanel(
                    header: RbioUserTile(
                        width: Atom.width,
                        name: "Ayşe Yıldırım",
                        onTap: () {},
                        leadingImage: UserLeadingImage.Circle),
                    collapsed: SizedBox(),
                    expanded: Column(
                      children: [
                        RbioUserTile(
                            width: Atom.width,
                            name: "Murat Yıldırım",
                            onTap: () {},
                            leadingImage: UserLeadingImage.Circle),
                        RbioUserTile(
                            width: Atom.width,
                            name: "Aziz Yıldırım",
                            onTap: () {},
                            leadingImage: UserLeadingImage.Circle)
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17)),
                  color: val.activeItem != null ? Colors.transparent : null,
                  shadowColor:
                      val.activeItem != null ? Colors.transparent : null,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(17),
                    child: Column(
                      children: val.items
                          .map(
                            (parentElement) => SectionCard(
                                isActive: val.activeItem != null &&
                                    val.activeItem.key == parentElement.key,
                                isVisible: val.activeItem == null,
                                color: parentElement.color,
                                smallChild: parentElement.smallChild,
                                largeChild: parentElement.largeChild,
                                hasDivider: val.activeItem == null &&
                                    val.items.indexWhere((element) =>
                                            element.key == parentElement.key) <
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
