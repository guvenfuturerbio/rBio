import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/extension/size_extension.dart';

import '../medicine_selection/scheduled_page/scheduled_page.dart';
import 'hba1c_reminderlist_page.dart';
import 'selectedremindable.dart';
import 'strippage.dart';

class RemindableCard extends StatelessWidget {
  final String icon;
  final Remindable remindable;
  RemindableCard(this.icon, this.remindable);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: () {
          if (remindable == Remindable.Strip) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StripPage(),
              ),
            );
          } else if (remindable == Remindable.HbA1c) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    Hba1cReminderListPage(remindable: remindable),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ScheduledListPage(
                      remindable) //SelectedRemindable(remindable),
                  ),
            );
          }
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
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
                  child: Text(remindable.toShortString(),
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.black,
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
