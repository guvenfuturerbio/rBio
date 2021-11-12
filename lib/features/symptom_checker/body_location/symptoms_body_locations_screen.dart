import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../core/core.dart';
import '../symptoms_body_sublocations_page/symptoms_body_sublocations_page.dart';
import 'body_parts_paint.dart';
import 'symptoms_body_locations_page_vm.dart';

class SymptomsBodyLocationsScreen extends StatefulWidget {
  int selectedGenderId;
  String yearOfBirth;
  bool isFromVoice;

  SymptomsBodyLocationsScreen({Key key}) : super(key: key);

  @override
  _SymptomsBodyLocationsScreenState createState() =>
      _SymptomsBodyLocationsScreenState();
}

class _SymptomsBodyLocationsScreenState
    extends State<SymptomsBodyLocationsScreen> {
  State state;
  final notifier = ValueNotifier(Offset.zero);
  String bodyPart = '';

  @override
  Widget build(BuildContext context) {
    try {
      widget.selectedGenderId =
          int.parse(Atom.queryParameters['selectedGenderId']);
      widget.yearOfBirth = Atom.queryParameters['yearOfBirth'];
      widget.isFromVoice = Atom.queryParameters['isFromVoice'] == 'true';
    } catch (_) {
      return RbioError();
    }

    return ChangeNotifierProvider<SymptomsBodyLocationsVm>(
      create: (context) => SymptomsBodyLocationsVm(
          context: context,
          isFromVoice: widget.isFromVoice,
          notifierFromPage: notifier,
          selectedGenderIdFromPage: widget.selectedGenderId,
          yearOfBirth: widget.yearOfBirth),
      child:
          Consumer<SymptomsBodyLocationsVm>(builder: (context, value, child) {
        return Scaffold(
          appBar: RbioAppBar(
            title: RbioAppBar.textTitle(
                context, LocaleProvider.of(context).my_symptoms),
          ),
          body: SafeArea(
            child: value.progress == LoadingProgress.LOADING
                ? RbioLoading()
                : value.progress == LoadingProgress.DONE
                    ? Column(
                        children: [
                          Column(
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  LocaleProvider.of(context)
                                      .complaint_body_part,
                                  style: TextStyle(fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                          value.selectedBodyLocation == null ||
                                  value.selectedBodyLocation.name == ''
                              ? Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: Text(' '))
                              : Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: Text(
                                      LocaleProvider.of(context).choice +
                                          value.selectedBodyLocation.name),
                                ),
                          Center(
                            child: Container(
                                width: MediaQuery.of(context).size.width / 2,
                                height: MediaQuery.of(context).size.height / 2,
                                child: GestureDetector(
                                  onTapDown: (e) {
                                    value.notifier.value = e.localPosition;
                                    print(e.localPosition);
                                  },
                                  child: CustomPaint(
                                    painter: BodyPartsPainter(
                                        isGenderMale:
                                            widget.selectedGenderId == 0 ||
                                                    widget.selectedGenderId == 2
                                                ? true
                                                : false,
                                        clickedPathFunc: (myValue) {
                                          //print(myValue);
                                          WidgetsBinding.instance
                                              .addPostFrameCallback(
                                                  (timeStamp) async {
                                            if (myValue != null) {
                                              await value
                                                  .selectedBodyLocationFetch(
                                                      value.getLocationsName(
                                                          myValue));
                                            } else {
                                              await value
                                                  .selectedBodyLocationFetch(
                                                      null);
                                            }
                                          });
                                        },
                                        notifier: value.notifier,
                                        bodyLocations: value.bodyLocations),
                                    child: SizedBox.expand(),
                                  ),
                                )),
                          ),
                          Visibility(
                              visible: value.selectedBodyLocation != null &&
                                      value.selectedBodyLocation.name != ''
                                  ? true
                                  : false,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40)),
                                  child: FlatButton(
                                      color: Colors.transparent,
                                      onPressed: () async {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                BodySubLocationsPage(
                                              selectedBodyLocation:
                                                  value.selectedBodyLocation,
                                              selectedGenderId:
                                                  widget.selectedGenderId,
                                              yearOfBirth: widget.yearOfBirth,
                                              isFromVoice: widget.isFromVoice,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        LocaleProvider.of(context).continue_lbl,
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ),
                              )),
                          Spacer(
                            flex: 1,
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
