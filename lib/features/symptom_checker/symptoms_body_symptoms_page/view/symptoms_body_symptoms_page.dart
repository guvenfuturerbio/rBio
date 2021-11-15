import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:onedosehealth/core/widgets/rbio_appbar.dart';
import 'package:onedosehealth/model/model.dart';
import 'package:provider/provider.dart';

import '../../symptoms_body_sublocations_page/view/symptoms_body_sublocations_page.dart';
import '../../symptoms_body_sublocations_page/viewmodel/symptoms_body_sublocations_vm.dart';
import '../../symptoms_result_page/view/symptoms_result_page.dart';
import '../viewmodel/symptoms_body_symptoms_page_vm.dart';

class BodySymptomsSelectionPage extends StatefulWidget {
  BodySymptomsSelectionPage({
    Key key,
    this.selectedBodySymptoms,
    this.selectedGenderId,
    this.yearOfBirth,
    this.selectedBodyLocation,
    this.isFromVoice,
    this.myPv,
  }) : super(key: key);

  List<GetBodySymptomsResponse> selectedBodySymptoms;
  int selectedGenderId;
  String yearOfBirth;
  GetBodyLocationResponse selectedBodyLocation;
  bool isFromVoice;
  BodySublocationsVm myPv;

  @override
  _BodySymptomsSelectionPageState createState() =>
      _BodySymptomsSelectionPageState();
}

class _BodySymptomsSelectionPageState extends State<BodySymptomsSelectionPage> {
  @override
  void dispose() {
    try {
      RbioConfig.of(context).bodyLocationRsp = null;
      RbioConfig.of(context).listBodySympRsp = null;
    } catch (e) {}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      widget.selectedBodyLocation = RbioConfig.of(context).bodyLocationRsp;
      widget.myPv = RbioConfig.of(context).sublocationVm;
      widget.selectedBodySymptoms = RbioConfig.of(context).listBodySympRsp;
      widget.selectedGenderId =
          int.parse(Atom.queryParameters['selectedGenderId']);
      widget.yearOfBirth = Atom.queryParameters['yearOfBirth'];
      widget.isFromVoice = Atom.queryParameters['isFromVoice'] == 'true';
    } catch (_) {
      return RbioRouteError();
    }
    return ChangeNotifierProvider(
      create: (context) => BodySymptomSelectionVm(
          context: context,
          genderId: widget.selectedGenderId,
          symptomList: widget.myPv.selectedSymptoms,
          year_of_birth: widget.yearOfBirth,
          isFromVoice: widget.isFromVoice,
          myPv: widget.myPv),
      child: Consumer<BodySymptomSelectionVm>(builder: (context, value, child) {
        return RbioScaffold(
          appbar: RbioAppBar(
            title: RbioAppBar.textTitle(
                context, LocaleProvider.of(context).my_symptoms),
          ),
          body: _buildBody(context, value),
        );
      }),
    );
  }

  Widget _buildBody(BuildContext context, BodySymptomSelectionVm value) {
    return Stack(
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
                    style: context.xHeadline3.copyWith(
                        fontWeight: FontWeight.bold,
                        color: getIt<ITheme>().mainColor),
                    textAlign: TextAlign.start,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 35),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      widget.selectedBodyLocation.name,
                      style: context.xHeadline3.copyWith(
                          fontWeight: FontWeight.bold,
                          color: getIt<ITheme>().mainColor),
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
                      style: context.xHeadline3.copyWith(
                          fontWeight: FontWeight.bold,
                          color: getIt<ITheme>()
                              .textColorSecondary
                              .withOpacity(0.5)),
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
                            horizontal: MediaQuery.of(context).size.width / 7),
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
                                    style: context.xHeadline3.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: getIt<ITheme>().mainColor),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  GestureDetector(
                                      onTap: () async {
                                        await value.removeSemptomFromList(
                                            value.selectedBodySymptoms[index]);
                                        await widget.myPv.removeSemptomFromList(
                                            widget
                                                .myPv.selectedSymptoms[index]);
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
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: RbioElevatedButton(
                          onTap: () {
                            Atom.historyBack();
                            /*Navigator.pop(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BodySubLocationsPage(
                                  selectedBodyLocation:
                                      widget.selectedBodyLocation,
                                  yearOfBirth: widget.yearOfBirth,
                                  selectedGenderId: widget.selectedGenderId,
                                  isFromVoice: false,
                                ),
                              ),
                              // ignore: unnecessary_statements
                            );*/
                          },
                          title: LocaleProvider.of(context).add_symptom),
                    ),
                  ),
                  value.proposedProgress == LoadingProgress.LOADING
                      ? RbioLoading()
                      : _buildProposedList(value, context),
                ],
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 30),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.5,
              child: RbioElevatedButton(
                onTap: value.selectedBodySymptoms.length != 0
                    ? () async {
                        RbioConfig.of(context).listBodySympRsp =
                            value.selectedBodySymptoms;
                        Atom.to(
                          PagePaths.SYMPTOM_RESULT_PAGE,
                          queryParameters: {
                            'gender': widget.selectedGenderId == 0 ||
                                    widget.selectedGenderId == 2
                                ? 'male'
                                : 'female',
                            'year_of_birth': widget.yearOfBirth,
                            'isFromVoice': false.toString(),
                          },
                        );
                        /*
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
                        );*/
                      }
                    : null,
                title: LocaleProvider.of(context).analyze_department,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProposedList(
      BodySymptomSelectionVm value, BuildContext context) {
    switch (value.proposedProgress) {
      case LoadingProgress.LOADING:
        return RbioLoading();
        break;
      case LoadingProgress.DONE:
        return Visibility(
          visible: value.proposedSymptomList.length != 0 ? true : false,
          child: Flexible(
            flex: 5,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    LocaleProvider.current.proposed_symptom,
                    style: context.xHeadline1
                        .copyWith(color: getIt<ITheme>().textColorSecondary),
                  ),
                ),
                Container(
                  height: value.proposedSymptomList.length * 40.0 >
                          MediaQuery.of(context).size.height * 0.25
                      ? MediaQuery.of(context).size.height * 0.25
                      : value.proposedSymptomList.length * 40.0,
                  child: ListView.builder(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width / 7),
                      itemCount: value.proposedSymptomList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 6,
                                  child: Text(
                                    '${value.proposedSymptomList[index].name}',
                                    style: context.xHeadline3.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: getIt<ITheme>().mainColor),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: GestureDetector(
                                      onTap: () async {
                                        widget.myPv.addSemptomToList(
                                            value.proposedSymptomList[index]);
                                        await value.addSemptomToList(
                                            value.proposedSymptomList[index]);
                                        await value.fetchProposedSymptoms(
                                            value.selectedBodySymptoms,
                                            widget.selectedGenderId,
                                            widget.yearOfBirth);
                                      },
                                      child: Icon(Icons.add)),
                                ),
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
        );
      case LoadingProgress.ERROR:
        return RbioError();
      default:
        return SizedBox();
    }
  }
}
