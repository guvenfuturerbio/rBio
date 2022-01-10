import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../core/core.dart';
import '../../../core/enums/remindable.dart';
import '../mediminder.dart';

// ignore: must_be_immutable
class MedicationScreen extends StatelessWidget {
  Remindable remindable;

  MedicationScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      remindable = Atom.queryParameters['remindable'].toRemindable();
    } catch (e) {
      return RbioRouteError();
    }

    return ChangeNotifierProvider<MedicationVm>(
      create: (context) => MedicationVm(context),
      child: RbioScaffold(
        extendBodyBehindAppBar: true,
        appbar: _buildAppBar(context),
        body: _buildBody(),
        floatingActionButton: _buildFab(context),
      ),
    );
  }

  RbioAppBar _buildAppBar(BuildContext context) {
    return RbioAppBar(
      title: RbioAppBar.textTitle(
        context,
        remindable.toShortString(),
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
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              ...value.medicineForScheduled.map(
                (item) {
                  if (remindable.toString() == item.remindable)
                    return MedicineCard(medicine: item, medicationVm: value);
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
              style: context.xHeadline3.copyWith(color: getIt<ITheme>().grey),
            ),
          );
        }
      },
    );
  }

  Widget _buildFab(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: getIt<ITheme>().mainColor,
      onPressed: () {
        Atom.to(
          PagePaths.MEDICATION_PERIOD,
          queryParameters: {
            'drugResult': jsonEncode(
              DrugResultModel(name: remindable.toShortString()).toJson(),
            ),
            'remindable': remindable.toParseableString()
          },
        );
      },
      child: Padding(
        padding: EdgeInsets.all(15),
        child: SvgPicture.asset(
          R.image.add,
          color: getIt<ITheme>().cardBackgroundColor,
        ),
      ),
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
    return Container(
      decoration: BoxDecoration(
        color: getIt<ITheme>().cardBackgroundColor,
        borderRadius: R.sizes.borderRadiusCircular,
      ),
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          //
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                Text(
                  medicine.time +
                      (medicine.remindable == Remindable.Medication.toString()
                          ? " " + medicine.name
                          : " "),
                  style:
                      context.xHeadline3.copyWith(fontWeight: FontWeight.bold),
                ),

                //
                Text(
                  medicationVm.getSubTitle(medicine),
                  style: context.xHeadline5,
                ),
              ],
            ),
          ),

          //
          GestureDetector(
            onTap: () => showConfirmationAlertDialog(
              context,
              LocaleProvider.current.delete_medicine_title,
              LocaleProvider.current.delete_medicine_confirm_message,
              TextButton(
                style: TextButton.styleFrom(primary: getIt<ITheme>().textColor),
                child: Text(LocaleProvider.current.Ok),
                onPressed: () {
                  medicationVm.removeMedicine(medicine);
                  Atom.dismiss();
                },
              ),
            ),
            child: Container(
              height: 32,
              width: 32,
              margin: EdgeInsets.only(right: 5),
              decoration: new BoxDecoration(
                color: getIt<ITheme>().mainColor,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: EdgeInsets.all(5),
                child: SvgPicture.asset(R.image.delete_white_garbage),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showConfirmationAlertDialog(
    BuildContext context,
    String title,
    String text,
    Widget okButton,
  ) {
    Atom.show(
      AlertDialog(
        backgroundColor: getIt<ITheme>().mainColor,
        title: Text(
          title,
          style: context.xHeadline1.copyWith(
            color: getIt<ITheme>().textColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: R.sizes.borderRadiusCircular,
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
                style: context.xHeadline3
                    .copyWith(color: getIt<ITheme>().textColor),
              ),
            ],
          ),
        ),
        contentPadding: EdgeInsets.all(0.0),
      ),
    );
  }
}
