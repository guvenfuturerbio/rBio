import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onedosehealth/core/extension/extension.dart';
import 'package:onedosehealth/core/locator.dart';
import 'package:onedosehealth/core/theme/main_theme.dart';
import 'package:onedosehealth/core/widgets/rbio_appbar.dart';
import 'package:onedosehealth/core/widgets/rbio_scaffold.dart';
import 'package:onedosehealth/generated/l10n.dart';
import 'package:provider/provider.dart';

import 'hba1c_page.dart';
import 'hba1c_reminderlist_page_vm.dart';
import 'selectedremindable.dart';

class Hba1cReminderListPage extends StatelessWidget {
  const Hba1cReminderListPage({Key key, this.remindable}) : super(key: key);
  final Remindable remindable;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Hba1cListPageVm(context),
      child: Consumer<Hba1cListPageVm>(builder: (context, value, child) {
        return RbioScaffold(
            appbar: RbioAppBar(
              title: RbioAppBar.textTitle(context, remindable.toShortString()),
            ),
            extendBodyBehindAppBar: true,
            body: value.hba1cForScheduled.length != 0
                ? ListView(
                    shrinkWrap: true,
                    children: [
                      ...value.hba1cForScheduled
                          .map((item) => Padding(
                                padding: const EdgeInsets.only(
                                    left: 30, right: 30, top: 15, bottom: 15),
                                child: HbaCard(item, value),
                              ))
                          .toList()
                    ],
                  )
                : Center(
                    child: Text(
                    LocaleProvider.current.there_are_no_reminders,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: R.color.gray, fontSize: context.TEXTSCALE * 22),
                  )),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HbA1cPage(
                            hba1cIdForNotification:
                                value.generatedIdForSchedule.last,
                            remindable: remindable)));
              },
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                      colors: <Color>[
                        getIt<ITheme>().secondaryColor,
                        getIt<ITheme>().mainColor
                      ],
                    )),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: SvgPicture.asset(
                    R.image.add_icon,
                    color: getIt<ITheme>().textColor,
                  ),
                ),
              ),
              backgroundColor: getIt<ITheme>().textColor,
            ));
      }),
    );
  }
}

class HbaCard extends StatelessWidget {
  final Hba1CForSchedule hbaReminder;
  final Hba1cListPageVm hbaScheduledVm;
  HbaCard(this.hbaReminder, this.hbaScheduledVm);

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hbaReminder.reminderDate.substring(0, 10),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                      (DateTime.parse(hbaReminder.reminderDate)
                              .hour
                              .toString() +
                          ':' +
                          DateTime.parse(hbaReminder.reminderDate)
                              .minute
                              .toString()),
                      style: TextStyle(fontSize: 14, color: R.color.gray))
                ],
              ),
              GestureDetector(
                onTap: () => showConfirmationAlertDialog(
                    context,
                    LocaleProvider.current.delete_medicine_title,
                    LocaleProvider.current.delete_medicine_confirm_message,
                    TextButton(
                      style: TextButton.styleFrom(primary: R.color.white),
                      child: Text(LocaleProvider.current.Ok),
                      onPressed: () {
                        hbaScheduledVm.removeScheduledHba1c(hbaReminder);
                        Navigator.of(context).pop();
                      },
                    )),
                child: Container(
                  height: 32,
                  width: 32,
                  margin: EdgeInsets.only(right: 5),
                  decoration: new BoxDecoration(
                    color: R.btnDarkBlue,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: SvgPicture.asset(R.image.delete_white_garbage),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  showConfirmationAlertDialog(
      BuildContext context, String title, String text, Widget okButton) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: R.color.defaultBlue,
            title: Text(
              title,
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            actions: [
              okButton,
            ],
            content: Container(
              padding: const EdgeInsets.all(16.0),
              /*decoration: new BoxDecoration(
            gradient: BlueGradient()),*/
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Text(text,
                      style: new TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
            contentPadding: EdgeInsets.all(0.0),
          );
        });
  }
}
