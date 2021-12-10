import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';
import '../../utils/hypo_hyper_edit/hypo_hyper_edit_view_model.dart';
import '../patient_detail_page/patient_detail_page.dart';
import '../patient_detail_page/patient_detail_page_view_model.dart';
import 'patient_page_view_model.dart';

class PatientPage extends StatefulWidget {
  @override
  _PatientPageState createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PatientPageViewModel(context: context),
      child: Consumer<PatientPageViewModel>(
        builder: (context, value, child) {
          return SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Column(
                    children: [
                      /*Container(
                        child: TextFormField(
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          style: inputTextStyle(),
                          decoration: inputImageDecoration(
                            hintText: " ",
                            image: R.image.search,
                          ),
                        ),
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: inputBoxDecoration(),
                      ),*/
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DropdownButton<String>(
                            value: value.selectedItem,
                            icon: Icon(
                              Icons.arrow_downward,
                              color: Colors.black,
                            ),
                            iconSize: 24,
                            elevation: 16,
                            underline: Container(
                              height: 2,
                              color: Colors.black,
                            ),
                            onChanged: (String newValue) {
                              value.setSelectedItem(newValue);
                            },
                            items: value.items
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          value.selectedItem == LocaleProvider.current.specific
                              ? Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextButton(
                                            onPressed: () {
                                              DatePicker.showDatePicker(context,
                                                  showTitleActions: true,
                                                  minTime: DateTime(2000, 1, 1),
                                                  maxTime: DateTime.now(),
                                                  onChanged: (date) {},
                                                  onConfirm: (date) {
                                                value.setStartDate(date);
                                              },
                                                  currentTime: DateTime.now(),
                                                  locale: LocaleType.tr);
                                            },
                                            child: Text(
                                              DateFormat.yMMMd(
                                                      Intl.getCurrentLocale())
                                                  .format(value.startDate),
                                              textAlign: TextAlign.center,
                                            )),
                                      ),
                                      Expanded(
                                        child: TextButton(
                                            onPressed: () {
                                              DatePicker.showDatePicker(context,
                                                  showTitleActions: true,
                                                  minTime: value.startDate,
                                                  maxTime: DateTime.now(),
                                                  onChanged: (date) {},
                                                  onConfirm: (date) {
                                                value.setEndDate(date);
                                              },
                                                  currentTime: DateTime.now(),
                                                  locale: LocaleType.tr);
                                            },
                                            child: Text(
                                              DateFormat.yMMMd(
                                                      Intl.getCurrentLocale())
                                                  .format(value.endDate),
                                              textAlign: TextAlign.center,
                                            )),
                                      ),
                                    ],
                                  ),
                                )
                              : Spacer(),
                          InkWell(
                            onTap: () {
                              value.setSelectedItem(value.selectedItem);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: ShakeAnimatedWidget(
                                duration: Duration(seconds: 5),
                                shakeAngle: Rotation.deg(z: 360),
                                curve: Curves.linear,
                                enabled:
                                    value.stateProcess == StateProcess.LOADING
                                        ? true
                                        : false,
                                child: Icon(Icons.refresh_rounded,
                                    color: R.color.mainColor, size: 34),
                              ),
                            ),
                          )
                        ],
                      ),
                      value.stateProcess == StateProcess.LOADING
                          ? _shimmer(context)
                          : _buildPosts(context)
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _shimmer(BuildContext context) {
    return ListView.builder(
      itemCount: 30,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: 8, bottom: 8),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          child: patientInfo(context: context, onPressed: () {}),
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
        );
      },
    );
  }

  Widget _buildPosts(BuildContext context) {
    return Consumer<PatientPageViewModel>(
      builder: (context, value, child) {
        return ListView.builder(
          itemCount: value.patientList.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(top: 8, bottom: 8),
          itemBuilder: (context, index) {
            return patientInfo(
                patient: value.patientList[index],
                onPressed: (patientId) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => MultiProvider(providers: [
                                ChangeNotifierProvider(
                                  create: (ctx) => PatientDetailPageViewModel(
                                      context: ctx, patientId: patientId),
                                ),
                              ], child: PatientDetailPage())));
                  /*  Routes.PATIENT_DETAIL,
                      arguments: patientId); */
                },
                context: context);
          },
        );
      },
    );
  }

  Widget patientInfo({
    BuildContext context,
    DoctorPatientModel patient,
    Function onPressed,
  }) {
    return InkWell(
      onTap: () {
        onPressed(patient.id);
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 20),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Text(
                          LocaleProvider.current.name_surname,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: R.color.title,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          LocaleProvider.current.diabet_type,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: R.color.title,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Text(
                          patient?.name ?? "",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: R.color.text,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          patient?.diabetType?.name ?? "",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: R.color.text,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              LocaleProvider.current.last_bg,
                              style: TextStyle(
                                  color: R.color.text,
                                  fontWeight: FontWeight.w600),
                            ),
                            measurementBox(context: context, patient: patient)
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              LocaleProvider.current.hypo,
                              style: TextStyle(
                                  color: R.color.text,
                                  fontWeight: FontWeight.w600),
                            ),
                            hypo(context: context, patient: patient)
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              LocaleProvider.current.hyper,
                              style: TextStyle(
                                  color: R.color.text,
                                  fontWeight: FontWeight.w600),
                            ),
                            hyper(context: context, patient: patient)
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      hungaryState(
                          context: context,
                          image: R.image.beforeMeal,
                          count: patient?.type1Count ?? 0),
                      hungaryState(
                          context: context,
                          image: R.image.afterMeal,
                          count: patient?.type2Count ?? 0),
                      hungaryState(
                          context: context,
                          image: R.image.other,
                          count: patient?.type3Count ?? 0),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  )
                ],
              ),
            ),
            Icon(Icons.navigate_next)
          ],
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            gradient: LinearGradient(colors: [
              Colors.white,
              Colors.white,
            ], begin: Alignment.topLeft, end: Alignment.topRight),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withAlpha(50),
                  blurRadius: 15,
                  spreadRadius: 0,
                  offset: Offset(5, 10))
            ]),
      ),
    );
  }

  Widget hungaryState({BuildContext context, String image, int count}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SvgPicture.asset(image,
            width: MediaQuery.of(context).size.width * 0.05,
            height: MediaQuery.of(context).size.width * 0.05),
        SizedBox(width: MediaQuery.of(context).size.width * 0.01),
        Text(count?.toString() ?? "", style: TextStyle(color: R.color.text))
      ],
    );
  }

  Widget hypo({
    BuildContext context,
    int width,
    int height,
    DoctorPatientModel patient,
  }) {
    return Container(
      alignment: Alignment.center,
      width: width ?? MediaQuery.of(context).size.width * 0.15,
      height: height ?? MediaQuery.of(context).size.width * 0.15,
      child: Text(
        (((patient?.hypo ?? "-") == "-" || (patient?.hypo ?? "") == "")
                ? "-"
                : patient.hypo) +
            "\nmg/dL",
        style: TextStyle(color: R.color.text, fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16)),
          gradient: LinearGradient(colors: [
            ((patient?.hypo ?? "-") == "-" || (patient?.hypo ?? "") == "")
                ? Colors.white
                : Utils.instance.fetchMeasurementColor(
                    measurement: toIntFunc(patient?.hypo ?? ""),
                    criticMin: patient?.alertMin ?? 0,
                    criticMax: patient?.alertMax ?? 0,
                    targetMax: patient?.normalMax ?? 0,
                    targetMin: patient?.normalMin ?? 0),
            ((patient?.hypo ?? "-") == "-" || (patient?.hypo ?? "") == "")
                ? Colors.white
                : Utils.instance.fetchMeasurementColor(
                    measurement: toIntFunc(patient?.hypo ?? ""),
                    criticMin: patient?.alertMin ?? 0,
                    criticMax: patient?.alertMax ?? 0,
                    targetMax: patient?.normalMax ?? 0,
                    targetMin: patient?.normalMin ?? 0),
          ], begin: Alignment.topLeft, end: Alignment.topRight),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withAlpha(50),
                blurRadius: 15,
                spreadRadius: 0,
                offset: Offset(5, 10))
          ]),
    );
  }

  Widget hyper({
    BuildContext context,
    int width,
    int height,
    DoctorPatientModel patient,
  }) {
    return Container(
      alignment: Alignment.center,
      width: width ?? MediaQuery.of(context).size.width * 0.15,
      height: height ?? MediaQuery.of(context).size.width * 0.15,
      child: Text(
        (((patient?.hyper ?? "-") == "-" || (patient?.hyper ?? "") == "")
                ? "-"
                : patient.hyper) +
            "\nmg/dL",
        style: TextStyle(color: R.color.text, fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16)),
          gradient: LinearGradient(colors: [
            ((patient?.hyper ?? "-") == "-" || (patient?.hyper ?? "") == "")
                ? Colors.white
                : Utils.instance.fetchMeasurementColor(
                    measurement: toIntFunc(patient?.hyper ?? ""),
                    criticMin: patient?.alertMin ?? 0,
                    criticMax: patient?.alertMax ?? 0,
                    targetMax: patient?.normalMax ?? 0,
                    targetMin: patient?.normalMin ?? 0),
            ((patient?.hyper ?? "-") == "-" || (patient?.hyper ?? "") == "")
                ? Colors.white
                : Utils.instance.fetchMeasurementColor(
                    measurement: toIntFunc(patient?.hyper ?? ""),
                    criticMin: patient?.alertMin ?? 0,
                    criticMax: patient?.alertMax ?? 0,
                    targetMax: patient?.normalMax ?? 0,
                    targetMin: patient?.normalMin ?? 0),
          ], begin: Alignment.topLeft, end: Alignment.topRight),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withAlpha(50),
                blurRadius: 15,
                spreadRadius: 0,
                offset: Offset(5, 10))
          ]),
    );
  }

  Widget measurementBox({
    BuildContext context,
    int width,
    int height,
    DoctorPatientModel patient,
  }) {
    return Container(
      alignment: Alignment.center,
      width: width ?? MediaQuery.of(context).size.width * 0.15,
      height: height ?? MediaQuery.of(context).size.width * 0.15,
      child: Text(
        (((patient?.lastBg ?? "-") == "-" || (patient?.lastBg ?? "") == "")
                ? "-"
                : patient.lastBg) +
            "\nmg/dL",
        style: TextStyle(color: R.color.text, fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        gradient: LinearGradient(
          colors: [
            ((patient?.lastBg ?? "-") == "-" || (patient?.lastBg ?? "") == "")
                ? Colors.white
                : Utils.instance.fetchMeasurementColor(
                    measurement: toIntFunc(patient?.lastBg ?? ""),
                    criticMin: patient?.alertMin ?? 0,
                    criticMax: patient?.alertMax ?? 0,
                    targetMax: patient?.normalMax ?? 0,
                    targetMin: patient?.normalMin ?? 0),
            ((patient?.lastBg ?? "-") == "-" || (patient?.lastBg ?? "") == "")
                ? Colors.white
                : Utils.instance.fetchMeasurementColor(
                    measurement: toIntFunc(patient?.lastBg ?? ""),
                    criticMin: patient?.alertMin ?? 0,
                    criticMax: patient?.alertMax ?? 0,
                    targetMax: patient?.normalMax ?? 0,
                    targetMin: patient?.normalMin ?? 0),
          ],
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            blurRadius: 15,
            spreadRadius: 0,
            offset: Offset(5, 10),
          ),
        ],
      ),
    );
  }

  int toIntFunc(String text) {
    if (text == null) {
      return 0;
    } else if (text.length > 0) {
      return int.parse(text);
    } else {
      return 0;
    }
  }
}
