import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/constants.dart';
import '../../../core/core.dart';
import '../../../generated/l10n.dart';
import 'change_password_vm.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChangePasswordScreenVm>(
      create: (context) => ChangePasswordScreenVm(context: context),
      child: Consumer<ChangePasswordScreenVm>(
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
                child: new Scaffold(
                  resizeToAvoidBottomInset: true,
                  appBar: MainAppBar(
                    context: context,
                    title: value.getTitleBar(context),
                    leading: ButtonBackWhite(context),
                  ),
                  body: new Container(
                    child: Container(
                      margin: EdgeInsets.all(30),
                      child: KeyboardAvoider(
                        autoScroll: true,
                        child: Column(
                          children: <Widget>[
                            Text(
                              LocaleProvider.current.password_security,
                              style:
                                  TextStyle(color: R.color.blue, fontSize: 14),
                            ),
                            Container(
                              child: TextFormField(
                                controller: value.oldPasswordController,
                                textInputAction: TextInputAction.next,
                                obscureText:
                                    value.passwordVisibility ? false : true,
                                style: inputTextStyle(),
                                decoration: inputImageDecoration(
                                    hintText: LocaleProvider.of(context)
                                        .hint_input_old_password,
                                    image: R.image.ic_password_small,
                                    suffixIconClicked: () {
                                      value.togglePasswordVisibility();
                                    },
                                    suffixIcon: Icon(
                                      value.passwordVisibility
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: R.color.blue,
                                    )),
                                focusNode: value.oldPasswordFNode,
                                inputFormatters: <TextInputFormatter>[
                                  new TabToNextFieldTextInputFormatter(
                                      context,
                                      value.oldPasswordFNode,
                                      value.passwordFNode)
                                ],
                                onFieldSubmitted: (term) {
                                  UtilityManager().fieldFocusChange(
                                      context,
                                      value.oldPasswordFNode,
                                      value.passwordFNode);
                                },
                              ),
                              margin: EdgeInsets.only(bottom: 20, top: 40),
                            ),
                            Container(
                              child: TextFormField(
                                controller: value.passwordController,
                                textInputAction: TextInputAction.next,
                                onChanged: (text) {
                                  value.checkPasswordCapability(text);
                                },
                                obscureText:
                                    value.passwordVisibility ? false : true,
                                style: inputTextStyle(),
                                decoration: inputImageDecoration(
                                    hintText: LocaleProvider.of(context)
                                        .hint_input_password,
                                    image: R.image.ic_password_again,
                                    suffixIconClicked: () {
                                      value.togglePasswordVisibility();
                                    },
                                    suffixIcon: Icon(
                                      value.passwordVisibility
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: R.color.blue,
                                    )),
                                focusNode: value.passwordFNode,
                                inputFormatters: <TextInputFormatter>[
                                  new TabToNextFieldTextInputFormatter(
                                      context,
                                      value.passwordFNode,
                                      value.passwordAgainFNode)
                                ],
                                onFieldSubmitted: (term) {
                                  UtilityManager().fieldFocusChange(
                                      context,
                                      value.passwordFNode,
                                      value.passwordAgainFNode);
                                },
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
                                        .password_again,
                                    image: R.image.ic_password_again,
                                    suffixIconClicked: () {
                                      value.togglePasswordVisibility();
                                    },
                                    suffixIcon: Icon(
                                      value.passwordVisibility
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: R.color.blue,
                                    )),
                                focusNode: value.passwordAgainFNode,
                                inputFormatters: <TextInputFormatter>[
                                  new TabToNextFieldTextInputFormatter(
                                      context, value.passwordAgainFNode, null)
                                ],
                                onFieldSubmitted: (term) {
                                  UtilityManager().fieldFocusChange(
                                      context, value.passwordAgainFNode, null);
                                },
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
                                    if (value.passwordAgainController.text.length >
                                            0 &&
                                        value.passwordController.text.length >
                                            0 &&
                                        value.oldPasswordController.text
                                                .length >
                                            0) {
                                      if (value.passwordController.text ==
                                          value.passwordAgainController.text) {
                                        value.changePassword();
                                      } else {
                                        value.showGradientDialog(
                                            context,
                                            LocaleProvider.of(context).warning,
                                            LocaleProvider.of(context)
                                                .pass_must_same);
                                      }
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
