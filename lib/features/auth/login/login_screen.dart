import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/src/core/extended_context.dart';
import 'package:vrouter/vrouter.dart';

import '../../../core/core.dart';
import 'login_vm.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _username = new TextEditingController();
  final TextEditingController _password = new TextEditingController();

  final usernameFNode = FocusNode();
  final passwordFNode = FocusNode();
  final focus = FocusNode();

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginScreenVm(context: context),
      child: Consumer<LoginScreenVm>(
        builder: (context, value, child) {
          _username.text = value.userId;
          _username.selection =
              TextSelection.collapsed(offset: value?.userId?.length ?? 0);
          _password.text = value.password;
          _password.selection =
              TextSelection.collapsed(offset: value?.password?.length ?? 0);

          return GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              body: Padding(
                padding: kIsWeb
                    ? EdgeInsets.only(
                        left: MediaQuery.of(context).size.width < 800
                            ? MediaQuery.of(context).size.width * 0.03
                            : MediaQuery.of(context).size.width * 0.10,
                        right: MediaQuery.of(context).size.width < 800
                            ? MediaQuery.of(context).size.width * 0.03
                            : MediaQuery.of(context).size.width * 0.10)
                    : EdgeInsets.zero,
                child: Container(
                  margin: EdgeInsets.all(30),
                  child: KeyboardAvoider(
                    autoScroll: true,
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          //
                          DropdownButton<Locale>(
                            hint: Text(
                                LocaleProvider.of(context).select_language +
                                        ": " +
                                        value?.locale?.toUpperCase() ??
                                    ""),
                            items: LocaleProvider.delegate.supportedLocales
                                .map((Locale value) {
                              return new DropdownMenuItem<Locale>(
                                value: value,
                                child:
                                    new Text(value.languageCode.toUpperCase()),
                              );
                            }).toList(),
                            onChanged: (valueLocale) {
                              value.setCurrentLocale(valueLocale.languageCode);
                            },
                          ),

                          //
                          Container(
                            child: Image.asset(
                              R.image.guven_logo,
                              height: 200,
                              width: 200,
                            ),
                            margin: EdgeInsets.only(bottom: 30),
                          ),

                          //
                          Container(
                            child: TextFormField(
                              controller: _username,
                              style: inputTextStyle(),
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              obscureText: false,
                              onChanged: (valueText) {
                                value.setUserIdText(valueText);
                              },
                              decoration: inputImageDecoration(
                                hintText: LocaleProvider.of(context)
                                    .email_or_identity,
                                image: R.image.ic_user,
                              ),
                              focusNode: usernameFNode,
                              inputFormatters: <TextInputFormatter>[
                                new TabToNextFieldTextInputFormatter(
                                    context, usernameFNode, passwordFNode),
                                /*FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9\t\r]'))*/
                              ],
                              onFieldSubmitted: (term) {
                                UtilityManager().fieldFocusChange(
                                    context, usernameFNode, passwordFNode);
                              },
                            ),
                            margin: EdgeInsets.only(bottom: 20),
                          ),

                          //
                          Container(
                            child: TextFormField(
                              controller: _password,
                              style: inputTextStyle(),
                              textInputAction: TextInputAction.done,
                              autocorrect: false,
                              enableSuggestions: false,
                              obscureText:
                                  value.passwordVisibility ? false : true,
                              onChanged: (valueText) {
                                value.setPasswordText(valueText);
                              },
                              decoration: inputImageDecoration(
                                hintText: LocaleProvider.of(context)
                                    .hint_input_password,
                                image: R.image.ic_password,
                                suffixIconClicked: () {
                                  value.togglePasswordVisibility();
                                },
                                suffixIcon: Icon(
                                  value.passwordVisibility
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: R.color.blue,
                                ),
                              ),
                              focusNode: passwordFNode,
                              inputFormatters: <TextInputFormatter>[
                                TabToNextFieldTextInputFormatter(
                                    context, passwordFNode, null)
                              ],
                              onFieldSubmitted: (term) {
                                UtilityManager().fieldFocusChange(
                                    context, passwordFNode, null);
                              },
                            ),
                          ),

                          //
                          Container(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Row(
                                children: <Widget>[
                                  Checkbox(
                                    value: value.rememberMeChecked,
                                    onChanged: (newValue) {
                                      value.toggleRememberMeChecked();
                                    },
                                    activeColor:
                                        R.color.blue, //  <-- leading Checkbox
                                  ),
                                  Text(
                                    LocaleProvider.current.btn_remember_me,
                                    style: TextStyle(fontSize: 16),
                                  )
                                ],
                              ),
                            ),
                          ),

                          //
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(top: 20, bottom: 20),
                                ),
                              ),
                              InkWell(
                                child: Text(
                                  LocaleProvider.of(context)
                                      .lbl_forgot_password,
                                  style: TextStyle(
                                      fontSize: 16, color: R.color.blue),
                                ),
                                onTap: () {
                                  Atom.to(PagePaths.FORGOT_PASSWORD_STEP_1);
                                },
                              )
                            ],
                          ),

                          //
                          kIsWeb
                              ? Container(
                                  child: value.versionCheckProgress ==
                                          VersionCheckProgress.LOADING
                                      ? Column(
                                          children: <Widget>[
                                            LoadingDialog(),
                                            Text(LocaleProvider.of(context)
                                                .check_for_updates)
                                          ],
                                        )
                                      : button(
                                          text: LocaleProvider.of(context)
                                              .btn_sign_in,
                                          onPressed: () {
                                            value.login(
                                                _username.text, _password.text);
                                          },
                                        ),
                                )
                              : Container(
                                  child: value.versionCheckProgress ==
                                          VersionCheckProgress.LOADING
                                      ? Column(
                                          children: <Widget>[
                                            LoadingDialog(),
                                            Text(LocaleProvider.of(context)
                                                .check_for_updates)
                                          ],
                                        )
                                      : value.versionCheckProgress ==
                                                  VersionCheckProgress.DONE &&
                                              value.needForceUpdate == false
                                          ? button(
                                              text: LocaleProvider.of(context)
                                                  .btn_sign_in,
                                              onPressed: () {
                                                value.login(_username.text,
                                                    _password.text);
                                              })
                                          : value.needForceUpdate == true &&
                                                  value.versionCheckProgress !=
                                                      VersionCheckProgress.ERROR
                                              ? button(
                                                  onPressed: () {
                                                    value
                                                        .startAppVersionOperation();
                                                  },
                                                  text:
                                                      LocaleProvider.of(context)
                                                          .update_now)
                                              : button(
                                                  text:
                                                      LocaleProvider.of(context)
                                                          .try_again,
                                                  onPressed: () {
                                                    value
                                                        .startAppVersionOperation();
                                                  },
                                                ),
                                  margin: EdgeInsets.only(top: 20, bottom: 20),
                                ),

                          //
                          Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  LocaleProvider.of(context)
                                      .lbl_dont_have_account,
                                  style: TextStyle(
                                      fontSize: 16, color: R.color.gray),
                                ),
                                InkWell(
                                  child: Text(
                                    LocaleProvider.of(context)
                                        .btn_sign_up
                                        .toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 16, color: R.color.blue),
                                  ),
                                  onTap: () {
                                    context.vRouter
                                        .to(PagePaths.REGISTER_STEP_1);
                                  },
                                ),
                              ],
                            ),
                          ),

                          //
                          Row(
                            children: [
                              //
                              Container(
                                alignment: Alignment.bottomLeft,
                                child: Checkbox(
                                  value: value.clickedGeneralForm,
                                  onChanged: (newValue) {
                                    value.showApplicationContestForm();
                                  },
                                  activeColor:
                                      R.color.blue, //  <-- leading Checkbox
                                ),
                              ),

                              //
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    value.showApplicationContestForm();
                                  },
                                  child: Text(
                                    LocaleProvider.of(context)
                                        .accept_application_consent_form,
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
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.bottomLeft,
                                child: Checkbox(
                                  value: value.checkedKvkkForm,
                                  onChanged: (newValue) {
                                    value.showKvkkInfo();
                                  },
                                  activeColor:
                                      R.color.blue, //  <-- leading Checkbox
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () => {value.showKvkkInfo()},
                                  child: Text(
                                    LocaleProvider.of(context)
                                        .read_understood_kvkk,
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
                          SizedBox(
                            height: 5,
                          ),

                          //
                          Text(
                            "v" + getIt<GuvenSettings>().version,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
