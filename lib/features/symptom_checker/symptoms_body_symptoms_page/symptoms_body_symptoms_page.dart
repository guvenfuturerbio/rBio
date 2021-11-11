import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:onedosehealth/core/widgets/rbio_appbar.dart';
import 'package:onedosehealth/model/model.dart';
import 'package:provider/provider.dart';

import '../symptoms_body_sublocations_page/symptoms_body_sublocations_page.dart';
import '../symptoms_body_sublocations_page/symptoms_body_sublocations_vm.dart';
import '../symptoms_result_page/symptoms_result_page.dart';
import '../symptoms_result_page/symptoms_result_page_vm.dart';
import 'symptoms_body_symptoms_page_vm.dart';

class BodySymptomsSelectionPage extends StatefulWidget {
  const BodySymptomsSelectionPage({
    Key key,
    this.selectedBodySymptoms,
    this.selectedGenderId,
    this.yearOfBirth,
    this.selectedBodyLocation,
    this.isFromVoice,
    this.myPv,
  }) : super(key: key);

  final List<GetBodySymptomsResponse> selectedBodySymptoms;
  final int selectedGenderId;
  final String yearOfBirth;
  final GetBodyLocationResponse selectedBodyLocation;
  final bool isFromVoice;
  final BodySublocationsVm myPv;

  @override
  _BodySymptomsSelectionPageState createState() =>
      _BodySymptomsSelectionPageState();
}

class _BodySymptomsSelectionPageState extends State<BodySymptomsSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BodySymptomSelectionVm(
          context: context,
          genderId: widget.selectedGenderId,
          symptomList: widget.myPv.selectedSymptoms,
          year_of_birth: widget.yearOfBirth,
          isFromVoice: widget.isFromVoice,
          myPv: widget.myPv),
      child: Consumer<BodySymptomSelectionVm>(builder: (context, value, child) {
        return Scaffold(
          appBar: RbioAppBar(
            title: RbioAppBar.textTitle(
                context, LocaleProvider.of(context).my_symptoms),
          ),
          body: SafeArea(
              child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 25, top: 25),
                        child: Text(
                          widget.selectedGenderId == 0
                              ? LocaleProvider.of(context).gender_male
                              : widget.selectedGenderId == 1
                                  ? LocaleProvider.of(context).gender_female
                                  : widget.selectedGenderId == 2
                                      ? LocaleProvider.of(context).boy
                                      : LocaleProvider.of(context).girl,
                          style: TextStyle(
                              color: R.color.online_appointment,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 35),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            widget.selectedBodyLocation.name,
                            style: TextStyle(
                                color: R.color.online_appointment,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 35),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 30.0),
                          child: Text(
                            LocaleProvider.of(context).your_complaints,
                            style: TextStyle(
                                color: R.color.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      )
                    ],
                  ),
                  Flexible(
                    flex: 3,
                    child: Column(
                      children: [
                        Container(
                          height: value.selectedBodySymptoms.length * 40.0 >
                                  MediaQuery.of(context).size.height * 0.25
                              ? MediaQuery.of(context).size.height * 0.25
                              : value.selectedBodySymptoms.length * 40.0,
                          child: ListView.builder(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width / 7),
                              itemCount: value.selectedBodySymptoms.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${value.selectedBodySymptoms[index].name}',
                                          style: TextStyle(
                                              color: R.color.online_appointment,
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        GestureDetector(
                                            onTap: () async {
                                              await value.removeSemptomFromList(
                                                  value.selectedBodySymptoms[
                                                      index]);
                                              await widget.myPv
                                                  .removeSemptomFromList(widget
                                                      .myPv
                                                      .selectedSymptoms[index]);
                                              await value.fetchProposedSymptoms(
                                                  value.selectedBodySymptoms,
                                                  widget.selectedGenderId,
                                                  widget.yearOfBirth);
                                            },
                                            child: Icon(Icons.close)),
                                      ],
                                    ),
                                    Divider(
                                      thickness: 1,
                                    )
                                  ],
                                );
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 15, 8, 30),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.5,
                            decoration: BoxDecoration(
                                color: value.selectedBodySymptoms.length != 0
                                    ? null
                                    : R.color.online_appointment
                                        .withOpacity(0.3),
                                borderRadius: BorderRadius.circular(40)),
                            child: FlatButton(
                                color: Colors.transparent,
                                onPressed: () {
                                  Navigator.pop(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          BodySubLocationsPage(
                                        selectedBodyLocation:
                                            widget.selectedBodyLocation,
                                        yearOfBirth: widget.yearOfBirth,
                                        selectedGenderId:
                                            widget.selectedGenderId,
                                        isFromVoice: false,
                                      ),
                                    ),
                                    // ignore: unnecessary_statements
                                  );
                                },
                                child: Text(
                                  LocaleProvider.of(context).add_symptom,
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                        ),
                        value.proposedProgress == LoadingProgress.LOADING
                            ? RbioLoading()
                            : Visibility(
                                visible: value.proposedSymptomList.length != 0
                                    ? true
                                    : false,
                                child: Flexible(
                                  flex: 5,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 12.0),
                                        child: Text(
                                          LocaleProvider
                                              .current.proposed_symptom,
                                          style: TextStyle(
                                              color: R.color.grey
                                                  .withOpacity(0.7)),
                                        ),
                                      ),
                                      Container(
                                        height: value.proposedSymptomList
                                                        .length *
                                                    40.0 >
                                                MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.25
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.25
                                            : value.proposedSymptomList.length *
                                                40.0,
                                        child: ListView.builder(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        7),
                                            itemCount: value
                                                .proposedSymptomList.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        '${value.proposedSymptomList[index].name}',
                                                        style: TextStyle(
                                                            color: R.color
                                                                .online_appointment,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      GestureDetector(
                                                          onTap: () async {
                                                            widget.myPv
                                                                .addSemptomToList(
                                                                    value.proposedSymptomList[
                                                                        index]);
                                                            await value
                                                                .addSemptomToList(
                                                                    value.proposedSymptomList[
                                                                        index]);
                                                            await value.fetchProposedSymptoms(
                                                                value
                                                                    .selectedBodySymptoms,
                                                                widget
                                                                    .selectedGenderId,
                                                                widget
                                                                    .yearOfBirth);
                                                          },
                                                          child:
                                                              Icon(Icons.add)),
                                                    ],
                                                  ),
                                                  Divider(
                                                    thickness: 1,
                                                  )
                                                ],
                                              );
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 30),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    decoration: BoxDecoration(
                        color: value.selectedBodySymptoms.length != 0
                            ? R.color.online_appointment
                            : R.color.online_appointment.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(40)),
                    child: FlatButton(
                        color: Colors.transparent,
                        onPressed: () async {
                          if (value.selectedBodySymptoms.length != 0) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SymptomsResultPage(
                                  gender: widget.selectedGenderId == 0 ||
                                          widget.selectedGenderId == 2
                                      ? 'male'
                                      : 'female',
                                  year_of_birth: widget.yearOfBirth,
                                  symptoms: widget.selectedBodySymptoms,
                                  isFromVoice: false,
                                ),
                              ),
                              // ignore: unnecessary_statements
                            );
                          } else {
                            null;
                          }

                          /*Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SymptomsResultPage(
                                      gender: widget.selectedGenderId == 0 ||
                                              widget.selectedGenderId == 2
                                          ? 'male'
                                          : 'female',
                                      year_of_birth: widget.yearOfBirth,
                                      symptoms: value.selectedBodySymptoms,
                                    ),
                                  ),
                                  // ignore: unnecessary_statements
                                )*/
                        },
                        child: Text(
                          LocaleProvider.of(context).analyze_department,
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ),
              ),
            ],
          )),
        );
      }),
    );
  }
}
