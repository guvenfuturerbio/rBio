import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../helper/resources.dart';
import '../../../widgets/utils.dart';
import '../../global_bloc.dart';
import '../../models/drug_result.dart';
import '../../models/medicine.dart';
import '../medicine_selection/medicine_period_selection.dart';

enum Remindable { BloodGlucose, Strip, Medication, HbA1c }

extension ParseToString on Remindable {
  String toShortString() {
    switch (this) {
      case Remindable.BloodGlucose:
        return LocaleProvider.current.blood_glucose_measurement;
        break;
      case Remindable.HbA1c:
        return LocaleProvider.current.hbA1c_measurement;
        break;
      case Remindable.Strip:
        return LocaleProvider.current.strip_tracker;
        break;
      case Remindable.Medication:
        return LocaleProvider.current.medication_reminder;
        break;
      default:
        return LocaleProvider.current.error;
    }
  }
}

class SelectedRemindable extends StatelessWidget {
  final Remindable selectedRemindable;
  SelectedRemindable(this.selectedRemindable);

  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);

    return Scaffold(
      appBar: MainAppBar(
          context: context,
          title: TitleAppBarWhite(title: selectedRemindable.toShortString()),
          leading: InkWell(
              child: SvgPicture.asset(R.image.back_icon),
              onTap: () => Navigator.of(context).pop())),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            StreamBuilder<List<Medicine>>(
              stream: _globalBloc.medicineList$,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                } else if (snapshot.data.length == 0) {
                  return Container(
                    color: Color(0xFFF6F8FC),
                    child: Center(
                      child: Text(
                        LocaleProvider.current.press_plus_to_add_medicine,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24,
                            color: Color(0xFFC9C9C9),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                } else {
                  return Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        if (snapshot.data[index].medicineType ==
                            selectedRemindable.toShortString())
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 30, right: 30, top: 15, bottom: 15),
                            child: MedicineCard(snapshot.data[index]),
                          );
                        else
                          return SizedBox();
                      },
                    ),
                  );
                }
              },
            ),
            Padding(
                padding: EdgeInsets.only(top: 16),
                child: Container(
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: R.darkBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      child: Text(LocaleProvider.current.add_reminder,
                          style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MedicinePeriodSelection(
                                      drugResult: DrugResult(
                                          name: selectedRemindable
                                              .toShortString()),
                                      selectedRemindable: selectedRemindable,
                                    )));
                      }),
                ))
            /*       Container(
              color: Color(0xFFF6F8FC),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Provider<GlobalBloc>.value(
                    child: BottomContainer(),
                    value: _globalBloc,
                  ),
                ],
              ),
            ),*/
          ],
        ),
      ),
      /*  floatingActionButton: FloatingActionButton(
        elevation: 4,
        backgroundColor: R.color.blue,
        child: Icon(
          Icons.add,
          color: R.color.white,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MedicineSelection(),
            ),
          );
        },
      ),*/
    );
  }
}

class MedicineCard extends StatelessWidget {
  final Medicine medicine;

  MedicineCard(this.medicine);

  Hero makeIcon(double size) {
    if (medicine.medicineType == "Bottle") {
      return Hero(
        tag: medicine.medicineName + medicine.medicineType,
        child: Icon(
          IconData(0xe900, fontFamily: "Ic"),
          color: R.regularBlue,
          size: size,
        ),
      );
    } else if (medicine.medicineType == "Pill") {
      return Hero(
        tag: medicine.medicineName + medicine.medicineType,
        child: Icon(
          IconData(0xe901, fontFamily: "Ic"),
          color: R.regularBlue,
          size: size,
        ),
      );
    } else if (medicine.medicineType == "Syringe") {
      return Hero(
        tag: medicine.medicineName + medicine.medicineType,
        child: Icon(
          IconData(0xe902, fontFamily: "Ic"),
          color: R.regularBlue,
          size: size,
        ),
      );
    } else if (medicine.medicineType == "Tablet") {
      return Hero(
        tag: medicine.medicineName + medicine.medicineType,
        child: Icon(
          IconData(0xe903, fontFamily: "Ic"),
          color: R.regularBlue,
          size: size,
        ),
      );
    }
    return Hero(
      tag: medicine.medicineName + medicine.medicineType,
      child: Icon(
        Icons.error,
        color: R.regularBlue,
        size: size,
      ),
    );
  }

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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    medicine.startTime,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(medicine.medicinePeriod.toShortString())
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
                        deleteMedicine(context, medicine);
                      },
                    )),
                child: Container(
                  height: 32,
                  width: 32,
                  margin: EdgeInsets.only(right: 5),
                  decoration: new BoxDecoration(
                    color: R.color.defaultBlue,
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

  void deleteMedicine(BuildContext context, Medicine medicine) {
    final GlobalBloc _globalBloc =
        Provider.of<GlobalBloc>(context, listen: false);
    _globalBloc.removeMedicine(medicine);
    Navigator.of(context).pop();
  }
}
