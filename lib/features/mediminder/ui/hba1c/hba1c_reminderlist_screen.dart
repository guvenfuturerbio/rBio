import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../common/mediminder_common.dart';

class Hba1cReminderListScreen extends StatelessWidget {
  Remindable remindable;

  Hba1cReminderListScreen({Key key, this.remindable}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Hba1cReminderListVm>(
      create: (context) => Hba1cReminderListVm(context),
      child: Consumer<Hba1cReminderListVm>(
        builder: (
          BuildContext context,
          Hba1cReminderListVm value,
          Widget child,
        ) {
          return RbioScaffold(
            extendBodyBehindAppBar: true,
            appbar: RbioAppBar(
              title: RbioAppBar.textTitle(
                context,
                remindable.toShortString(),
              ),
              leading: InkWell(
                child: SvgPicture.asset(Mediminder.instance.back_icon),
                onTap: () =>
                    Navigator.of(context, rootNavigator: true).pop(context),
              ),
            ),
            body: _buildBody(context, value),
            floatingActionButton: _buildFab(context, value),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, Hba1cReminderListVm value) {
    return value.hba1cForScheduled.length != 0
        ? ListView(
            shrinkWrap: true,
            children: [
              ...value.hba1cForScheduled
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                        right: 30,
                        top: 15,
                        bottom: 15,
                      ),
                      child: HbaCard(
                        hbaReminder: item,
                        hbaScheduledVm: value,
                      ),
                    ),
                  )
                  .toList()
            ],
          )
        : Center(
            child: Text(
              LocaleProvider.current.there_are_no_reminders,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Mediminder.instance.gray,
                fontSize: context.TEXTSCALE * 22,
              ),
            ),
          );
  }

  Widget _buildFab(BuildContext context, Hba1cReminderListVm value) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Hba1cReminderAddScreen(
              hba1cIdForNotification: value.generatedIdForSchedule.last,
              remindable: remindable,
            ),
          ),
        );
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
              Mediminder.instance.btnLightBlue,
              Mediminder.instance.btnDarkBlue
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: SvgPicture.asset(
            Mediminder.instance.add_icon,
            color: Mediminder.instance.white,
          ),
        ),
      ),
      backgroundColor: Mediminder.instance.white,
    );
  }
}

class HbaCard extends StatelessWidget {
  final Hba1CForScheduleModel hbaReminder;
  final Hba1cReminderListVm hbaScheduledVm;

  HbaCard({
    Key key,
    this.hbaReminder,
    this.hbaScheduledVm,
  }) : super(key: key);

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
                    (DateTime.parse(hbaReminder.reminderDate).hour.toString() +
                        ':' +
                        DateTime.parse(hbaReminder.reminderDate)
                            .minute
                            .toString()),
                    style: TextStyle(
                      fontSize: 14,
                      color: Mediminder.instance.gray,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => showConfirmationAlertDialog(
                    context,
                    LocaleProvider.current.delete_medicine_title,
                    LocaleProvider.current.delete_medicine_confirm_message,
                    TextButton(
                      style: TextButton.styleFrom(
                          primary: Mediminder.instance.white),
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
                    color: Mediminder.instance.btnDarkBlue,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: SvgPicture.asset(
                        Mediminder.instance.delete_white_garbage),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  void showConfirmationAlertDialog(
    BuildContext context,
    String title,
    String text,
    Widget okButton,
  ) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Mediminder.instance.defaultBlue,
            title: Text(
              title,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            actions: [
              okButton,
            ],
            content: Container(
              padding: const EdgeInsets.all(16.0),
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
