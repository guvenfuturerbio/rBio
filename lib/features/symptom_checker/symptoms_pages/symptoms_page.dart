import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:wheel_chooser/wheel_chooser.dart';
import '../symptoms_body_location_page/symptoms_body_locations_page.dart';
import 'symptoms_page_vm.dart';
import '../symptoms_result_page/symptoms_result_page_vm.dart';
import 'package:provider/provider.dart';

final PageController pageVcontroller = PageController(initialPage: 0);

class SymptomsAuthPage extends StatefulWidget {
  const SymptomsAuthPage({Key key}) : super(key: key);

  @override
  _SymptomsAuthPageState createState() => _SymptomsAuthPageState();
}

class _SymptomsAuthPageState extends State<SymptomsAuthPage> {
  TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => SymptomsPageVm(context: context),
        child: Consumer<SymptomsPageVm>(builder: (context, value, child) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: RbioAppBar(
              title: RbioAppBar.textTitle(
                  context, LocaleProvider.of(context).my_symptoms),
            ),
            body: value.progress == LoadingProgress.LOADING
                ? RbioLoading()
                : value.progress == LoadingProgress.DONE
                    ? SafeArea(
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Column(
                              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 18.0),
                                    child: Text(
                                      LocaleProvider.of(context).preselection,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        DateTime.now().year -
                                                    int.parse(
                                                        value.yearOfBirth) <
                                                18
                                            ? null
                                            : value.fetchGenderSelection(0);
                                      },
                                      child: Opacity(
                                        opacity: DateTime.now().year -
                                                    int.parse(
                                                        value.yearOfBirth) <
                                                18
                                            ? 0.1
                                            : 1,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Card(
                                            color: value.genderIdHolder == 0
                                                ? R.color.online_appointment
                                                : R.color.white,
                                            elevation: 6,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          12, 8, 0, 8),
                                                  child: SvgPicture.asset(
                                                      R.image.man_icon,
                                                      width: 25,
                                                      height: 45,
                                                      color:
                                                          value.genderIdHolder ==
                                                                  0
                                                              ? R.color.white
                                                              : null),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.18),
                                                  child: Text(
                                                    LocaleProvider.of(context)
                                                        .gender_male,
                                                    style: TextStyle(
                                                        color:
                                                            value.genderIdHolder ==
                                                                    0
                                                                ? R.color.white
                                                                : null),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        DateTime.now().year -
                                                    int.parse(
                                                        value.yearOfBirth) <
                                                18
                                            ? null
                                            : value.fetchGenderSelection(1);
                                      },
                                      child: Opacity(
                                        opacity: DateTime.now().year -
                                                    int.parse(
                                                        value.yearOfBirth) <
                                                18
                                            ? 0.1
                                            : 1,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Card(
                                              color: value.genderIdHolder == 1
                                                  ? R.color.online_appointment
                                                  : R.color.white,
                                              elevation: 6,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 8, 0, 8),
                                                    child: SvgPicture.asset(
                                                        R.image.women_icon,
                                                        width: 25,
                                                        height: 45,
                                                        color:
                                                            value.genderIdHolder ==
                                                                    1
                                                                ? R.color.white
                                                                : null),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.18),
                                                    child: Text(
                                                      LocaleProvider.of(context)
                                                          .gender_female,
                                                      style: TextStyle(
                                                          color:
                                                              value.genderIdHolder ==
                                                                      1
                                                                  ? R.color
                                                                      .white
                                                                  : null),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        DateTime.now().year -
                                                    int.parse(
                                                        value.yearOfBirth) <
                                                18
                                            ? value.fetchGenderSelection(2)
                                            : null;
                                      },
                                      child: Opacity(
                                        opacity: DateTime.now().year -
                                                    int.parse(
                                                        value.yearOfBirth) <
                                                18
                                            ? 1
                                            : 0.1,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Card(
                                            color: value.genderIdHolder == 2
                                                ? R.color.online_appointment
                                                : R.color.white,
                                            elevation: 6,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          12, 8, 0, 8),
                                                  child: SvgPicture.asset(
                                                      R.image.boy_child_icon,
                                                      width: 25,
                                                      height: 45,
                                                      color:
                                                          value.genderIdHolder ==
                                                                  2
                                                              ? R.color.white
                                                              : null),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.18),
                                                  child: Text(
                                                    LocaleProvider.of(context)
                                                        .boy,
                                                    style: TextStyle(
                                                        color:
                                                            value.genderIdHolder ==
                                                                    2
                                                                ? R.color.white
                                                                : null),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        DateTime.now().year -
                                                    int.parse(
                                                        value.yearOfBirth) <
                                                18
                                            ? value.fetchGenderSelection(3)
                                            : null;
                                      },
                                      child: Opacity(
                                        opacity: DateTime.now().year -
                                                    int.parse(
                                                        value.yearOfBirth) <
                                                18
                                            ? 1
                                            : 0.1,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Card(
                                            color: value.genderIdHolder == 3
                                                ? R.color.online_appointment
                                                : R.color.white,
                                            elevation: 6,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          8, 8, 0, 8),
                                                  child: SvgPicture.asset(
                                                      R.image.girl_child_icon,
                                                      width: 25,
                                                      height: 45,
                                                      color:
                                                          value.genderIdHolder ==
                                                                  3
                                                              ? R.color.white
                                                              : null),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.18),
                                                  child: Text(
                                                    LocaleProvider.of(context)
                                                        .girl,
                                                    style: TextStyle(
                                                        color:
                                                            value.genderIdHolder ==
                                                                    3
                                                                ? R.color.white
                                                                : null),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        LocaleProvider.of(context)
                                            .select_birth_year,
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.grey),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            height: 50,
                                            child: Card(
                                              elevation: 6,
                                              child: Container(
                                                  child: Center(
                                                child: Text(
                                                  value.yearOfBirth,
                                                  style:
                                                      TextStyle(fontSize: 25),
                                                ),
                                              )),
                                            ),
                                          )),
                                      Divider(),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.10,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                20,
                                        child: WheelChooser.integer(
                                          itemSize: 40,
                                          listWidth: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          magnification: 1.2,
                                          selectTextStyle: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  15,
                                              color:
                                                  R.color.online_appointment),
                                          unSelectTextStyle: TextStyle(
                                              color: R.color.grey
                                                  .withOpacity(0.6)),
                                          onValueChanged: (year) {
                                            value.yearOfBirthHandle(
                                                year.toString(),
                                                value.genderIdHolder);
                                          },
                                          maxValue: DateTime.now().year.toInt(),
                                          minValue: 1900,
                                          initValue:
                                              int.parse(value.yearOfBirth),
                                        ),
                                      ),
                                      Divider(),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.10,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                margin: EdgeInsets.only(bottom: 8),
                                width: MediaQuery.of(context).size.width / 2,
                                height: MediaQuery.of(context).size.height / 15,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40)),
                                child: FlatButton(
                                    color: Colors.transparent,
                                    onPressed: () async {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              BodyLocationsPage(
                                            selectedGenderId:
                                                value.genderIdHolder,
                                            yearOfBirth: value.yearOfBirth,
                                            isFromVoice: false,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      LocaleProvider.of(context).continue_lbl,
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Center(
                        child: Text('No Result'),
                      ),
          );
        }));
  }
}
