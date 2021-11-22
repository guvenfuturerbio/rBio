import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:onedosehealth/core/widgets/rbio_stacked_scaffold.dart';
import 'package:onedosehealth/features/chronic_tracking/home/model/page_model.dart';
import 'package:onedosehealth/features/chronic_tracking/home/utils/card_widget.dart';
import 'package:onedosehealth/features/chronic_tracking/progress_sections/glucose_progress/view_model/bg_progress_page_view_model.dart';
import 'package:onedosehealth/features/chronic_tracking/progress_sections/scale_progress/view_model/scale_progress_page_view_model.dart';
import 'package:provider/provider.dart';

part '../vm/mt_home_vm.dart';

class MeasurementTrackingHomeScreen extends StatelessWidget {
  const MeasurementTrackingHomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => MeasurementTrackingVm(),
        child: Consumer<MeasurementTrackingVm>(builder: (_, val, __) {
          return RbioStackedScaffold(
            appbar: RbioAppBar(
              title: RbioAppBar.textTitle(context, "Kronik Takip"),
            ),
            body: ListView(
              padding:
                  EdgeInsets.only(top: RbioStackedScaffold.kHeight(context)),
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
