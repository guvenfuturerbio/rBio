import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:onedosehealth/core/core.dart';

class MeasurementTrackingHomeScreen extends StatelessWidget {
  const MeasurementTrackingHomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: RbioAppBar(
        title: RbioAppBar.textTitle(context, "Kronik Takip"),
      ),
      body: Column(
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
          RbioElevatedButton(
            title: "Blood Sugar Progress Page",
            onTap: () {
              Atom.to(PagePaths.BLOOD_GLUCOSE_PROGRESS);
            },
          )
        ],
      ),
    );
  }
}
