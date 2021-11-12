import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:provider/provider.dart';

import '../../../core/core.dart';
import '../../../model/model.dart';
import 'forgot_password_step2_vm.dart';

class ForgotPasswordStep2Screen extends StatefulWidget {
  String identityNumber;

  ForgotPasswordStep2Screen({
    Key key,
    this.identityNumber,
  }) : super(key: key);

  @override
  _ForgotPasswordStep2ScreenState createState() =>
      _ForgotPasswordStep2ScreenState();
}

class _ForgotPasswordStep2ScreenState extends State<ForgotPasswordStep2Screen> {
  @override
  Widget build(BuildContext context) {
    try {
      widget.identityNumber = Atom.queryParameters['identityNumber'];
    } catch (_) {
      return RbioError();
    }

    return ChangeNotifierProvider<ForgotPasswordStep2ScreenVm>(
      create: (context) => ForgotPasswordStep2ScreenVm(context: context),
      child: Consumer<ForgotPasswordStep2ScreenVm>(
        builder: (context, value, child) {
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
                  appBar: PreferredSize(
                    preferredSize: Size.fromHeight(90.0),
                    child: AppBar(
                      backgroundColor: Colors.white,
                      centerTitle: true,
                      title: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          SizedBox(height: 20),
                          Text(
                            LocaleProvider.of(context).create_password,
                            style: new TextStyle(
                              color: R.color.blue,
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                      leading: IconButton(
                        icon: SvgPicture.asset(R.image.back_arrow_red),
                        onPressed: () {
                          Atom.historyBack();
                        },
                      ),
                    ),
                  ),
                  body: new Container(
                    child: Container(
                      margin: EdgeInsets.all(30),
                      child: KeyboardAvoider(
                        autoScroll: true,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: TextFormField(
                                controller: value.temporaryController,
                                textInputAction: TextInputAction.next,
                                obscureText:
                                    value.passwordVisibility ? false : true,
                                style: inputTextStyle(),
                                decoration: inputImageDecoration(
                                    hintText: LocaleProvider.of(context)
                                        .temporary_pass,
                                    image: R.image.ic_password,
                                    suffixIconClicked: () {
                                      value.togglePasswordVisibility();
                                    },
                                    suffixIcon: Icon(
                                      value.passwordVisibility
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: R.color.blue,
                                    )),
                                onFieldSubmitted: (_) =>
                                    FocusScope.of(context).nextFocus(),
                              ),
                              margin: EdgeInsets.only(bottom: 20, top: 40),
                            ),
                            Container(
                              child: TextFormField(
                                controller: value.passwordController,
                                textInputAction: TextInputAction.next,
                                obscureText:
                                    value.passwordVisibility ? false : true,
                                onChanged: (text) {
                                  value.checkPasswordCapability(text);
                                },
                                style: inputTextStyle(),
                                decoration: inputImageDecoration(
                                    hintText:
                                        LocaleProvider.of(context).new_password,
                                    image: R.image.ic_password,
                                    suffixIconClicked: () {
                                      value.togglePasswordVisibility();
                                    },
                                    suffixIcon: Icon(
                                      value.passwordVisibility
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: R.color.blue,
                                    )),
                                onFieldSubmitted: (_) =>
                                    FocusScope.of(context).nextFocus(),
                              ),
                              margin: EdgeInsets.only(bottom: 20),
                            ),
                            Container(
                              child: TextFormField(
                                controller: value.passwordAgainController,
                                textInputAction: TextInputAction.done,
                                obscureText:
                                    value.passwordVisibility ? false : true,
                                style: inputTextStyle(),
                                decoration: inputImageDecoration(
                                    hintText: LocaleProvider.of(context)
                                        .new_password_again,
                                    image: R.image.ic_password,
                                    suffixIconClicked: () {
                                      value.togglePasswordVisibility();
                                    },
                                    suffixIcon: Icon(
                                      value.passwordVisibility
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: R.color.blue,
                                    )),
                                onFieldSubmitted: (_) =>
                                    FocusScope.of(context).nextFocus(),
                              ),
                              margin: EdgeInsets.only(bottom: 20),
                            ),
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  child: Checkbox(
                                    value: value.checkNumeric,
                                    onChanged: (value) {},
                                    activeColor:
                                        R.color.blue, //// <-- leading Checkbox
                                  ),
                                ),
                                Text(
                                    LocaleProvider.of(context)
                                        .must_contain_digit,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: R.color.black,
                                    )),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  child: Checkbox(
                                    value: value.checkUpperCase,
                                    onChanged: (value) {},
                                    activeColor:
                                        R.color.blue, //  <-- leading Checkbox
                                  ),
                                ),
                                Text(
                                    LocaleProvider.of(context)
                                        .must_contain_uppercase,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: R.color.black,
                                    )),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  child: Checkbox(
                                    value: value.checkLowerCase,
                                    onChanged: (value) {},
                                    activeColor:
                                        R.color.blue, //  <-- leading Checkbox
                                  ),
                                ),
                                Text(
                                    LocaleProvider.of(context)
                                        .must_contain_lowercase,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: R.color.black,
                                    )),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  child: Checkbox(
                                    value: value.checkSpecial,
                                    onChanged: (value) {},
                                    activeColor:
                                        R.color.blue, //  <-- leading Checkbox
                                  ),
                                ),
                                Text(
                                    LocaleProvider.of(context)
                                        .must_contain_special,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: R.color.black,
                                    )),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  child: Checkbox(
                                    value: value.checkLength,
                                    onChanged: (value) {},
                                    activeColor:
                                        R.color.blue, //  <-- leading Checkbox
                                  ),
                                ),
                                Text(
                                    LocaleProvider.of(context)
                                        .password_must_8_char,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: R.color.black,
                                    )),
                              ],
                            ),
                            Container(
                              child: button(
                                  text: LocaleProvider.of(context)
                                      .btn_done
                                      .toUpperCase(),
                                  onPressed: () {
                                    ChangePasswordModel changePasswordModel =
                                        new ChangePasswordModel();
                                    changePasswordModel.identificationNumber =
                                        widget.identityNumber;
                                    changePasswordModel
                                            .newPasswordConfirmation =
                                        value.passwordAgainController.text;
                                    changePasswordModel.newPassword =
                                        value.passwordController.text;
                                    changePasswordModel.oldPassword =
                                        value.temporaryController.text;
                                    if (value.temporaryController.text.length >
                                            0 &&
                                        value.passwordController.text.length >
                                            0 &&
                                        value.passwordAgainController.text
                                                .length >
                                            0) {
                                      value
                                          .forgotPassStep2(changePasswordModel);
                                    } else {
                                      value.showGradientDialog(
                                          context,
                                          LocaleProvider.of(context).warning,
                                          LocaleProvider.of(context)
                                              .fill_all_field);
                                    }
                                  }),
                              margin: EdgeInsets.only(top: 20, bottom: 20),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
