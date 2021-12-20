import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/src/core/extended_context.dart';
import 'package:vrouter/vrouter.dart';

import '../../../core/core.dart';
import '../viewmodel/login_vm.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  final usernameFNode = FocusNode();
  final passwordFNode = FocusNode();
  final focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginScreenVm(context: context),
      child: Consumer<LoginScreenVm>(
        builder: (
          BuildContext context,
          LoginScreenVm value,
          Widget child,
        ) {
          _username.text = value.userId;
          _username.selection =
              TextSelection.collapsed(offset: value?.userId?.length ?? 0);
          _password.text = value.password;
          _password.selection =
              TextSelection.collapsed(offset: value?.password?.length ?? 0);

          return _buildScreen(value);
        },
      ),
    );
  }

  Widget _buildScreen(LoginScreenVm value) {
    return KeyboardDismissOnTap(
      child: RbioScaffold(
        resizeToAvoidBottomInset: true,
        appbar: RbioAppBarLogin(
          leading: SizedBox(),
          title: Image.asset(
            R.image.oneDoseHealthPng,
            height: 50,
          ),
        ),
        body: _buildBody(value),
      ),
    );
  }

  Widget _buildBody(LoginScreenVm value) {
    return KeyboardAvoider(
      autoScroll: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildHeader(),

          //
          _buildEmail(value),

          //
          _buildPassword(value),

          //
          _buildRememberMe(value),

          //
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.WIDTH * 0.1),
            child: Column(
              children: [
                //
                _buildApplicationContest(value),

                //
                _buildKVKK(value),

                //
                _buildSignIn(value),
              ],
            ),
          ),

          //
          SizedBox(
            height: 5,
          ),

          //
          //   _buildSeperator(),

          //
          //    _buildSocialLogin(),

          //
          _buildVersion(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Text(
              LocaleProvider.current.login,
              style: context.xHeadline1.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            LocaleProvider.current.login_page_text,
            style: context.xHeadline3,
          ),
        ],
      ),
    );
  }

  Widget _buildEmail(LoginScreenVm value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0, bottom: 5),
          child: Text(
            LocaleProvider.current.sign_in_keys,
            style: context.xHeadline3,
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: RbioTextFormField(
            obscureText: false,
            controller: _username,
            focusNode: usernameFNode,
            textInputAction: TextInputAction.next,
            hintText: LocaleProvider.of(context).email_or_identity,
            inputFormatters: <TextInputFormatter>[
              TabToNextFieldTextInputFormatter(
                context,
                usernameFNode,
                passwordFNode,
              ),
            ],
            onChanged: (valueText) {
              value.setUserIdText(valueText);
            },
            onFieldSubmitted: (term) {
              UtilityManager().fieldFocusChange(
                context,
                usernameFNode,
                passwordFNode,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPassword(LoginScreenVm value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0, bottom: 5),
          child: Text(
            LocaleProvider.current.password,
            style: context.xHeadline3,
          ),
        ),
        RbioTextFormField(
          autocorrect: false,
          controller: _password,
          focusNode: passwordFNode,
          enableSuggestions: false,
          textInputAction: TextInputAction.done,
          obscureText: value.passwordVisibility ? false : true,
          hintText: LocaleProvider.of(context).hint_input_password,
          inputFormatters: <TextInputFormatter>[
            TabToNextFieldTextInputFormatter(context, passwordFNode, null)
          ],
          onChanged: (valueText) {
            value.setPasswordText(valueText);
          },
          onFieldSubmitted: (term) {
            UtilityManager().fieldFocusChange(
              context,
              passwordFNode,
              null,
            );
          },
        ),
      ],
    );
  }

  Widget _buildRememberMe(LoginScreenVm value) {
    return Row(
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
                activeColor: getIt<ITheme>().mainColor,
              ),
              Text(
                LocaleProvider.current.btn_remember_me,
                style: context.xHeadline3.copyWith(
                  color: getIt<ITheme>().textColorSecondary,
                ),
              )
            ],
          ),
        ),
        InkWell(
          child: Text(
            LocaleProvider.of(context).lbl_forgot_password,
            style: context.xHeadline3.copyWith(
              color: getIt<ITheme>().mainColor,
            ),
          ),
          onTap: () {
            Atom.to(PagePaths.FORGOT_PASSWORD_STEP_1);
          },
        )
      ],
    );
  }

  Widget _buildApplicationContest(LoginScreenVm value) {
    return Row(
      children: [
        //
        Container(
          alignment: Alignment.bottomLeft,
          child: Checkbox(
            value: value.clickedGeneralForm,
            onChanged: (newValue) {
              value.showApplicationContestForm();
            },
            activeColor: getIt<ITheme>().mainColor,
          ),
        ),

        //
        Expanded(
          child: InkWell(
            onTap: () {
              value.showApplicationContestForm();
            },
            child: Text(
              LocaleProvider.of(context).accept_application_consent_form,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: context.xHeadline4.copyWith(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildKVKK(LoginScreenVm value) {
    return Row(
      children: [
        Container(
          alignment: Alignment.bottomLeft,
          child: Checkbox(
            value: value.checkedKvkkForm,
            onChanged: (newValue) {
              value.showKvkkInfo();
            },
            activeColor: getIt<ITheme>().mainColor,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: InkWell(
              onTap: () => {value.showKvkkInfo()},
              child: Text(
                LocaleProvider.of(context).read_understood_kvkk,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: context.xHeadline4.copyWith(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignIn(LoginScreenVm value) {
    return kIsWeb
        ? SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  child:
                      value.versionCheckProgress == VersionCheckProgress.LOADING
                          ? Column(
                              children: <Widget>[
                                LoadingDialog(),
                                Text(
                                  LocaleProvider.of(context).check_for_updates,
                                ),
                              ],
                            )
                          : Utils.instance.button(
                              text: LocaleProvider.of(context).btn_sign_in,
                              onPressed: () {
                                value.login(
                                  _username.text,
                                  _password.text,
                                );
                              },
                            ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      LocaleProvider.of(context).lbl_dont_have_account,
                      style: context.xHeadline3.copyWith(
                        color: getIt<ITheme>().textColorSecondary,
                      ),
                    ),
                    InkWell(
                      child: Text(
                        LocaleProvider.of(context).btn_sign_up,
                        style: context.xHeadline3.copyWith(
                          color: getIt<ITheme>().mainColor,
                        ),
                      ),
                      onTap: () {
                        context.vRouter.to(PagePaths.REGISTER_FIRST);
                      },
                    ),
                  ],
                ),
              ],
            ),
          )
        : SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: value.versionCheckProgress ==
                          VersionCheckProgress.LOADING
                      ? Column(
                          children: <Widget>[
                            LoadingDialog(),
                            Text(
                              LocaleProvider.of(context).check_for_updates,
                            ),
                          ],
                        )
                      : value.versionCheckProgress ==
                                  VersionCheckProgress.DONE &&
                              value.needForceUpdate == false
                          ? Utils.instance.button(
                              text: LocaleProvider.of(context).btn_sign_in,
                              onPressed: () {
                                value.login(_username.text, _password.text);
                              },
                            )
                          : value.needForceUpdate == true &&
                                  value.versionCheckProgress !=
                                      VersionCheckProgress.ERROR
                              ? Utils.instance.button(
                                  onPressed: () {
                                    value.startAppVersionOperation();
                                  },
                                  text: LocaleProvider.of(context).update_now,
                                )
                              : Utils.instance.button(
                                  text: LocaleProvider.of(context).try_again,
                                  onPressed: () {
                                    value.startAppVersionOperation();
                                  },
                                ),
                ),

                //
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      LocaleProvider.of(context).lbl_dont_have_account,
                      style: context.xHeadline3.copyWith(
                        color: getIt<ITheme>().textColorSecondary,
                      ),
                    ),
                    InkWell(
                      child: Text(
                        LocaleProvider.of(context).btn_sign_up,
                        style: context.xHeadline3.copyWith(
                          color: getIt<ITheme>().mainColor,
                        ),
                      ),
                      onTap: () {
                        context.vRouter.to(PagePaths.REGISTER_FIRST);
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
  }

  Widget _buildSeperator() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: getIt<ITheme>().textColorSecondary.withOpacity(0.4),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            "or",
            style: context.xHeadline3.copyWith(
              color: getIt<ITheme>().textColorSecondary.withOpacity(0.4),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: getIt<ITheme>().textColorSecondary.withOpacity(0.4),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialLogin() {
    return Row(
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
    );
  }

  Widget _buildVersion() {
    return Text(
      "v" + getIt<GuvenSettings>().version,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 12,
      ),
    );
  }
}
