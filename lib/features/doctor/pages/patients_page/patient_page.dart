import 'package:animated_widgets/animated_widgets.dart';
import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../generated/l10n.dart';
import '../../resources/resources.dart';
import '../../utils/hypo_hyper_edit/hypo_hyper_edit_view_model.dart';
import '../../utils/widgets.dart';
import '../patient_detail_page/patient_detail_page.dart';
import '../patient_detail_page/patient_detail_page_view_model.dart';
import 'patient_page_view_model.dart';

/// MG7
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
}
