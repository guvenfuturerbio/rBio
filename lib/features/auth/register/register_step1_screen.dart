import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/html.dart' as htmlK;

import '../../../core/core.dart';
import '../../../model/model.dart';
import 'register_step1_vm.dart';

class RegisterStep1Screen extends StatefulWidget {
  const RegisterStep1Screen({Key key}) : super(key: key);

  @override
  _RegisterStep1ScreenState createState() => _RegisterStep1ScreenState();
}

class _RegisterStep1ScreenState extends State<RegisterStep1Screen> {
  List genderList = [
    "E",
    "K",
  ];

  Country country;
  final focus = FocusNode();
  final TextEditingController _tcIdentity = new TextEditingController();
  final TextEditingController _tcPhoneNumber = TextEditingController();
  final TextEditingController _tcEmail = new TextEditingController();
  final TextEditingController _fnPassport = new TextEditingController();
  final TextEditingController _fnName = new TextEditingController();
  final TextEditingController _fnSurname = new TextEditingController();
  final TextEditingController _tcName = new TextEditingController();
  final TextEditingController _tcSurname = new TextEditingController();
  final TextEditingController _fnPhone = new TextEditingController();
  final TextEditingController _fnEmail = new TextEditingController();
  bool checkedValueForFn = false;
  bool checkedValueForTc = false;

  // Turkish Citizen Tab
  final tcFNode = FocusNode();
  final tcNameNode = FocusNode();
  final tcLNameNode = FocusNode();
  final phoneFNode = FocusNode();
  final emailFNode = FocusNode();

  // Foreign Citizen Tab
  final ftcFNode = FocusNode();
  final fnameFNode = FocusNode();
  final fsurnameFNode = FocusNode();
  final fphoneFNode = FocusNode();
  final femailFNode = FocusNode();
  final birthdayNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: ChangeNotifierProvider<RegisterStep1ScreenVm>(
          create: (_) => RegisterStep1ScreenVm(context),
          child: Consumer<RegisterStep1ScreenVm>(
            builder: (
              BuildContext context,
              RegisterStep1ScreenVm vm,
              Widget child,
            ) =>
                Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: _buildAppBar(context),
              body: _buildBody(context, vm),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSize _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(150.0),
      child: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              LocaleProvider.of(context).personal_info,
              style: TextStyle(
                color: R.color.blue,
              ),
            ),
            SizedBox(height: 20),
            SvgPicture.asset(R.image.step_1_total_3),
          ],
        ),
        leading: IconButton(
          icon: SvgPicture.asset(R.image.back_arrow_red),
          onPressed: () {
            Atom.historyBack();
          },
        ),
        bottom: TabBar(
          indicatorColor: R.color.blue,
          labelColor: R.color.blue,
          tabs: [
            Tab(
              text: LocaleProvider.of(context).citizen_of_tc.toUpperCase(),
            ),
            Tab(
              text: LocaleProvider.of(context).foreign_national.toUpperCase(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, RegisterStep1ScreenVm vm) {
    return TabBarView(
      children: [
        //
        Container(
          margin: EdgeInsets.only(left: 30, right: 30),
          child: KeyboardAvoider(
            autoScroll: true,
            child: Column(
              children: <Widget>[
                Container(
                  child: TextFormField(
                    controller: _tcName,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    obscureText: false,
                    style: inputTextStyle(),
                    decoration: inputImageDecoration(
                      hintText: LocaleProvider.of(context).name,
                      image: R.image.ic_user,
                    ),
                    focusNode: tcNameNode,
                    onFieldSubmitted: (term) {
                      UtilityManager()
                          .fieldFocusChange(context, tcNameNode, tcLNameNode);
                    },
                  ),
                  margin: EdgeInsets.only(bottom: 20, top: 40),
                ),
                Container(
                  child: TextFormField(
                    controller: _tcSurname,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    obscureText: false,
                    style: inputTextStyle(),
                    decoration: inputImageDecoration(
                      hintText: LocaleProvider.of(context).surname,
                      image: R.image.ic_user,
                    ),
                    focusNode: tcLNameNode,
                    onFieldSubmitted: (term) {
                      UtilityManager()
                          .fieldFocusChange(context, tcLNameNode, tcFNode);
                    },
                  ),
                  margin: EdgeInsets.only(
                    bottom: 20,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: R.color.dark_white,
                    ),
                    borderRadius: BorderRadius.circular(200),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        R.image.ic_user,
                        fit: BoxFit.none,
                      ),
                      addRadioButton(0, 'Male'),
                      addRadioButton(1, 'Female'),
                    ],
                  ),
                  margin: EdgeInsets.only(
                    bottom: 20,
                  ),
                ),
                InkWell(
                  onTap: () => vm.selectDate(context),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: R.color.dark_white,
                      ),
                      borderRadius: BorderRadius.circular(200),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          R.image.ic_user,
                          fit: BoxFit.none,
                        ),
                        SizedBox(width: 8),
                        (vm.selectedDate == null)
                            ? Text(LocaleProvider.of(context).birth_date,
                                style: TextStyle(
                                    fontSize: 16, color: R.color.gray))
                            : Text(
                                DateFormat('dd MMMM yyyy')
                                    .format(vm.selectedDate),
                                style: TextStyle(
                                  fontSize: 16,
                                ))
                      ],
                    ),
                    margin: EdgeInsets.only(
                      bottom: 20,
                    ),
                  ),
                ),
                Container(
                  child: TextFormField(
                    controller: _tcIdentity,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    style: inputTextStyle(),
                    decoration: inputImageDecoration(
                      hintText: LocaleProvider.of(context).tc_identity_number,
                      image: R.image.ic_user,
                    ),
                    focusNode: tcFNode,
                    inputFormatters: <TextInputFormatter>[
                      new TabToNextFieldTextInputFormatter(
                          context, tcFNode, phoneFNode),
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9\t\r]'))
                    ],
                    onFieldSubmitted: (term) {
                      UtilityManager()
                          .fieldFocusChange(context, tcFNode, phoneFNode);
                    },
                  ),
                  margin: EdgeInsets.only(
                    bottom: 20,
                  ),
                ),
                Container(
                  child: TextFormField(
                    controller: _tcPhoneNumber,
                    style: inputTextStyle(),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    decoration: inputImageDecoration(
                      hintText: LocaleProvider.of(context).phone_number,
                      image: R.image.ic_phone_call_grey,
                    ),
                    focusNode: phoneFNode,
                    inputFormatters: <TextInputFormatter>[
                      new TabToNextFieldTextInputFormatter(
                          context, phoneFNode, emailFNode)
                    ],
                    onFieldSubmitted: (term) {
                      UtilityManager()
                          .fieldFocusChange(context, phoneFNode, emailFNode);
                    },
                  ),
                  margin: EdgeInsets.only(bottom: 20),
                ),
                Container(
                  child: TextFormField(
                      controller: _tcEmail,
                      style: inputTextStyle(),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration: inputImageDecoration(
                        hintText: LocaleProvider.of(context).email_address,
                        image: R.image.ic_email,
                      ),
                      focusNode: emailFNode,
                      inputFormatters: <TextInputFormatter>[
                        new TabToNextFieldTextInputFormatter(
                            context, emailFNode, null)
                      ],
                      onFieldSubmitted: (term) {
                        UtilityManager()
                            .fieldFocusChange(context, tcFNode, birthdayNode);
                      }),
                  margin: EdgeInsets.only(bottom: 20),
                ),
                Row(
                  children: [
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Checkbox(
                        value: checkedValueForTc,
                        onChanged: (newValue) {
                          setState(() {
                            checkedValueForTc = newValue;
                          });
                        },
                        activeColor: R.color.blue, //  <-- leading Checkbox
                      ),
                    ),
                    Expanded(
                        child: InkWell(
                      onTap: () => {vm.showKvkkInfo()},
                      child:
                          Text(LocaleProvider.of(context).accept_personal_data,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: R.color.black,
                                decoration: TextDecoration.underline,
                              )),
                    ))
                  ],
                ),
                Container(
                  child: button(
                      text: LocaleProvider.of(context).btn_next.toUpperCase(),
                      onPressed: () {
                        if (checkedValueForTc) {
                          RegisterStep1PusulaModel userRegisterStep1 =
                              new RegisterStep1PusulaModel();
                          userRegisterStep1.firstName = _tcName.text;
                          userRegisterStep1.lastName = _tcSurname.text;
                          userRegisterStep1.nationalityId = 213;
                          userRegisterStep1.identityNumber = _tcIdentity.text;
                          userRegisterStep1.gender = gender;
                          userRegisterStep1.gsm = _tcPhoneNumber.text;
                          userRegisterStep1.birthDate =
                              vm.selectedDate.toString();
                          userRegisterStep1.email = _tcEmail.text;
                          //-------------------------------------
                          UserRegistrationStep1Model userRegisterStep1Model =
                              new UserRegistrationStep1Model();
                          userRegisterStep1Model.name = _tcName.text;
                          userRegisterStep1Model.surname = _tcSurname.text;
                          userRegisterStep1Model.identificationNumber =
                              _tcIdentity.text;
                          userRegisterStep1Model.userNationality = 'TC';
                          userRegisterStep1Model.phoneNumber =
                              _tcPhoneNumber.text;
                          userRegisterStep1Model.electronicMail = _tcEmail.text;
                          if (_tcIdentity.text.length > 0 &&
                              _tcPhoneNumber.text.length > 0 &&
                              _tcEmail.text.length > 0) {
                            vm.registerStep1(
                                userRegisterStep1, userRegisterStep1Model);
                          } else if ((_tcIdentity.text == null ||
                                  _tcIdentity.text.length == 0) &&
                              _tcPhoneNumber.text.length > 0 &&
                              _tcEmail.text.length > 0) {
                            vm.registerStep1(
                                userRegisterStep1, userRegisterStep1Model);
                          } else {
                            vm.showGradientDialog(
                                context,
                                LocaleProvider.of(context).warning,
                                LocaleProvider.of(context).fill_all_field);
                          }
                        } else {
                          vm.showGradientDialog(
                              context,
                              LocaleProvider.of(context).warning,
                              LocaleProvider.of(context).check_personal_data);
                        }
                      }),
                  margin: EdgeInsets.only(top: 5, bottom: 20),
                )
              ],
            ),
          ),
        ),

        //
        Container(
          margin: EdgeInsets.only(left: 30, right: 30),
          child: KeyboardAvoider(
            autoScroll: true,
            child: Column(
              children: <Widget>[
                Container(
                  child: TextFormField(
                    controller: _fnPassport,
                    textInputAction: TextInputAction.next,
                    style: inputTextStyle(),
                    decoration: inputImageDecoration(
                      hintText: LocaleProvider.of(context).passport_number,
                      image: R.image.ic_user,
                    ),
                    focusNode: ftcFNode,
                    inputFormatters: <TextInputFormatter>[
                      new TabToNextFieldTextInputFormatter(
                          context, ftcFNode, fnameFNode)
                    ],
                    onFieldSubmitted: (term) {
                      UtilityManager()
                          .fieldFocusChange(context, ftcFNode, fnameFNode);
                    },
                  ),
                  margin: EdgeInsets.only(bottom: 20, top: 40),
                ),
                Container(
                  child: TextFormField(
                    controller: _fnName,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    style: inputTextStyle(),
                    decoration: inputImageDecoration(
                      hintText: LocaleProvider.of(context).name,
                      image: R.image.ic_user,
                    ),
                    focusNode: fnameFNode,
                    inputFormatters: <TextInputFormatter>[
                      new TabToNextFieldTextInputFormatter(
                          context, fnameFNode, fsurnameFNode)
                    ],
                    onFieldSubmitted: (term) {
                      UtilityManager()
                          .fieldFocusChange(context, fnameFNode, fsurnameFNode);
                    },
                  ),
                  margin: EdgeInsets.only(bottom: 20),
                ),
                Container(
                  child: TextFormField(
                    controller: _fnSurname,
                    style: inputTextStyle(),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    decoration: inputImageDecoration(
                      hintText: LocaleProvider.of(context).surname,
                      image: R.image.ic_user,
                    ),
                    focusNode: fsurnameFNode,
                    inputFormatters: <TextInputFormatter>[
                      new TabToNextFieldTextInputFormatter(
                          context, fsurnameFNode, fphoneFNode)
                    ],
                    onFieldSubmitted: (term) {
                      UtilityManager().fieldFocusChange(
                          context, fsurnameFNode, fphoneFNode);
                    },
                  ),
                  margin: EdgeInsets.only(bottom: 20),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: R.color.dark_white,
                    ),
                    borderRadius: BorderRadius.circular(200),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        R.image.ic_user,
                        fit: BoxFit.none,
                      ),
                      addRadioButton(0, 'Male'),
                      addRadioButton(1, 'Female'),
                    ],
                  ),
                  margin: EdgeInsets.only(
                    bottom: 20,
                  ),
                ),
                InkWell(
                  onTap: () => vm.selectDate(context),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: R.color.dark_white,
                      ),
                      borderRadius: BorderRadius.circular(200),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          R.image.ic_user,
                          fit: BoxFit.none,
                        ),
                        SizedBox(width: 8),
                        (vm.selectedDate == null)
                            ? Text(LocaleProvider.of(context).birth_date,
                                style: TextStyle(
                                    fontSize: 16, color: R.color.gray))
                            : Text(
                                DateFormat('dd MMMM yyyy')
                                    .format(vm.selectedDate),
                                style: TextStyle(
                                  fontSize: 16,
                                ))
                      ],
                    ),
                    margin: EdgeInsets.only(
                      bottom: 20,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await vm.getCountries();
                    return showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(LocaleProvider.current.country),
                            content: Container(
                              height: 300.0, // Change as per your requirement
                              width: 300.0, // Change as per your requirement
                              child: ListView.builder(
                                itemCount: vm.countryList.countries.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                      onTap: () {
                                        setState(() {
                                          country =
                                              vm.countryList.countries[index];
                                        });
                                        Navigator.pop(context);
                                      },
                                      title: Text(vm
                                          .countryList.countries[index].name));
                                },
                              ),
                            ),
                          );
                        });
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: R.color.dark_white,
                      ),
                      borderRadius: BorderRadius.circular(200),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          R.image.ic_user,
                          fit: BoxFit.none,
                        ),
                        SizedBox(width: 8),
                        (country == null)
                            ? Text("Country",
                                style: TextStyle(
                                    fontSize: 16, color: R.color.gray))
                            : Text(country.name.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                ))
                      ],
                    ),
                    margin: EdgeInsets.only(
                      bottom: 20,
                    ),
                  ),
                ),
                Container(
                  child: TextFormField(
                    controller: _fnPhone,
                    style: inputTextStyle(),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    decoration: inputImageDecoration(
                      hintText: LocaleProvider.of(context).phone_number,
                      image: R.image.ic_phone_call_grey,
                    ),
                    focusNode: fphoneFNode,
                    inputFormatters: <TextInputFormatter>[
                      new TabToNextFieldTextInputFormatter(
                          context, fphoneFNode, femailFNode)
                    ],
                    onFieldSubmitted: (term) {
                      UtilityManager()
                          .fieldFocusChange(context, fphoneFNode, femailFNode);
                    },
                  ),
                  margin: EdgeInsets.only(bottom: 20),
                ),
                Container(
                  child: TextFormField(
                      controller: _fnEmail,
                      style: inputTextStyle(),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.emailAddress,
                      decoration: inputImageDecoration(
                        hintText: LocaleProvider.of(context).email_address,
                        image: R.image.ic_email,
                      ),
                      focusNode: femailFNode,
                      inputFormatters: <TextInputFormatter>[
                        new TabToNextFieldTextInputFormatter(
                            context, femailFNode, null)
                      ],
                      onFieldSubmitted: (term) {
                        UtilityManager()
                            .fieldFocusChange(context, femailFNode, null);
                      }),
                  margin: EdgeInsets.only(bottom: 5),
                ),

                //
                Row(
                  children: [
                    //
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Checkbox(
                        value: checkedValueForFn,
                        onChanged: (newValue) {
                          setState(() {
                            checkedValueForFn = newValue;
                          });
                        },
                        activeColor: R.color.blue, //  <-- leading Checkbox
                      ),
                    ),

                    //
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          vm.showKvkkInfo();
                        },
                        child: Text(
                          LocaleProvider.of(context).accept_personal_data,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: R.color.black,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                //
                Container(
                  child: button(
                      text: LocaleProvider.of(context).btn_next.toUpperCase(),
                      onPressed: () {
                        if (checkedValueForFn) {
                          RegisterStep1PusulaModel userRegisterStep1 =
                              new RegisterStep1PusulaModel();
                          userRegisterStep1.firstName = _fnName.text;
                          userRegisterStep1.lastName = _fnSurname.text;
                          userRegisterStep1.nationalityId = country.id;
                          userRegisterStep1.identityNumber = _fnPassport.text;
                          userRegisterStep1.gender = gender;
                          userRegisterStep1.gsm = _fnPhone.text;
                          userRegisterStep1.birthDate =
                              vm.selectedDate.toString();
                          userRegisterStep1.email = _fnEmail.text;
                          //-------------------------------------
                          UserRegistrationStep1Model userRegisterStep1Model =
                              new UserRegistrationStep1Model();
                          userRegisterStep1Model.name = _fnName.text;
                          userRegisterStep1Model.surname = _fnSurname.text;
                          userRegisterStep1Model.identificationNumber =
                              _fnPassport.text;
                          userRegisterStep1Model.userNationality = "D";
                          userRegisterStep1Model.phoneNumber = _fnPhone.text;
                          userRegisterStep1Model.electronicMail = _fnEmail.text;
                          /* UserRegistrationStep1
                                        userRegisterStep1Model =
                                        new UserRegistrationStep1();
                                    */
                          if (_fnName.text.length > 0 &&
                              _fnSurname.text.length > 0 &&
                              _fnPhone.text.length > 0 &&
                              _fnEmail.text.length > 0 &&
                              gender != null &&
                              vm.selectedDate != null &&
                              country != null) {
                            if (_fnPassport.text.length > 0 &&
                                _fnPhone.text.length > 0 &&
                                _fnEmail.text.length > 0) {
                              vm.registerStep1(
                                  userRegisterStep1, userRegisterStep1Model);
                            } else if ((_fnPassport.text == null ||
                                    _fnPassport.text.length == 0) &&
                                _fnPhone.text.length > 0 &&
                                _fnEmail.text.length > 0) {
                              vm.registerStep1(
                                  userRegisterStep1, userRegisterStep1Model);
                            } else {
                              vm.showGradientDialog(
                                  context,
                                  LocaleProvider.of(context).warning,
                                  LocaleProvider.of(context).fill_all_field);
                            }
                            /*vm.registerStep1(userRegisterStep1,
                                          userRegisterStep1Model);*/
                          } else {
                            vm.showGradientDialog(
                                context,
                                LocaleProvider.of(context).warning,
                                LocaleProvider.of(context).fill_all_field);
                          }
                        } else {
                          vm.showGradientDialog(
                              context,
                              LocaleProvider.of(context).warning,
                              LocaleProvider.of(context).check_personal_data);
                        }
                      }),
                  margin: EdgeInsets.only(top: 5, bottom: 20),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String gender;

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: genderList[btnValue],
          groupValue: gender,
          onChanged: (value) {
            setState(() {
              print(value);
              gender = value;
            });
          },
        ),
        Text(title)
      ],
    );
  }
}
