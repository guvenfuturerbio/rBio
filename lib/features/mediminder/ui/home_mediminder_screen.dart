import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

import '../common/mediminder_common.dart';

class HomeMediminderScreen extends StatelessWidget {
  const HomeMediminderScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RbioAppBar(
        title: RbioAppBar.textTitle(
          context,
          LocaleProvider.current.reminders,
        ),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      padding: EdgeInsets.only(top: 6),
      children: [
        _buildCard(
          context,
          Mediminder.instance.blood_icon_black,
          Remindable.BloodGlucose,
        ),
        _buildCard(
          context,
          Mediminder.instance.strip_icon_black,
          Remindable.Strip,
        ),
        _buildCard(
          context,
          Mediminder.instance.medicine_icon_black,
          Remindable.Medication,
        ),
        _buildCard(
          context,
          Mediminder.instance.hba1c_icon_black,
          Remindable.HbA1c,
        ),
      ],
    );
  }

  Widget _buildCard(BuildContext context, String icon, Remindable remindable) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                switch (remindable) {
                  case Remindable.BloodGlucose:
                    return MedicationScreen(remindable: remindable);

                  case Remindable.Strip:
                    return StripScreen();

                  case Remindable.Medication:
                    return MedicationScreen(remindable: remindable);

                  case Remindable.HbA1c:
                    return Hba1cReminderListScreen(remindable: remindable);

                  default:
                    return SizedBox();
                }
              },
            ),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    icon,
                    width: 45 * context.TEXTSCALE,
                    height: 45 * context.TEXTSCALE,
                  ),
                ),
                Expanded(
                  child: Text(
                    remindable.toShortString(),
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
