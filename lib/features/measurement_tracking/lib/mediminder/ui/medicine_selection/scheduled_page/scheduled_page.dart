import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onedosehealth/extension/size_extension.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../../../../helper/resources.dart';
import '../../../../widgets/utils.dart';
import '../../../models/drug_result.dart';
import '../../../models/medicine_for_schedule.dart';
import '../../homepage/selectedremindable.dart';
import '../medicine_period_selection.dart';
import 'scheduled_page_vm.dart';

/// MG11

class ScheduledListPage extends StatelessWidget {
  final Remindable remindable;
  ScheduledListPage(this.remindable);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) =>
            ScheduledPageVm(remindable: remindable, context: context),
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: MainAppBar(
              context: context,
              title: TitleAppBarWhite(title: remindable.toShortString()),
              leading: InkWell(
                  child: SvgPicture.asset(R.image.back_icon),
                  onTap: () => Navigator.of(context).pop())),
          body: Consumer<ScheduledPageVm>(
            builder: (context, value, child) =>
                value.medicineForScheduled.length != 0 &&
                        value.medicineForScheduled.any((element) =>
                            element.remindable == remindable.toString())
                    ? ListView(shrinkWrap: true, children: [
                        ...value.medicineForScheduled.map((item) {
                          if (remindable.toString() == item.remindable)
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 30, right: 30, top: 15, bottom: 15),
                              child: MedicineCard(item, value),
                            );
                          else
                            return SizedBox();
                        })
                      ])
                    : Center(
                        child: Text(
                        LocaleProvider.current.there_are_no_reminders,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: R.color.gray,
                            fontSize: context.TEXTSCALE * 22),
                      )),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MedicinePeriodSelection(
                            drugResult:
                                DrugResult(name: remindable.toShortString()),
                            selectedRemindable: remindable,
                          )));
            },
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: <Color>[R.btnLightBlue, R.btnDarkBlue],
                  )),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: SvgPicture.asset(
                  R.image.add_icon,
                  color: R.color.white,
                ),
              ),
            ),
            backgroundColor: R.color.white,
          ),
        ));
  }
}

class MedicineCard extends StatelessWidget {
  final MedicineForScheduled medicine;
  final ScheduledPageVm scheduledPageVm;
  MedicineCard(this.medicine, this.scheduledPageVm);

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
                    medicine.time +
                        (medicine.remindable == Remindable.Medication.toString()
                            ? " " + medicine.name
                            : " "),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(medicine.medicinePeriod ==
                          MedicinePeriod.SPECIFIC_DAYS.toString()
                      ? (LocaleProvider.current.every +
                              " " +
                              scheduledPageVm.setDayString(medicine.dayIndex)) +
                          (", " +
                              scheduledPageVm.setUsageType(medicine.usageType))
                      : scheduledPageVm
                              .setPeriodString(medicine.medicinePeriod) +
                          (", " +
                              scheduledPageVm
                                  .setUsageType(medicine.usageType)) +
                          (medicine.remindable ==
                                  Remindable.Medication.toString()
                              ? ", " +
                                  medicine.dosage.toString() +
                                  " " +
                                  LocaleProvider.current.hint_dosage
                              : " "))
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
                        scheduledPageVm.removeScheduledMedicine(medicine);
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
