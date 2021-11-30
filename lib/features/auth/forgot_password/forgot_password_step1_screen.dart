import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:onedosehealth/core/widgets/rbio_appbar_login.dart';
import 'package:provider/provider.dart';

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
          return GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: RbioAppBarLogin(),
              body: _buildBody(context, value),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, ForgotPasswordStep1ScreenVm value) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: KeyboardAvoider(
        autoScroll: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0, left: 25, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      "Recover your password",
                      style: context.xHeadline1.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: context.TEXTSCALE * 30),
                    ),
                  ),
                  Text(
                    "Select the way for recovery.",
                    style: context.xHeadline3,
                  ),
                ],
              ),
            ),

            //
            Padding(
              padding: EdgeInsets.only(bottom: 30, top: 5, right: 15, left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0, left: 10),
                    child: Text(
                      LocaleProvider.current.tc_identity_number,
                      style: context.xHeadline3,
                    ),
                  ),
                  TextFormField(
                    controller: value.tcIdentity,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    style: inputTextStyle(),
                    decoration: inputDecorationForLogin(
                      hintText: LocaleProvider.of(context).tc_identity_number,
                    ).copyWith(
                        filled: true,
                        fillColor: getIt<ITheme>().cardBackgroundColor),
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
                ],
              ),
            ),

            //

            //
            Padding(
              padding: EdgeInsets.only(bottom: 30, top: 5, right: 15, left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0, left: 10),
                    child: Text(
                      LocaleProvider.current.phone_number,
                      style: context.xHeadline3,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: R.color.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: CountryCodePicker(
                          padding: EdgeInsets.zero,
                          onChanged: print,
                          initialSelection: 'IT',
                          favorite: ['+39', 'FR'],
                          showCountryOnly: false,
                          showOnlyCountryWhenClosed: false,
                          alignLeft: false,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: value.tcPhoneNumber,
                          style: inputTextStyle(),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.phone,
                          decoration: inputDecorationForLogin(
                            hintText: LocaleProvider.of(context).phone_number,
                          ).copyWith(
                              filled: true,
                              fillColor: getIt<ITheme>().cardBackgroundColor),
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
                      ),
                    ],
                  ),
                ],
              ),
            ),

            //
            Container(
              child: button(
                  text: LocaleProvider.of(context).btn_next.toUpperCase(),
                  onPressed: () {
                    UserRegistrationStep1Model userRegisterStep1 =
                        new UserRegistrationStep1Model();
                    userRegisterStep1.userNationality = "TC";
                    userRegisterStep1.phoneNumber = value.tcPhoneNumber.text;
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
              margin: EdgeInsets.only(top: 20, bottom: 20, right: 15, left: 15),
            ),

            //
            Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    LocaleProvider.of(context).lbl_dont_have_account,
                    style: context.xHeadline3
                        .copyWith(color: getIt<ITheme>().grey),
                  ),
                  InkWell(
                    child: Text(
                      LocaleProvider.of(context).btn_sign_up,
                      style: context.xHeadline3
                          .copyWith(color: getIt<ITheme>().mainColor),
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
    );
  }
}
