import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/src/core/extended_context.dart';

import '../../../core/core.dart';
import '../../../model/model.dart';
import 'forgot_password_step1_vm.dart';

class ForgotPasswordStep1Screen extends StatefulWidget {
  const ForgotPasswordStep1Screen({Key key}) : super(key: key);

  @override
  _ForgotPasswordStep1ScreenState createState() =>
      _ForgotPasswordStep1ScreenState();
}

class _ForgotPasswordStep1ScreenState extends State<ForgotPasswordStep1Screen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ForgotPasswordStep1ScreenVm>(
      create: (context) => ForgotPasswordStep1ScreenVm(context: context),
      child: Consumer<ForgotPasswordStep1ScreenVm>(
        builder: (BuildContext context, ForgotPasswordStep1ScreenVm value,
            Widget child) {
          return DefaultTabController(
            length: 2,
            child: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Scaffold(
                resizeToAvoidBottomInset: true,
                appBar: _buildAppBar(),
                body: _buildBody(context, value),
              ),
            ),
          );
        },
      ),
    );
  }

  PreferredSize _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(110.0),
      child: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              LocaleProvider.of(context).title_forgot_password,
              style: new TextStyle(
                color: R.color.blue,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),

        //
        leading: IconButton(
          icon: SvgPicture.asset(R.image.back_arrow_red),
          onPressed: () {
            Atom.historyBack();
          },
        ),

        //
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

  Widget _buildBody(BuildContext context, ForgotPasswordStep1ScreenVm value) {
    return TabBarView(
      children: [
        Container(
          color: Colors.white,
          child: Container(
            margin: EdgeInsets.all(30),
            child: KeyboardAvoider(
              autoScroll: true,
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      LocaleProvider.of(context).des_forgot_password_tc,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: R.color.grey),
                    ),
                    margin: EdgeInsets.only(bottom: 20),
                  ),

                  //
                  Container(
                    child: TextFormField(
                      controller: value.tcIdentity,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      obscureText: false,
                      style: inputTextStyle(),
                      decoration: inputImageDecoration(
                        hintText: LocaleProvider.of(context).tc_identity_number,
                        image: R.image.ic_user,
                      ),
                      focusNode: value.tcNoFNode,
                      inputFormatters: <TextInputFormatter>[
                        new TabToNextFieldTextInputFormatter(
                            context, value.tcNoFNode, value.phoneNumberFNode)
                      ],
                      onFieldSubmitted: (term) {
                        UtilityManager().fieldFocusChange(
                            context, value.tcNoFNode, value.phoneNumberFNode);
                      },
                    ),
                    margin: EdgeInsets.only(bottom: 20, top: 40),
                  ),

                  //
                  Container(
                    child: TextFormField(
                      controller: value.tcPhoneNumber,
                      style: inputTextStyle(),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      decoration: inputImageDecoration(
                        hintText: LocaleProvider.of(context).phone_number,
                        image: R.image.ic_phone_call_grey,
                      ),
                      focusNode: value.phoneNumberFNode,
                      inputFormatters: <TextInputFormatter>[
                        new TabToNextFieldTextInputFormatter(
                            context, value.phoneNumberFNode, null)
                      ],
                      onFieldSubmitted: (term) {
                        UtilityManager().fieldFocusChange(
                            context, value.phoneNumberFNode, null);
                      },
                    ),
                    margin: EdgeInsets.only(bottom: 20),
                  ),

                  //
                  Container(
                    child: button(
                        text: LocaleProvider.of(context).btn_next.toUpperCase(),
                        onPressed: () {
                          UserRegistrationStep1Model userRegisterStep1 =
                              new UserRegistrationStep1Model();
                          userRegisterStep1.userNationality = "TC";
                          userRegisterStep1.phoneNumber =
                              value.tcPhoneNumber.text;
                          userRegisterStep1.identificationNumber =
                              value.tcIdentity.text;
                          if (value.tcPhoneNumber.text.length > 0 &&
                              value.tcIdentity.text.length > 0) {
                            value.forgotPassStep1(userRegisterStep1);
                          } else {
                            value.showGradientDialog(
                                context,
                                LocaleProvider.of(context).warning,
                                LocaleProvider.of(context).fill_all_field);
                          }
                        }),
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                  ),

                  //
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          LocaleProvider.of(context).lbl_dont_have_account,
                          style: TextStyle(fontSize: 16, color: R.color.gray),
                        ),
                        InkWell(
                          child: Text(
                            LocaleProvider.of(context)
                                .btn_sign_up
                                .toUpperCase(),
                            style: TextStyle(fontSize: 16, color: R.color.blue),
                          ),
                          onTap: () {
                            Atom.to(PagePaths.REGISTER_STEP_1);
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),

        //
        new Container(
          child: Container(
            margin: EdgeInsets.all(30),
            child: ListView(
              children: <Widget>[
                Container(
                  child: Text(
                    LocaleProvider.of(context).des_forgot_password_other,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: R.color.grey),
                  ),
                  margin: EdgeInsets.only(bottom: 20),
                ),

                //
                Container(
                  child: TextFormField(
                    controller: value.fnPassport,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    style: inputTextStyle(),
                    decoration: inputImageDecoration(
                      hintText: LocaleProvider.of(context).passport_number,
                      image: R.image.ic_user,
                    ),
                    focusNode: value.ftcNoFNode,
                    inputFormatters: <TextInputFormatter>[
                      new TabToNextFieldTextInputFormatter(
                          context, value.ftcNoFNode, value.fphoneNumberFNode)
                    ],
                    onFieldSubmitted: (term) {
                      UtilityManager().fieldFocusChange(
                          context, value.ftcNoFNode, value.fphoneNumberFNode);
                    },
                  ),
                  margin: EdgeInsets.only(bottom: 20, top: 40),
                ),

                //
                Container(
                  child: TextFormField(
                    controller: value.fnPhone,
                    style: inputTextStyle(),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    decoration: inputImageDecoration(
                      hintText: LocaleProvider.of(context).phone_number,
                      image: R.image.ic_phone_call_grey,
                    ),
                    focusNode: value.fphoneNumberFNode,
                    inputFormatters: <TextInputFormatter>[
                      new TabToNextFieldTextInputFormatter(
                          context, value.fphoneNumberFNode, null)
                    ],
                    onFieldSubmitted: (term) {
                      UtilityManager().fieldFocusChange(
                          context, value.fphoneNumberFNode, null);
                    },
                  ),
                  margin: EdgeInsets.only(bottom: 20),
                ),

                //
                Container(
                  child: button(
                    text: LocaleProvider.of(context).btn_next.toUpperCase(),
                    onPressed: () {
                      UserRegistrationStep1Model userRegisterStep1 =
                          new UserRegistrationStep1Model();
                      userRegisterStep1.userNationality = "D";
                      userRegisterStep1.phoneNumber = value.fnPhone.text;
                      userRegisterStep1.identificationNumber =
                          value.fnPassport.text;
                      if (value.fnPhone.text.length > 0 &&
                          value.fnPassport.text.length > 0) {
                        value.forgotPassStep1(userRegisterStep1);
                      } else {
                        value.showGradientDialog(
                            context,
                            LocaleProvider.of(context).warning,
                            LocaleProvider.of(context).fill_all_field);
                      }
                    },
                  ),
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                ),

                //
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        LocaleProvider.of(context).lbl_dont_have_account,
                        style: TextStyle(fontSize: 16, color: R.color.gray),
                      ),
                      InkWell(
                        child: Text(
                          LocaleProvider.of(context).btn_sign_up.toUpperCase(),
                          style: TextStyle(fontSize: 16, color: R.color.blue),
                        ),
                        onTap: () {
                          Atom.to(PagePaths.REGISTER_STEP_1);
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
