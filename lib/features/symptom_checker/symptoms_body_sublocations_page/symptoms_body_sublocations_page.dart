import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:onedosehealth/model/model.dart';
import 'symptoms_body_sublocations_vm.dart';
import '../symptoms_body_symptoms_page/symptoms_body_symptoms_page.dart';
import 'package:provider/provider.dart';
import 'package:expandable/expandable.dart';

class BodySubLocationsPage extends StatefulWidget {
  const BodySubLocationsPage(
      {Key key,
      this.selectedGenderId,
      this.yearOfBirth,
      this.selectedBodyLocation,
      this.isFromVoice})
      : super(key: key);

  final GetBodyLocationResponse selectedBodyLocation;
  final int selectedGenderId;
  final String yearOfBirth;
  final bool isFromVoice;
  @override
  _BodySubLocationsPageState createState() => _BodySubLocationsPageState();
}

class _BodySubLocationsPageState extends State<BodySubLocationsPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BodySublocationsVm(
          context: context,
          bodyLocationId: widget.selectedBodyLocation.id,
          genderId: widget.selectedGenderId == 0 || widget.selectedGenderId == 2
              ? 0
              : 1,
          isFromVoicePage: widget.isFromVoice,
          selectedBodyLocation: widget.selectedBodyLocation,
          yearOfBirth: widget.yearOfBirth),
      child: Consumer<BodySublocationsVm>(builder: (context, value, child) {
        return Scaffold(
          appBar: RbioAppBar(title: RbioAppBar.textTitle(context, LocaleProvider.of(context).my_symptoms),),
          body: SafeArea(
            child: value.progress == LoadingProgress.LOADING
                ? RbioLoading()
                : value.progress == LoadingProgress.DONE
                    ? Column(
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
                                          ? LocaleProvider.of(context)
                                              .gender_female
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
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    widget.selectedBodyLocation.name,
                                    style: TextStyle(
                                        color: R.color.online_appointment,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Expanded(
                            child: ListView.builder(
                                padding: const EdgeInsets.all(12),
                                itemCount: value.bodySubLocations.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    elevation: 10,
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    child: ExpandablePanel(
                                      controller:
                                          value.expControllerList[index],
                                      //iconColor: R.color.online_appointment,
                                      header: GestureDetector(
                                        onTap: () {
                                          value.expControllerList[index]
                                              .toggle();
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 12.0, horizontal: 8),
                                          child: Text(
                                              '${value.bodySubLocations[index].name}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16)),
                                        ),
                                      ),
                                      collapsed: ListTile(
                                        title: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              4,
                                          child:
                                              value.symptomControl ==
                                                      LoadingProgress.LOADING
                                                  ? RbioLoading()
                                                  : ListView.builder(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      itemCount: value
                                                          .allBodySymptoms[
                                                              index]
                                                          .length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int indx) {
                                                        return GestureDetector(
                                                          onTap: () {
                                                            value.addSemptomToList(
                                                                value.allBodySymptoms[
                                                                        index]
                                                                    [indx]);
                                                          },
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Container(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.70,
                                                                    child: Text(
                                                                      value
                                                                          .allBodySymptoms[
                                                                              index]
                                                                              [
                                                                              indx]
                                                                          .name,
                                                                      softWrap:
                                                                          true,
                                                                      maxLines:
                                                                          2,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: TextStyle(
                                                                          color: value.selectedSymptoms.contains(value.allBodySymptoms[index][indx])
                                                                              ? R.color.online_appointment
                                                                              : R.color.black),
                                                                    ),
                                                                  ),
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      value.removeSemptomFromList(
                                                                          value.allBodySymptoms[index]
                                                                              [
                                                                              indx]);
                                                                    },
                                                                    child: Visibility(
                                                                        visible: value.selectedSymptoms.contains(value.allBodySymptoms[index][indx])
                                                                            ? true
                                                                            : false,
                                                                        child: Icon(
                                                                            Icons
                                                                                .close,
                                                                            size:
                                                                                20)),
                                                                  ),
                                                                ],
                                                              ),
                                                              Divider()
                                                            ],
                                                          ),
                                                        );
                                                      }),
                                        ),
                                      ),
                                      expanded: Container(),
                                    ),
                                  );
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 30),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              decoration: BoxDecoration(
                                  color: value.selectedSymptoms.length != 0
                                      ? null
                                      : R.color.online_appointment
                                          .withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(40)),
                              child: FlatButton(
                                  color: Colors.transparent,
                                  onPressed: () async {
                                    if (value.selectedSymptoms.length != 0) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              BodySymptomsSelectionPage(
                                            selectedGenderId:
                                                widget.selectedGenderId,
                                            yearOfBirth: widget.yearOfBirth,
                                            selectedBodyLocation:
                                                widget.selectedBodyLocation,
                                            selectedBodySymptoms:
                                                value.selectedSymptoms,
                                            isFromVoice: widget.isFromVoice,
                                            myPv: value,
                                          ),
                                        ),
                                      );
                                    } else {
                                      null;
                                    }
                                  },
                                  child: Text(
                                    LocaleProvider.of(context).continue_lbl,
                                    style: TextStyle(color: R.color.white),
                                  )),
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: Text('No Result'),
                      ),
          ),
        );
      }),
    );
  }
}
