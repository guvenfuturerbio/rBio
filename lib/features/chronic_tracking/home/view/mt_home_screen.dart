import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:onedosehealth/core/widgets/rbio_stacked_scaffold.dart';
import 'package:onedosehealth/features/chronic_tracking/home/model/page_model.dart';
import 'package:onedosehealth/features/chronic_tracking/home/utils/card_widget.dart';
import 'package:onedosehealth/features/chronic_tracking/lib/pages/progress_pages/bg_progress_page/bg_progress_page_view_model.dart';
import 'package:onedosehealth/features/chronic_tracking/lib/pages/progress_pages/scale_progress_page/scale_progress_page_view_model.dart';
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
                ...val.items
                    .map(
                      (element) => SectionCard(
                        isActive: val.activeItem != null &&
                            val.activeItem.key == element.key,
                        isVisible: val.activeItem == null,
                        color: element.color,
                        smallChild: element.smallChild,
                        largeChild: element.largeChild,
                      ),
                    )
                    .toList(),
              ],
            ),
          );
        }));
  }
}
