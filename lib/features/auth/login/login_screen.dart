import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:onedosehealth/core/widgets/rbio_appbar_login.dart';
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

    // SystemChrome.setPreferredOrientations(
    //   [
    //     DeviceOrientation.portraitUp,
    //     DeviceOrientation.portraitDown,
    //   ],
    // );
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
            child: RbioScaffold(
              appbar: RbioAppBarLogin(
                  title: Image.asset(R.image.oneDoseHealthPng, height: 50)),
              resizeToAvoidBottomInset: true,
              body: KeyboardAvoider(
                autoScroll: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //
                    /*DropdownButton<Locale>(
                      hint: Text(
                          LocaleProvider.of(context).select_language +
                                  ": " +
                                  value?.locale?.toUpperCase() ??
                              ""),
                      items: LocaleProvider.delegate.supportedLocales
                          .map((Locale value) {
                        return new DropdownMenuItem<Locale>(
                          value: value,
                          child: new Text(value.languageCode.toUpperCase()),
                        );
                      }).toList(),
                      onChanged: (valueLocale) {
                        value.setCurrentLocale(valueLocale.languageCode);
                      },
                    ),*/

                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0, left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Text(
                              "Login",
                              style: context.xHeadline1
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            "The future of healthcare!",
                            style: context.xHeadline3
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),

                    //
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                          child: Text(
                            "E-Mail / T.C. no / Passport no",
                            style: context.xHeadline3
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
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
                            decoration: inputDecorationForLogin(
                              hintText:
                                  LocaleProvider.of(context).email_or_identity,
                              //image: R.image.ic_user,
                            ).copyWith(
                              filled: true,
                              fillColor: Colors.white,
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
                      ],
                    ),

                    //
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                          child: Text("Password",
                              style: context.xHeadline3
                                  .copyWith(fontWeight: FontWeight.bold)),
                        ),
                        TextFormField(
                          controller: _password,
                          style: inputTextStyle(),
                          textInputAction: TextInputAction.done,
                          autocorrect: false,
                          enableSuggestions: false,
                          obscureText: value.passwordVisibility ? false : true,
                          onChanged: (valueText) {
                            value.setPasswordText(valueText);
                          },
                          decoration: inputDecorationForLogin(
                            hintText:
                                LocaleProvider.of(context).hint_input_password,
                            /*image: R.image.ic_password,
                            suffixIconClicked: () {
                              value.togglePasswordVisibility();
                            },
                            suffixIcon: Icon(
                              value.passwordVisibility
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: R.color.blue,
                            ),*/
                          ).copyWith(
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          focusNode: passwordFNode,
                          inputFormatters: <TextInputFormatter>[
                            TabToNextFieldTextInputFormatter(
                                context, passwordFNode, null)
                          ],
                          onFieldSubmitted: (term) {
                            UtilityManager()
                                .fieldFocusChange(context, passwordFNode, null);
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Row(
                                children: <Widget>[
                                  Checkbox(
                                    value: value.rememberMeChecked,
                                    onChanged: (newValue) {
                                      value.toggleRememberMeChecked();
                                    },
                                    activeColor: getIt<ITheme>()
                                        .mainColor, //  <-- leading Checkbox
                                  ),
                                  Text(
                                    LocaleProvider.current.btn_remember_me,
                                    style: context.xHeadline3.copyWith(
                                        color:
                                            getIt<ITheme>().textColorSecondary,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                            InkWell(
                              child: Text(
                                LocaleProvider.of(context).lbl_forgot_password,
                                style: context.xHeadline3
                                    .copyWith(color: getIt<ITheme>().mainColor),
                              ),
                              onTap: () {
                                Atom.to(PagePaths.FORGOT_PASSWORD_STEP_1);
                              },
                            )
                          ],
                        ),
                      ],
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
                            activeColor: getIt<ITheme>()
                                .mainColor, //  <-- leading Checkbox
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
                              style: context.xHeadline4.copyWith(
                                  decoration: TextDecoration.underline),
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
                            activeColor: getIt<ITheme>()
                                .mainColor, //  <-- leading Checkbox
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () => {value.showKvkkInfo()},
                            child: Text(
                              LocaleProvider.of(context).read_understood_kvkk,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: context.xHeadline4.copyWith(
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                      ],
                    ),

                    //
                    kIsWeb
                        ? Column(
                            children: [
                              Container(
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
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    LocaleProvider.of(context)
                                        .lbl_dont_have_account,
                                    style: context.xHeadline3.copyWith(
                                        color:
                                            getIt<ITheme>().textColorSecondary,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  InkWell(
                                    child: Text(
                                        LocaleProvider.of(context)
                                            .btn_sign_up
                                            .toUpperCase(),
                                        style: context.xHeadline3.copyWith(
                                            color: getIt<ITheme>().mainColor)),
                                    onTap: () {
                                      context.vRouter
                                          .to(PagePaths.REGISTER_FIRST);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              Container(
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
                                                text: LocaleProvider.of(context)
                                                    .update_now)
                                            : button(
                                                text: LocaleProvider.of(context)
                                                    .try_again,
                                                onPressed: () {
                                                  value
                                                      .startAppVersionOperation();
                                                },
                                              ),
                                margin: EdgeInsets.only(top: 20, bottom: 20),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    LocaleProvider.of(context)
                                        .lbl_dont_have_account,
                                    style: context.xHeadline3.copyWith(
                                        color:
                                            getIt<ITheme>().textColorSecondary,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  InkWell(
                                    child: Text(
                                        LocaleProvider.of(context)
                                            .btn_sign_up
                                            .toUpperCase(),
                                        style: context.xHeadline3.copyWith(
                                            color: getIt<ITheme>().mainColor)),
                                    onTap: () {
                                      context.vRouter.to(PagePaths
                                          .REGISTER_FIRST); //---> REGISTER_FIRST
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),

                    //
                    SizedBox(
                      height: 5,
                    ),

                    //
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: getIt<ITheme>()
                                .textColorSecondary
                                .withOpacity(0.4),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "or",
                            style: context.xHeadline3.copyWith(
                              color: getIt<ITheme>()
                                  .textColorSecondary
                                  .withOpacity(0.4),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: getIt<ITheme>()
                                .textColorSecondary
                                .withOpacity(0.4),
                          ),
                        ),
                      ],
                    ),

                    //
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(
                          R.image.facebook,
                          width: 50,
                        ),
                        SvgPicture.asset(
                          R.image.apple,
                          width: 50,
                        ),
                        SvgPicture.asset(
                          R.image.google,
                          width: 50,
                        ),
                      ],
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
          );
        },
      ),
    );
  }
}
