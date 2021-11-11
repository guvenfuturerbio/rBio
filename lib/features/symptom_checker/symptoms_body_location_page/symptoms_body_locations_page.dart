import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onedosehealth/core/core.dart';
import 'body_parts_paint.dart';
import 'symptoms_body_locations_page_vm.dart';
import '../symptoms_body_sublocations_page/symptoms_body_sublocations_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';

class BodyLocationsPage extends StatefulWidget {
  const BodyLocationsPage(
      {Key key, this.selectedGenderId, this.yearOfBirth, this.isFromVoice})
      : super(key: key);

  final int selectedGenderId;
  final String yearOfBirth;
  final bool isFromVoice;

  @override
  _BodyLocationsPageState createState() => _BodyLocationsPageState();
}

class _BodyLocationsPageState extends State<BodyLocationsPage> {
  State state;
  final notifier = ValueNotifier(Offset.zero);
  String bodyPart = '';
  Size _size = Size.zero;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BodyLocationsVm(
          context: context,
          isFromVoice: widget.isFromVoice,
          notifierFromPage: notifier,
          selectedGenderIdFromPage: widget.selectedGenderId,
          yearOfBirth: widget.yearOfBirth),
      child: Consumer<BodyLocationsVm>(builder: (context, value, child) {
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
