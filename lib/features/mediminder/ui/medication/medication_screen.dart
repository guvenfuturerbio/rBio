import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../common/mediminder_common.dart';

class MedicationScreen extends StatelessWidget {
  Remindable remindable;

  MedicationScreen({Key key, this.remindable}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MedicationVm>(
      create: (context) => MedicationVm(context),
      child: RbioScaffold(
        extendBodyBehindAppBar: true,
        appbar: RbioAppBar(
          title: RbioAppBar.textTitle(
            context,
            remindable.toShortString(),
          ),
        ),
        body: _buildBody(),
        floatingActionButton: _buildFab(context),
      ),
    );
  }

  Widget _buildBody() {
    return Consumer<MedicationVm>(
      builder: (
        BuildContext context,
        MedicationVm value,
        Widget child,
      ) {
        if (value.medicineForScheduled.length != 0 &&
            value.medicineForScheduled.any(
              (element) => element.remindable == remindable.toString(),
            )) {
          return ListView(
            shrinkWrap: true,
            children: [
              ...value.medicineForScheduled.map(
                (item) {
                  if (remindable.toString() == item.remindable)
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                        right: 30,
                        top: 15,
                        bottom: 15,
                      ),
                      child: MedicineCard(medicine: item, medicationVm: value),
                    );
                  else
                    return SizedBox();
                },
              )
            ],
          );
        } else {
          return Center(
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
      },
    );
  }

  Widget _buildFab(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MedicationPeriodSelectionScreen(
              drugResult: DrugResultModel(name: remindable.toShortString()),
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

class MedicineCard extends StatelessWidget {
  final MedicineForScheduledModel medicine;
  final MedicationVm medicationVm;

  MedicineCard({
    Key key,
    this.medicine,
    this.medicationVm,
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
            //
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
                Text(
                  medicationVm.getSubTitle(medicine),
                ),
              ],
            ),

            //
            GestureDetector(
              onTap: () => showConfirmationAlertDialog(
                context,
                LocaleProvider.current.delete_medicine_title,
                LocaleProvider.current.delete_medicine_confirm_message,
                TextButton(
                  style:
                      TextButton.styleFrom(primary: Mediminder.instance.white),
                  child: Text(LocaleProvider.current.Ok),
                  onPressed: () {
                    medicationVm.removeMedicine(medicine);
                    Navigator.of(context).pop();
                  },
                ),
              ),
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
            ),
          ],
        ),
      ),
    );
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  text,
                  style: new TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          contentPadding: EdgeInsets.all(0.0),
        );
      },
    );
  }
}
