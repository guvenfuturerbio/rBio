import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:onedosehealth/core/enums/remindable.dart';
import 'package:onedosehealth/features/mediminder/ui/strip/view/strip_screen.dart';

import '../hba1c/list_hba1c/view/hba1c_reminderlist_screen.dart';
import '../medication/medication_screen/view/medication_screen.dart';

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
          R.image.blood_icon_black,
          Remindable.BloodGlucose,
        ),
        _buildCard(
          context,
          R.image.strip_icon_black,
          Remindable.Strip,
        ),
        _buildCard(
          context,
          R.image.medicine_icon_black,
          Remindable.Medication,
        ),
        _buildCard(
          context,
          R.image.hba1c_icon_black,
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
          switch (remindable) {
            case Remindable.BloodGlucose:
              Atom.to(PagePaths.BLOOD_GLUCOSE_PAGE, queryParameters: {
                'remindable': remindable.toParseableString()
              });
              break;
            case Remindable.Strip:
              Atom.to(PagePaths.STRIP_PAGE);
              break;
            case Remindable.Medication:
              Atom.to(PagePaths.MEDICATION_SCREEN, queryParameters: {
                'remindable': remindable.toParseableString()
              });
              break;
            case Remindable.HbA1c:
              Atom.to(PagePaths.HBA1C_REMINDER_ADD, queryParameters: {
                'remindable': remindable.toParseableString()
              });
              break;
            default:
              return SizedBox();
              break;
          }
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
                    style: context.xHeadline3
                        .copyWith(color: getIt<ITheme>().textColorSecondary),
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
